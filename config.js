// Preencha com os dados do seu projeto Supabase (Project Settings → API).
// A "anon public key" pode ficar pública: quem protege os dados são as regras do supabase.sql.
// NUNCA coloque aqui a chave "service_role".
window.BANCO_CONFIG = {
  supabaseUrl: "https://SEU-PROJETO.supabase.co",
  supabaseAnonKey: "COLE-AQUI-A-ANON-PUBLIC-KEY",
  dominio: "bancotea.app",   // usuário "getulio" entra como getulio@bancotea.app
  sufixoSenha: "#tea",       // o app acrescenta isto à senha digitada (o Supabase exige ≥ 6 caracteres)
  nomes: { getulio: "Getúlio", bruno: "Bruno" }
};
