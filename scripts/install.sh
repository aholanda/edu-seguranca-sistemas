#!/usr/bin/env bash

##
# Autor: Adriano J. Holanda
# Script para instalar programas no SO Linux
# necessários para as demonstrações e exercícios.
##

INSTALL="sudo apt install -y"
UPDATE="sudo apt update"
UPGRADE="sudo apt upgrade -y"

function install_core_packages {
    pkgs="clang gcc tcc vim"
    for pkg in pkgs; do 
        $(test $pkg) && ${INSTALL} -y $pkg
    done
}

function upgrade {
    ${UPGRADE}
}

case $1 in
    dev)
        ${UPDATE} && \
            ${INSTALL} \
                clang gcc tcc \
                apache2 php \
                postgresql php-pgsql
        ;;
    net)        
        ${UPDATE} && \
            ${INSTALL} \
                hping3 \
                md5sum \
                nmap \
                tcpdump 
        ;;
    *)
        echo "usage: $0 [dev|net]"
        exit -1
esac

upgrade
install_core_packages

exit 0