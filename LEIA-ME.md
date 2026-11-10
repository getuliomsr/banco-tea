# Banco de Questões TEA/TSA: como colocar no ar

São duas peças:

- **site/**: o aplicativo (tela de login, banco, resumos). Vai para o **GitHub Pages**. Não contém nada do livro, então pode ficar num repositório público.
- **conteudo/**: questões, figuras e resumos do Miller. Vai para um armazenamento **privado** no **Supabase**, que também guarda o login e o histórico de cada um. Só quem faz login consegue abrir esses arquivos.

Tudo é gratuito. Leva uns 20 minutos na primeira vez.

---

## Parte 1: Supabase (login, histórico e conteúdo)

1. Entre em **supabase.com** → *Start your project* → entre com a sua conta do GitHub.
2. *New project*: nome `banco-tea`, crie uma senha do banco de dados (guarde-a, mas o app não usa), região **South America (São Paulo)**, plano Free.
3. Quando o projeto terminar de criar: menu **SQL Editor** → *New query* → cole todo o arquivo `supabase.sql` → **Run**. Deve aparecer “Success”.
4. Menu **Authentication** → **Sign In / Providers** (ou *Settings*): **desligue “Allow new users to sign up”**. Assim ninguém de fora cria conta. Deixe o provedor **Email** ligado.
5. **Authentication → Users → Add user → Create new user**. Crie os dois usuários, marcando **Auto Confirm User**:

   | Usuário no app | E-mail no Supabase | Senha no Supabase |
   |---|---|---|
   | getulio | `getulio@bancotea.app` | `getulio#tea` |
   | bruno | `bruno@bancotea.app` | `bruno#tea` |

   No app, vocês digitam só `getulio` / `getulio` e `bruno` / `bruno`. O app completa o e-mail e acrescenta `#tea` à senha, porque o Supabase exige pelo menos 6 caracteres. Nenhum e-mail é enviado; o endereço é só um identificador.
6. Menu **Project Settings → API** (em alguns painéis, *Data API* / *API Keys*): copie a **Project URL** e a chave **anon public** (ou *publishable key*). **Não** use a chave *service_role* / *secret*.

## Parte 2: GitHub Pages (o aplicativo)

1. No GitHub: **New repository** → nome `banco-tea` → **Public** (o Pages gratuito exige repositório público; lembre que ele só tem o app) → *Create repository*.
2. Clique em **uploading an existing file** e arraste **o conteúdo** da pasta `site/`: `index.html`, `config.js`, `publicar.html` e a pasta `resumos/`. Depois *Commit changes*.
3. No repositório, abra `config.js` → ícone de lápis → troque `https://SEU-PROJETO.supabase.co` e `COLE-AQUI-A-ANON-PUBLIC-KEY` pelos valores da Parte 1, item 6 → *Commit changes*.
4. **Settings → Pages** → *Source*: **Deploy from a branch** → branch `main`, pasta `/ (root)` → **Save**. Em 1–2 minutos aparece o endereço, algo como `https://SEU-USUARIO.github.io/banco-tea/`.

## Parte 3: Enviar o conteúdo

1. Abra `https://SEU-USUARIO.github.io/banco-tea/publicar.html`.
2. Usuário `getulio`, senha `getulio`, escolha a pasta **conteudo** (a pasta inteira) → **Enviar**. São ~110 arquivos; espere aparecer “Pronto”.
3. Abra o endereço principal e entre. Pronto: cada um tem o seu histórico, sincronizado entre celular e computador.

Só o usuário `getulio` consegue publicar conteúdo (regra no `supabase.sql`). Quando houver questões novas, eu gero uma nova pasta `conteudo/` e você reenvia por essa mesma página: os arquivos com o mesmo nome são substituídos.

---

## Como funciona o histórico

- As respostas ficam salvas no aparelho na hora e são enviadas para a conta ~1 s depois (“salvando…” → “✓ salvo na conta”, no topo).
- Sem internet, continua funcionando e envia quando a conexão voltar.
- Ao voltar para a aba (ou a cada minuto), o app busca o que você respondeu em outro aparelho.
- O histórico do banco que está no Claude não passa para cá: o novo começa zerado.

## Segurança, em resumo

- A URL e a chave *anon* ficam visíveis no `config.js`, e isso é normal: quem protege os dados são as regras do `supabase.sql` (cada um só lê e grava o próprio progresso; o conteúdo só abre com login).
- As senhas `getulio`/`bruno` são fracas. Para trocar depois: *Authentication → Users* → usuário → *Reset password* (ou mude direto), lembrando de acrescentar `#tea` ao final da senha nova.
- No plano gratuito, o Supabase pausa o projeto depois de 7 dias **sem nenhum acesso**; é só entrar no painel e clicar em *Restore*.
- Os arquivos do livro nunca vão para o GitHub. Mantenha assim.
