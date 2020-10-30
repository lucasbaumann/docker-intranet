# Documentação INTRANET SCI

## CONTAINER DOCKER (START INTRANET)

**Pré-requisitos**  
Instalar:  
>**[VS code](https://code.visualstudio.com/download)**
>**[Docker for windows](https://desktop.docker.com/win/stable/Docker%20Desktop%20Installer.exe)**  
>**[FileZilla](https://filezilla-project.org/download.php)**

**Configuração/Procedimentos**  
Baixar databases
>**[DB - sci - sciweb](https://drive.google.com/file/d/1kU9K6z8Tw3gwLcCZB_wOErbDWAeZVWX8/view?usp=sharing)**  
O arquivo é protegido por senha, solicitar acesso ao responsável  

Descompactar aquivos

Obter arquivos de configuração do repositório **docker-intranet**
>**[docker-intranet](https://github.com/felipe-felizardo/docker-intranet)**

Efetuar build da imagem do Dockerfile **(Build Image)**
>No VScode, botão direito em cima de Dockerfile > "Build image"  
>Ou por linha de comando: _docker build --pull --rm -f "Dockerfile" -t intranet:latest "."_

Subir o Docker Compose **(Compose Up)**
>No VScode, botão direito em cima de docker-compose.yml > "Compode Up"  
>Ou por linha de comando: docker-compose -f "docker-compose.yml" up -d --build

**Popular databases no container mysql na pasta mysql/**  
Fazer esse procedimento para cada banco de dados  
Inserir os seguintes comandos via **CLI**:
>Logar no MySQL: _mysql -u root -p_  
>Senha: _root_  
>Criar database: _create database (sci ou sciweb)_  
>Usar o database: _use (sci ou sciweb)_  
>Importar arquivo sql: _source /path/var/lib/mysql/nomedoarquivo.sql_

Baixar fontes do repositório **[intranet-sci](https://bitbucket.org/time-w2o/intranet-sci)** e colocar no endereço **var/www/html**
>Command: git clone <https://user-bitbucket@bitbucket.org/time-w2o/intranet-sci.git>

**Configurando FTP no FileZilla**  
Solicitar para o responsável arquivo .xml para configuração do FileZilla  
No FileZilla em Arquivo > Importar > arquivodeconfiguração.xml  
Depois em Arquivo > Gerenciador de Sites > Selecionar Entradas > Intranet > Conectar  
Depois disso é possível fazer o Upload dos arquivos para base   Clicando com o botão direito no arquivo que deseja enviar > Upload > Opção substituir

**Acesso ao banco de dados via phpMyAdmin**  
Pode acessar pelo Docker no botão "Open in browser" ou pelo endereço <http://localhost:8080/>  
>-Banco de dados local para desenvolvimento:  
>Servidor: _mysql_  
>Utilizador: _root_  
>Palavra-chave: _root_  
>
>-Banco de dados oficial:  
>Solicitar dados de acesso para o responsável

**[Documentação W2O](http://w2o.com.br/documentacao/index.php)** contém informações sobre Intranet  
Senha: Sci#910204

## BANCO DE DADOS

Encoding padrão de tabela: **utf8mb4_general_ci**  
Para colunas como login, email, etc deve ser usado **utf8mb4_bin**, pois   ele faz a distinção de caracteres maiusculos e minúsculos, acentos, etc  
Primary Key deve ser **id** int (11), unsigned  
Tabelas filhas devem levar o nome da tabela pai, exemplo: pedido, pedido_cliente, pedido_informacao, etc.  
Quando a tabela é filha deve ter uma FK com a tabela pai, exceto em alguns casos especificos  
Colunas de LOGS devem ficar sempre no final da tabela  
Logs padrão: log_cadastro_data, log_cadastro_usuario_id, log_alterado_data, log_alterado_usuario_id  
Se tiver rotina de "exclusão": log_excluido_data, log_excluido_usuario_id  
Nome de tabelas devem ser no singular  
Os alias devem ser condizente a tabela, exemplo: pedido as p, pedido_cliente as pc  
Tipo de escrita padrão **snake_case**

## GERAL

- Para achar os arquivos que devem ser alterados é baseado na url.
**Cada tela tem seus 4 links, geralmente:**
  - arquivoIndex.php (Tela de listagem e filtro, a que tem o grid).
  - arquivoForm.php (Tela de inclusão ou alteração de registro).
  - arquivoFormDo.php, (arquivo que executa a inclusão ou alteração).
  - arquivoDelete.php (arquivo que executa a deleção).

## Menus

- O menu basicamente é a leitura da tabela de menu do banco.
Mais algumas alterações no arquivo /var/www/html/intranet/inc/funcao/html.php

- No menu de atendimento no site da intranet dentro de suporte/atendimento tem os sistemas.
esses sistemas são inseridos por um array naquele arquivo html.php

- Sempre depois de inserir um novo menu tem que adicionar a permissão para poder disponibilizar ele na tela.

- A ordem como os menus são exibidos é definida pela sci.menu, dentro da tabela pelas colunas ordemShow e categioria.
Onde: OrdemShow = define a sequência de exibição (números menores são exibidos primeiro)
Categoria = define a pasta na qual o menu vai estar inserido

## Permissões

- Para dar permissão é no menu Administrador / Grupo de usuários.
Selecionar o tipo de grupo de usuário que tu ta usando e marca o checkbox do novo menu.

## Filtros

- Quando adicionar um filtro em tela tem que adicionar esse campo no arquivo /var/www/html/intranet/setFilter.php
