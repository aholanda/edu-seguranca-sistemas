#!/usr/bin/env bash

function install_core_packages {
    pkgs="clang gcc tcc vim"
    for pkg in pkgs; do 
        $(test $pkg) && sudo apt install -y $pkg
    done
}

function upgrade {
    sudo apt update && sudo apt upgrade -y
}

# Script para instalar programas no SO Linux
# necessários para as demonstrações e exercícios.

case $1 in
    net)        
        sudo apt update && \
            sudo apt install \
                hping3 \
                tcpdump \
                wireshark
        ;;
    *)
        echo "usage: $0 [net]"
        exit -1
esac

upgrade
install_core_packages

exit 0