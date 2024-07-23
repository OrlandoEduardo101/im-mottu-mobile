# Features 
- [x] Firebase crash analytics
- [x] [clear cache when detached app](https://github.com/OrlandoEduardo101/im-mottu-mobile/commit/dfa23e4eb11a0f63982e5b538825d34b9fa997e0)
- [x] [Add pagination infinity list and filter with name in api](https://github.com/OrlandoEduardo101/im-mottu-mobile/commit/93fcb1402f2c66063545d270e0361493718d2b5c)
- [x] [add check connectivity with subscription and platform channel](https://github.com/OrlandoEduardo101/im-mottu-mobile/commit/2042b269030ff8bedeba55eb0fc3020138b8b7cb)
- [x] [add cache in a character request with shared preferences](https://github.com/OrlandoEduardo101/im-mottu-mobile/commit/2cfc8f9e2874dac9daf161dc3b06c923c12a1ee4)
- [x] [Add filter text](https://github.com/OrlandoEduardo101/im-mottu-mobile/commit/19605ea28af8974a4fe7f42d5dfc063d4f5c63f5)
- [x] [Add dark mode](https://github.com/OrlandoEduardo101/im-mottu-mobile/commit/5f41dca927a49588a82c327bf05bb7f5e2aacc21)
- [x] Structuring project
- [x] Listing characters
- [x] Showing character detail

# Demonstration

https://github.com/user-attachments/assets/813a58ae-4056-4179-84a8-131d1f1cee70



# 🛵 I'm Mottu Mobile 🛵

### Teste prático para desenvolvedores Mobile Mottu


> *Este teste está separado em 3 níveis de dificuldade. Você pode desenvolver seu teste APP atendendo apenas a um nível, ou a todos.*
>
> **Para todos os níveis você deve executar algumas etapas iniciais:**
>- Fazer um **fork** deste repositório para o seu Github, de forma **privada**, e adicionar os usuarios `@brunosmm`, `@BetoMottu`, `@moreirawebmaster`,`@jeanchrocha`.
>- Criar um projeto Flutter com a seguinte configuração de package: `com.mottu.marvel`.
>- Criar uma conta de desenvolvedor em `developer.marvel.com`.
>- Gerar uma **API KEY** no site de desenvolvedor da **Marvel**, e consumir suas respectivas **API's**.
>- Criar um readme marcando os itens feitos.
>- Buildar para plataforma iOS.
>
> **Sugestões:**
>- Não faça apenas um commit com toda sua implementação.
>- Realize os commits em branchs separadas e utilize PRs.
>- Seja criativo(a) na sua implementação.
>- Não faça **Ctrl+C / Ctrl+V** de outro repositório !!!



# NÍVEL 1 - nome da branch (level_1):
- Executar etapas iniciais;
- Mostrar a listagem dos personagens (imagem e nome);
- Ação de clique nos cards da listagem e exibir os detalhes (imagem, nome e descrição);


# NÍVEL 2 - nome da branch (level_2):
- Executar etapas iniciais;
- Guardar em cache as consultas realizadas na API Marvel;
- Mostrar a listagem dos personagens (imagem e nome);
- Criar um filtro para a listagem;
- Ação de clique nos cards da listagem e exibir os detalhes (imagem, nome, descrição e personagens relacionados);


# NÍVEL 3 - nome da branch (level_3):
- Executar etapas iniciais;
- Criar uma Splashscreen customizada;
- Guardar em cache as consultas realizadas na API Marvel;
- Limpar cache de consultas no fechamento do APP;
- Mostrar a listagem dos personagens (imagem e nome);
- Criar um filtro para a listagem;
- Ciar uma paginação da listagem;
- Ação de clique nos cards da listagem e exibir os detalhes (imagem, nome, descrição e personagens relacionados);
- Ação de clique nos personagens relacionados e exibir os detalhes (imagem, nome, descrição e personagens relacionados);

> Ao final de cada etapa, criar PR para a branch **main** e realizar o merge.

# Pontos extras (opcional):
- Utilizar Getx.
- Configurar Firebase crashlytics.
- Criar channel em kotlin, capturar a mudança de conexão, e mostrar uma mensagem de offline no flutter.
