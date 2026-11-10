// Preencha com os dados do seu projeto Supabase (Project Settings → API).
// A "anon public key" pode ficar pública: quem protege os dados são as regras do supabase.sql.
// NUNCA coloque aqui a chave "service_role".
window.BANCO_CONFIG = {
  supabaseUrl: "https://bwzqupfcmrnyzvzzixie.supabase.co",
  supabaseAnonKey: "sb_publishable_839hzKqhC9bNtGOE3O5hcw_v0HTaPuT",
  dominio: "bancotea.app",   // usuário "getulio" entra como getulio@bancotea.app
  sufixoSenha: "#tea",       // o app acrescenta isto à senha digitada (o Supabase exige ≥ 6 caracteres)
  nomes: { getulio: "Getúlio", bruno: "Bruno" }
};
