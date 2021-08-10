#!/bin/sh

# Execute os comandos a seguir para preparar o ambiente:
rm -rf dev.zip && rm -rf src/
wget http://book.holanda.xyz/sec/dev.zip
unzip dev.zip
cd src/sql
./setup.sh install
./setup.sh sql
firefox http://localhost/ &   # abra o Firefox no formulario
