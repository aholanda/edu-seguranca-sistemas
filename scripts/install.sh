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
    pkgs="coreutils emacs logcheck logwatch screen snort vim tmux tripwire"
    for pkg in ${pkgs}; do 
        $(test ${pkg}) && ${INSTALL} -y ${pkg}
    done
}

function upgrade {
    $UPDATE && ${UPGRADE}
}

DEV="clang gcc tcc apache2 php postgresql php-pgsql"
case $1 in
    dev)
        ${INSTALL} ${DEV}
        sudo sed -i "s/;pdo_pgsql/pdo_pgsql/g" /etc/php/7.4/apache2/php.ini
        sudo sed -i "s/;pgsql/pgsql/g" /etc/php/7.4/apache2/php.ini
        sudo service restart apache2
        ;;
    net)        
        ${INSTALL} hping3 nmap tcpdump 
        ;;
    *)
        echo "usage: $0 [dev|net]"
        exit -1
esac

upgrade
install_core_packages

exit 0
