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
