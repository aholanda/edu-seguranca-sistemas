---
title: Firewall
author: Adriano J. Holanda
date: 2021-10-06
pdfengine: xelatex
header-includes: \usepackage{graphicx}
---

# Introdução
  
Sistema que controla o tráfego de pacotes em uma rede de acordo com
regras pré-definidas.

\begin{figure}[ht]
\centering
\includegraphics[scale=.7]{img/firewall.png}
\caption{Esquema de um firewall. (Adaptado de \url{https://commons.wikimedia.org/wiki/File:Firewall.png})}
\end{figure}

# Ferramentas

Nos sistemas Linux o firewall normalmente utilizado é o
[iptables](http://www.netfilter.org/projects/iptables/), e nos
sistemas BSD, o [pf](http://www.openbsd.org/faq/pf/) (_packet
filter_).

## Regras de bloqueio

O firewall utiliza algumas características dos pacotes na rede, dentre
elas:

* Porta de origem;
* IP de destino;
* Porta de destino;
* Protocolo IP (TCP ou UDP).

## Firewall iptables

Antes de construir quaisquer regras, vamos apagar regras que já existam:

```{bash}
    sudo iptables -F
```

Para listar as regras existentes, teclamos

```{bash}
    sudo iptables -L
```

Após a limpeza das regras, a listagem mostra

```
    Chain INPUT (policy ACCEPT)
    target     prot opt source               destination         

    Chain FORWARD (policy ACCEPT)
    target     prot opt source               destination         

    Chain OUTPUT (policy ACCEPT)
    target     prot opt source               destination  
```

A política padrão é `ACCEPT`, ou seja, não há qualquer tipo de filtro
para as cadeias de entrada `INPUT`, saída `OUTPUT` e repasse `FOWARD`
de pacotes.

Vamos alterar a política padrão para derrubar todos os pacotes nos 3
canais:

```{bash}
    sudo iptables -P INPUT DROP
    sudo iptables -P FORWARD DROP
    sudo iptables -P OUTPUT DROP
```

Quando executamos

```{bash}
    ping -c 3 127.0.0.1
```

A saída mostra o bloqueio do loopback

```
    ping: sendmsg: Operation not permitted
    ping: sendmsg: Operation not permitted
    ping: sendmsg: Operation not permitted
```

Vamos liberar o acesso ao *loopback*

```
    sudo iptables -A INPUT -i lo -j ACCEPT
    sudo iptables -A OUTPUT -o lo -j ACCEPT
```

e repetir o ping

```
    ping -c 3 127.0.0.1
```

e obtemos algo parecido com

```
    PING 127.0.0.1 (127.0.0.1) 56(84) bytes of data.
    64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.027 ms
    64 bytes from 127.0.0.1: icmp_seq=2 ttl=64 time=0.027 ms
    64 bytes from 127.0.0.1: icmp_seq=3 ttl=64 time=0.033 ms

    --- 127.0.0.1 ping statistics ---
    3 packets transmitted, 3 received, 0% packet loss, time 1998ms
    rtt min/avg/max/mdev = 0.027/0.029/0.033/0.003 ms
```

Porém, não conseguimos enviar o ping para fora do firewall, pois

```
    ping -c 3 google.com
```    

mostra que o acesso ao servidor de DNS (porta 53) está bloqueado, 
vamos liberar a porta 53

```
    sudo iptables -A OUTPUT -p udp -o eth0 --dport 53 -j ACCEPT
    sudo iptables -A INPUT -p udp -i eth0 --sport 53 -j ACCEPT
```

e executar novamente

```
    ping -c 3 google.com
```

cuja saída mostra que os pacotes `ICMP` continuam bloqueados

```
    PING google.com (XXX.XXX.XXX.XXX) 56(84) bytes of data.
    ping: sendmsg: Operation not permitted
    ping: sendmsg: Operation not permitted
    ping: sendmsg: Operation not permitted

    --- google.com ping statistics ---
    3 packets transmitted, 0 received, 100% packet loss, time 1999ms
```

Vamos liberar o ping de dentro para fora do firewall


```
    sudo iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT
    sudo iptables -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT
```

e novamente

```
    ping -c 3 holanda.xyz
```

obtemos


```
Disparando google.com [XXX:XXXX:XXXX:XXX::XXXX] com 32 bytes de dados:
   
Resposta de XXX:XXXX:XXXX:XXX::XXXX: tempo=11ms 
Resposta de XXX:XXXX:XXXX:XXX::XXXX: tempo=9ms 
Resposta de XXX:XXXX:XXXX:XXX::XXXX: tempo=10ms 
Resposta de XXX:XXXX:XXXX:XXX::XXXX: tempo=11ms 


Estatísticas do Ping para XXX:XXXX:XXXX:XXX::XXXX:
    Pacotes: Enviados = 4, Recebidos = 4, Perdidos = 0 (0% de
             perda),
Aproximar um número redondo de vezes em milissegundos:
    Mínimo = 9ms, Máximo = 11ms, Média = 10ms
```

mostando que o ICMP agora está liberado.


Porém ainda não conseguimos navegar na web, vamos liberar a porta `HTTP` (80) 
 e `HTTPS` (443)


```{bash}
    sudo iptables -A OUTPUT -p tcp -o eth0 --dport 80 -j ACCEPT
    sudo iptables -A INPUT -p tcp -i eth0 --sport 80 -j ACCEPT
    sudo iptables -A OUTPUT -p tcp -o eth0 --dport 443 -j ACCEPT
    sudo iptables -A INPUT -p tcp -i eth0 --sport 443 -j ACCEPT
```

## Exercícios

1) Qual o significado dos argumentos `NEW`, `ESTABLISHED` e `RELATED` 
para a _flag_ `-state` na seguinte regra:

```
    sudo iptables –append OUTPUT -m state –state NEW,ESTABLISHED,RELATED -j ACCEPT
```

2) Escreva uma regra que libere a comunicação via usando `ssh` (porta 22).



