create table if not exists public.kartstats_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.kartstats_data enable row level security;

drop policy if exists "Users manage own KartStats data" on public.kartstats_data;
create policy "Users manage own KartStats data"
on public.kartstats_data
for all
using (auth.uid() = user_id)
with check (auth.uid() = user_id);
