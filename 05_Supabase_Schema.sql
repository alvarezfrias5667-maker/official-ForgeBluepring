-- SUPABASE SCHEMA FOR FORGEBLUEPRINT MVP

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
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
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
alter table public.scan_balance enable row level security;

create policy "read_own_access"
on public.user_access
for select
to authenticated
using (auth.uid() = user_id);

create policy "read_own_scan_balance"
on public.scan_balance
for select
to authenticated
using (auth.uid() = user_id);
