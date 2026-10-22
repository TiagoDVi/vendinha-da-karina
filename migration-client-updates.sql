-- Atualização do cardápio e upload de fotos pelo painel administrativo.
-- Execute uma vez no Supabase: SQL Editor > New query > Run.

alter table public.products
  add column if not exists second_unit_price numeric(10,2)
  check (second_unit_price is null or second_unit_price > 0);

-- Atualiza os itens já cadastrados sem mexer no estoque nem no status de disponibilidade.
update public.products set price = 40 where id = 17;
update public.products set name = 'Queijo branco fresco · pequeno', price = 25 where id = 20;
update public.products set image = 'imagens/produtos-recriados/kuri-manju-cliente.jpeg' where id = 15;
update public.products set image = 'imagens/produtos-recriados/fukujinzuke-cliente.jpeg' where id = 3;

insert into public.products (id, name, description, price, second_unit_price, emoji, category, image, variable, available)
values
(32, 'Coxinha de shimeji', 'Coxinha de mandioca com recheio de shimeji. R$ 3,00 a primeira unidade e R$ 2,50 cada unidade adicional.', 3, 2.50, '🍗', 'Salgados', 'imagens/produtos-recriados/coxinha-shimeji-produto.png', false, true),
(33, 'Kimuchi estilo coreano · 250 g', 'Conserva coreana artesanal. Embalagem com aproximadamente 250 g.', 25, null, '🥬', 'Orientais', 'imagens/produtos-recriados/kimuchi-coreano-cliente.jpeg', false, true),
(34, 'Espaguete de espinafre · 250 g', 'Massa fresca com farinha, ovo caipira, sal, óleo e espinafre orgânico.', 25, null, '🍝', 'Caseiros', 'imagens/produtos-recriados/espaguete-espinafre-cliente.jpeg', false, true)
on conflict (id) do update set
  name = excluded.name,
  description = excluded.description,
  price = excluded.price,
  second_unit_price = excluded.second_unit_price,
  emoji = excluded.emoji,
  category = excluded.category,
  image = excluded.image,
  available = case when excluded.id = 32 then true else products.available end;

-- Bucket público para exibir fotos; somente a Karina autenticada pode enviar/alterar/excluir.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('product-images', 'product-images', true, 5242880, array['image/jpeg','image/png','image/webp'])
on conflict (id) do update set public = true, file_size_limit = 5242880,
  allowed_mime_types = array['image/jpeg','image/png','image/webp'];

grant select on storage.objects to anon, authenticated;
grant insert, update, delete on storage.objects to authenticated;
drop policy if exists "Fotos do cardápio visíveis" on storage.objects;
create policy "Fotos do cardápio visíveis" on storage.objects
  for select to anon, authenticated using (bucket_id = 'product-images');
drop policy if exists "Somente a Karina envia fotos do cardápio" on storage.objects;
create policy "Somente a Karina envia fotos do cardápio" on storage.objects
  for insert to authenticated with check (
    bucket_id = 'product-images'
    and lower(coalesce(auth.jwt() ->> 'email', '')) = 'nakajima.karina@gmail.com'
  );
drop policy if exists "Somente a Karina altera fotos do cardápio" on storage.objects;
create policy "Somente a Karina altera fotos do cardápio" on storage.objects
  for update to authenticated using (
    bucket_id = 'product-images'
    and lower(coalesce(auth.jwt() ->> 'email', '')) = 'nakajima.karina@gmail.com'
  ) with check (
    bucket_id = 'product-images'
    and lower(coalesce(auth.jwt() ->> 'email', '')) = 'nakajima.karina@gmail.com'
  );
drop policy if exists "Somente a Karina exclui fotos do cardápio" on storage.objects;
create policy "Somente a Karina exclui fotos do cardápio" on storage.objects
  for delete to authenticated using (
    bucket_id = 'product-images'
    and lower(coalesce(auth.jwt() ->> 'email', '')) = 'nakajima.karina@gmail.com'
  );
