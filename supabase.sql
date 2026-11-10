-- Banco de Questões TEA/TSA — configuração do Supabase
-- Cole tudo no SQL Editor do projeto e clique em Run. Pode rodar de novo sem problema.

-- 1) Progresso de cada usuário (uma linha por pessoa)
create table if not exists public.progresso (
  user_id    uuid primary key references auth.users(id) on delete cascade,
  estado     jsonb not null default '{}'::jsonb,
  atualizado timestamptz not null default now()
);

-- a data de atualização vem sempre do servidor (evita problema de relógio entre aparelhos)
create or replace function public.progresso_carimbo() returns trigger
language plpgsql as $$
begin
  new.atualizado := clock_timestamp();
  return new;
end $$;
drop trigger if exists progresso_carimbo on public.progresso;
create trigger progresso_carimbo before insert or update on public.progresso
  for each row execute function public.progresso_carimbo();

-- cada um só lê e grava o próprio progresso
alter table public.progresso enable row level security;
drop policy if exists "ler o proprio progresso" on public.progresso;
drop policy if exists "criar o proprio progresso" on public.progresso;
drop policy if exists "atualizar o proprio progresso" on public.progresso;
create policy "ler o proprio progresso" on public.progresso
  for select to authenticated using (auth.uid() = user_id);
create policy "criar o proprio progresso" on public.progresso
  for insert to authenticated with check (auth.uid() = user_id);
create policy "atualizar o proprio progresso" on public.progresso
  for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- 2) Conteúdo (questões, figuras e resumos) num bucket PRIVADO: só quem fez login lê
insert into storage.buckets (id, name, public)
values ('conteudo', 'conteudo', false)
on conflict (id) do update set public = false;

drop policy if exists "logados leem o conteudo" on storage.objects;
create policy "logados leem o conteudo" on storage.objects
  for select to authenticated using (bucket_id = 'conteudo');

-- 3) Quem pode publicar conteúdo novo (página publicar.html): só o administrador
--    Troque o e-mail se o seu usuário de login for outro.
drop policy if exists "admin envia conteudo" on storage.objects;
drop policy if exists "admin atualiza conteudo" on storage.objects;
create policy "admin envia conteudo" on storage.objects
  for insert to authenticated
  with check (bucket_id = 'conteudo' and (auth.jwt() ->> 'email') = 'getulio@bancotea.app');
create policy "admin atualiza conteudo" on storage.objects
  for update to authenticated
  using (bucket_id = 'conteudo' and (auth.jwt() ->> 'email') = 'getulio@bancotea.app')
  with check (bucket_id = 'conteudo' and (auth.jwt() ->> 'email') = 'getulio@bancotea.app');
