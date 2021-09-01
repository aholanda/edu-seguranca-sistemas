#!/usr/bin/env bash

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

exit 0