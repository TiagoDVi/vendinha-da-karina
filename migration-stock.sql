-- Execute no SQL Editor do Supabase antes de publicar a nova versão.
alter table public.products
  add column if not exists stock integer
  check (stock is null or stock >= 0);
