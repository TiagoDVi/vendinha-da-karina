module.exports = function handler(_request, response) {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const anonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY;

  if (!url || !anonKey) {
    return response.status(503).json({ error: 'A conexão com o banco ainda não está configurada.' });
  }

  response.setHeader('Cache-Control', 'no-store');
  return response.status(200).json({ url, anonKey });
};
