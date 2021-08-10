= Injeção de SQL

Este diretório contém scripts para entender o ataque de injeção de
SQL, que pode ocorrer com as ferramentas PHP e PostgreSQL, se os
devidos cuidados não forem tomados.

Os testes foram realizados em um sistema Linux, sendo que para outros
sistemas algumas adaptações devem ser feitas. Os comandos apresentados
para para as distribuições Linux Debian/Ubuntu.

O banco de dados PostgreSQL e a linguagem podem ser instalados pelo
comando:

----
$ sudo apt-get install postgresql-9.5 postgresql-client php php-pgsql
----

O número `9.5` é a versão do banco de dados e pode ser substituído
pela versão disponível o repositório. O pacote `postgresql-client` é o
cliente para o PostgreSQL a ser executado no terminal. O pacote `php`
contém os binários para execução do PHP e o pacote `php-pgsql` contém
os binários para comunicação entre o PHP e o banco de dados
PostgreSQL.

----
$ sudo -u postgres  psql < ./comandos.sql
----

Copie os arquivos no diretório do apache:

----
$ sudo cp -r ../sql /var/www/html
---

Para testar o script PHP com falha de segurança `do.php`, abra o
navegador e carregue a página http://localhost/sql/index.html.  Para
testar a autenticação foi criado um usuário `alice` com senha
`alice123`.

Para testar o script coorrigido `do-fix.html`, a página a ser
carregada é http://localhost/sql/index-fix.html.

