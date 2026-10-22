# Vendinha da Karina

Cardápio digital da Vendinha da Karina.

## Publicação

O projeto está conectado ao GitHub e à Vercel. Depois de enviar um commit para a branch `main`, a Vercel cria uma nova implantação automaticamente.

## Administração e pedidos

- Link público: página inicial do projeto na Vercel.
- Administração: acrescente `?admin=1` ao link público.
- Os pedidos são preparados para envio pelo WhatsApp da loja.

## Configuração do Supabase na Vercel

A rota `api/config.js` usa as variáveis de ambiente `NEXT_PUBLIC_SUPABASE_URL` e `NEXT_PUBLIC_SUPABASE_ANON_KEY` (ou `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY`). Configure-as no painel da Vercel para habilitar o login administrativo e a sincronização do catálogo.


## Atualizar catálogo e habilitar fotos

Antes de publicar esta versão, execute `migration-client-updates.sql` uma vez no SQL Editor do Supabase. A migração atualiza os preços/fotos solicitados, inclui Coxinha de shimeji, Kimuchi e Espaguete de espinafre, cria o campo do preço por unidade adicional e configura o armazenamento seguro das fotos.

No painel administrativo, a pessoa autorizada pode escolher uma foto da galeria do celular ou tirar uma nova foto em JPG, PNG ou WebP (até 5 MB), preencher nome, descrição, preço, categoria e estoque, e salvar. A foto fica armazenada no Supabase e aparece para todos os clientes.

O link de login usa o endereço de produção `https://project-otyd4.vercel.app/?admin=1`. Em **Supabase → Authentication → URL Configuration**, confirme o **Site URL** como `https://project-otyd4.vercel.app` e inclua `https://project-otyd4.vercel.app/**` na lista de redirecionamentos permitidos. Se o envio do e-mail continuar falhando, a tela agora mostra a mensagem retornada pelo Supabase; limites de envio ou configuração de SMTP precisam ser resolvidos no painel do Supabase.
