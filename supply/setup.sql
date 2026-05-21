-- Run this in Supabase > SQL Editor

create table supply_requests (
  id               uuid primary key default gen_random_uuid(),
  link             text not null,
  retailer         text,
  product_id       text,
  product_id_label text,
  name             text not null,
  store            text not null,
  qty              integer not null,
  urgency          text not null,
  notes            text,
  status           text not null default 'pending',
  created_at       timestamptz not null default now()
);

-- Allow the app's anon key to read and write rows
alter table supply_requests enable row level security;

create policy "Allow anon read"   on supply_requests for select using (true);
create policy "Allow anon insert" on supply_requests for insert with check (true);
create policy "Allow anon update" on supply_requests for update using (true);
create policy "Allow anon delete" on supply_requests for delete using (true);

-- Enable realtime so the order board updates live
alter publication supabase_realtime add table supply_requests;
