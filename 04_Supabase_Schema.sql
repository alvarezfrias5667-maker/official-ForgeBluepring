-- ForgeBlueprint Public Reference Schema
-- This is a safe public reference schema.
-- Do not place production secrets or service role keys in this file.

create extension if not exists "pgcrypto";

create table if not exists public.user_access (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null unique references auth.users(id) on delete cascade,
  status text not null default 'inactive',
  blueprint_access boolean not null default false,
  blueprint_plan text,
  blueprint_credits integer not null default 0,
  blueprint_used integer not null default 0,
  blueprint_expires_at timestamptz,
  provider text default 'paypal',
  provider_ref text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.projects (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade,
  project_name text not null,
  blueprint_mode text not null,
  product_type text,
  target_audience text,
  monetization_direction text,
  execution_risk text,
  readiness_score integer,
  form_data jsonb not null default '{}'::jsonb,
  blueprint_data jsonb not null default '{}'::jsonb,
  status text not null default 'draft',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.download_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade,
  project_id uuid references public.projects(id) on delete set null,
  file_name text not null default 'ForgeBlueprint_Blueprint_Package.zip',
  blueprint_mode text,
  downloaded_at timestamptz not null default now()
);

create table if not exists public.scan_balance (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null unique references auth.users(id) on delete cascade,
  total_purchased integer not null default 0,
  scans_used integer not null default 0,
  scans_available integer generated always as (total_purchased - scans_used) stored,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.user_access enable row level security;
alter table public.projects enable row level security;
alter table public.download_logs enable row level security;
alter table public.scan_balance enable row level security;

drop policy if exists "read_own_access" on public.user_access;
create policy "read_own_access"
on public.user_access
for select
to authenticated
using (auth.uid() = user_id);

drop policy if exists "read_own_projects" on public.projects;
create policy "read_own_projects"
on public.projects
for select
to authenticated
using (auth.uid() = user_id);

drop policy if exists "insert_own_projects" on public.projects;
create policy "insert_own_projects"
on public.projects
for insert
to authenticated
with check (auth.uid() = user_id);

drop policy if exists "insert_own_downloads" on public.download_logs;
create policy "insert_own_downloads"
on public.download_logs
for insert
to authenticated
with check (auth.uid() = user_id);

drop policy if exists "read_own_scan_balance" on public.scan_balance;
create policy "read_own_scan_balance"
on public.scan_balance
for select
to authenticated
using (auth.uid() = user_id);

create index if not exists idx_user_access_user_id on public.user_access(user_id);
create index if not exists idx_projects_user_id on public.projects(user_id);
create index if not exists idx_projects_blueprint_mode on public.projects(blueprint_mode);
create index if not exists idx_download_logs_user_id on public.download_logs(user_id);
create index if not exists idx_scan_balance_user_id on public.scan_balance(user_id);
