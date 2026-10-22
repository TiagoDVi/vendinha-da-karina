-- Vendinha da Karina: catálogo do cardápio e controle de acesso da administração.
create table if not exists public.products (
  id bigint primary key,
  name text not null,
  description text not null,
  price numeric(10,2) not null check (price > 0),
  second_unit_price numeric(10,2) check (second_unit_price is null or second_unit_price > 0),
  emoji text not null default '🛍️',
  category text not null,
  image text,
  variable boolean not null default false,
  available boolean not null default true,
  updated_at timestamptz not null default now()
);

alter table public.products add column if not exists stock integer check (stock is null or stock >= 0);

alter table public.products enable row level security;
grant select on public.products to anon, authenticated;
grant insert, update, delete on public.products to authenticated;

drop policy if exists "Catálogo visível" on public.products;
create policy "Catálogo visível" on public.products
  for select to anon, authenticated using (true);

drop policy if exists "Somente a Karina administra produtos" on public.products;
create policy "Somente a Karina administra produtos" on public.products
  for all to authenticated
  using (lower(coalesce(auth.jwt() ->> 'email', '')) = 'nakajima.karina@gmail.com')
  with check (lower(coalesce(auth.jwt() ->> 'email', '')) = 'nakajima.karina@gmail.com');

insert into public.products (id, name, description, price, emoji, category, image, variable, available)
values
(1, 'Amanatto', 'Doce de fava (feijão cristalizado).', 20, '🍬', 'Orientais', 'imagens/produtos-recriados/amanatto-foto.jpg', false, true),
(2, 'Bala de ágar-ágar', 'Sabores sortidos: morango, abacaxi, limão e uva.', 20, '🍡', 'Doces', 'imagens/produtos-recriados/bala-agar-novo.png', false, true),
(3, 'Fukujinzuke · 150 g', 'Conserva de nabo, cenoura, berinjela, pepino, yamakurague, lenkon, gengibre e gergelim.', 15, '🥗', 'Orientais', 'imagens/produtos-recriados/fukujinzuke-cliente.jpeg', false, true),
(4, 'Geleia orgânica ou diet', 'Amora ou frutas vermelhas com açúcar orgânico; ou geleia de amora diet.', 30, '🍯', 'Caseiros', 'imagens/produtos-recriados/geleia-organica.jpg', false, true),
(5, 'Geleia de amora comum', 'Geleia artesanal de amora.', 25, '🫙', 'Caseiros', 'imagens/produtos-recriados/geleia-amora.jpg', false, true),
(6, 'Gyoza suína · 12 unidades', 'Carne suína, nirá, repolho e gengibre. Pode aquecer no vapor, grelhar ou fritar.', 20, '🥟', 'Orientais', 'imagens/produtos-recriados/gyoza.jpg', false, true),
(7, 'Hibisco Hanaume · 150 g', 'Conserva temperada apenas com sal.', 15, '🌺', 'Orientais', 'imagens/produtos-recriados/hibisco.jpg', false, true),
(8, 'Kakimochi', 'Salgadinho de arroz temperado com sal ou shoyu. Escolha o sabor na observação.', 25, '🍘', 'Orientais', 'imagens/produtos-recriados/kakimochi.jpg', false, true),
(9, 'Chips de lenkon · 50 g', 'Raiz de lótus crocante.', 15, '🪷', 'Orientais', 'imagens/produtos-recriados/lenkon-chips.jpg', false, true),
(10, 'Conserva de lenkon · 100 g', 'Picles de raiz de lótus.', 15, '🥢', 'Orientais', 'imagens/produtos-recriados/lenkon-conserva.jpg', false, true),
(11, 'Lenkon fresco · 1 kg', 'Raiz de lótus in natura.', 60, '🪷', 'Orientais', 'imagens/produtos-recriados/lenkon-fresco.jpg', false, true),
(12, 'Kimpira de lenkon · 100 g', 'Raiz de lótus refogada com shoyu.', 15, '🥘', 'Orientais', 'imagens/produtos-recriados/kimpira-lenkon.jpg', false, true),
(13, 'Chips de mandioca · 50 g', 'Mandioca crocante.', 12, '🍟', 'Caseiros', 'imagens/produtos-recriados/chips-mandioca.jpg', false, true),
(14, 'Mandioca descascada · 1 kg', 'Mandioca descascada e congelada.', 15, '🥔', 'Caseiros', 'imagens/produtos-recriados/mandioca-congelada.jpg', false, true),
(15, 'Kuri manjyu · 6 unidades', 'Receita tradicional da família, preparada com carinho.', 25, '🌰', 'Doces', 'imagens/produtos-recriados/kuri-manju-cliente.jpeg', false, true),
(16, 'Missô · 500 g', 'Pasta de soja preparada sem uso de soja transgênica.', 25, '🥣', 'Orientais', 'imagens/produtos-recriados/miso.jpg', false, true),
(17, 'Nikuman · 6 unidades', 'Pãezinhos recheados com carne suína e legumes.', 40, '🥟', 'Orientais', 'imagens/produtos-recriados/nikuman-novo.png', false, true),
(18, 'Ovos orgânicos · 20 unidades', 'Cartela com 20 ovos orgânicos.', 30, '🥚', 'Caseiros', 'imagens/produtos-recriados/ovos-organicos-novo.png', false, true),
(19, 'Ovos caipiras · 10 unidades', 'Galinhas criadas soltas no sítio, com alimentação natural.', 20, '🥚', 'Caseiros', 'imagens/produtos-recriados/ovos-caipiras.jpg', false, true),
(20, 'Queijo branco fresco · pequeno', 'Queijo branco fresco, feito em casa.', 25, '🧀', 'Caseiros', 'imagens/produtos-recriados/queijo-branco.jpg', false, true),
(21, 'Shoga cristalizado · 100 g', 'Gengibre cristalizado.', 15, '🫚', 'Doces', 'imagens/produtos-recriados/shoga.jpg', false, true),
(22, 'Shio koji · 250 ml', 'Sal fermentado com arroz. Realça o sabor; use em verduras, legumes ou carnes no lugar do shoyu.', 20, '🧂', 'Orientais', 'imagens/produtos-recriados/shio-koji.jpg', false, true),
(23, 'Suspiro · 50 g', 'Sabores café, matchá ou limão. Indique o sabor na observação.', 15, '☁️', 'Doces', 'imagens/produtos-recriados/suspiro.jpg', false, true),
(24, 'Tofu caseiro · 500 g', 'Produzido com soja não transgênica.', 25, '⬜', 'Orientais', 'imagens/produtos-recriados/tofu.jpg', false, true),
(25, 'Umeboshi · 150 g', 'Ameixa em conserva.', 15, '🫒', 'Orientais', 'imagens/produtos-recriados/umeboshi.jpg', false, true),
(26, 'Zabom cristalizado · 100 g', 'Cidra cristalizada.', 15, '🍋', 'Doces', 'imagens/produtos-recriados/zabom.jpg', false, true),
(27, 'Batata inglesa orgânica · kg', 'Produto de estação. Venda por quilo.', 15, '🥔', 'Hortifruti', 'imagens/produtos-recriados/batata-organica-novo.png', false, true),
(28, 'Coalhada · babaganuche · homus · 250 g', 'Escolha coalhada, babaganuche ou homus. Indique sua opção na observação.', 35, '🧆', 'Oriente Médio', 'imagens/produtos-recriados/oriente-medio.jpg', false, true),
(29, 'Doces árabes · bandeja', 'Bandeja com doces árabes. Preço médio; valor final a confirmar.', 70, '🍮', 'Oriente Médio', 'imagens/produtos-recriados/doces-arabes-novo.png', true, true),
(30, 'Pão árabe · 6 unidades', 'Fornecedor de Ribeirão Preto.', 30, '🫓', 'Oriente Médio', 'imagens/produtos-recriados/pao-arabe-novo.png', false, true),
(31, 'Pão folha · 6 unidades', 'Pão achatado, fornecedor de Ribeirão Preto.', 40, '🫓', 'Oriente Médio', 'imagens/produtos-recriados/pao-folha-novo.png', false, true)
on conflict (id) do nothing;
