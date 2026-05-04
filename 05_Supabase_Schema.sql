-- 🔥 EXECUTION CONTEXT
-- This schema controls access to blueprint generation.
-- It must remain minimal and tied to the core product flow.
-- Do not extend with unnecessary tables during MVP.
-- FORGEBLUEPRINT — PRODUCTION-READY SUPABASE SCHEMA

create extension if not exists "pgcrypto";

--------------------------------------------------
-- USER ACCESS (Blueprint monetization control)
--------------------------------------------------

create table if not exists public.user_access (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null unique
    references auth.users(id) on delete cascade,

  status text not null default 'inactive',

  blueprint_plan text,
  blueprint_credits integer not null default 0,
  blueprint_used integer not null default 0,

  has_access boolean generated always as (blueprint_credits > blueprint_used) stored,

  provider text default 'paypal',
  provider_ref text unique,

  paid_at timestamptz,
  expires_at timestamptz,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

--------------------------------------------------
-- PROJECT STORAGE (CORE SYSTEM MEMORY)
--------------------------------------------------

create table if not exists public.projects (
  id uuid primary key default gen_random_uuid(),

  user_id uuid
    references auth.users(id) on delete cascade,

  project_name text not null,
  project_type text,

  form_data jsonb not null default '{}'::jsonb,
  blueprint_data jsonb not null default '{}'::jsonb,

  status text default 'draft',

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

--------------------------------------------------
-- DOWNLOAD TRACKING (REAL USAGE SIGNAL)
--------------------------------------------------

create table if not exists public.download_logs (
  id uuid primary key default gen_random_uuid(),

  user_id uuid
    references auth.users(id) on delete cascade,

  project_id uuid
    references public.projects(id) on delete cascade,

  file_name text,
  downloaded_at timestamptz default now()
);

--------------------------------------------------
-- INDEXES
--------------------------------------------------

create index if not exists idx_user_access_user on public.user_access(user_id);
create index if not exists idx_projects_user on public.projects(user_id);
create index if not exists idx_downloads_user on public.download_logs(user_id);

--------------------------------------------------
-- UPDATED_AT TRIGGER
--------------------------------------------------

create or replace function set_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

drop trigger if exists trg_user_access_updated on public.user_access;
create trigger trg_user_access_updated
before update on public.user_access
for each row execute function set_updated_at();

drop trigger if exists trg_projects_updated on public.projects;
create trigger trg_projects_updated
before update on public.projects
for each row execute function set_updated_at();

--------------------------------------------------
-- RLS POLICIES (CRÍTICO)
--------------------------------------------------

alter table public.user_access enable row level security;
alter table public.projects enable row level security;
alter table public.download_logs enable row level security;

-- USER ACCESS
create policy "read_own_access"
on public.user_access
for select
using (auth.uid() = user_id);

-- PROJECTS
create policy "read_own_projects"
on public.projects
for select
using (auth.uid() = user_id);

create policy "insert_own_projects"
on public.projects
for insert
with check (auth.uid() = user_id);

-- DOWNLOADS
create policy "insert_download_logs"
on public.download_logs
for insert
with check (auth.uid() = user_id);

create policy "read_own_downloads"
on public.download_logs
for select
using (auth.uid() = user_id);
