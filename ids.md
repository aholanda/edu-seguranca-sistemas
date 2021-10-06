---
title: Detecção de Intrusão
author: Adriano J. Holanda
date: 2021-09-15
---

# Introdução

**Detecção de intrusão** é o processo de monitorar os eventos que
    ocorrem em um sistema ou rede de computadores para identificar
    possíveis incidentes. Sendo que *incidente* é a violação do
    comportamento esperado dos sistemas e rede de computadores.

# Locais de monitoramento
  
- **Rede de computadores**: monitora o tráfego em um segmento da
    rede ou dispositivo para detecção de anomalias.
- **Wireless**: monitora o tráfego da rede wireless de acordo com
    seus protocolos.
- **Host**: monitora a atividade de um único computador,
    normalmente um servidor que fornece serviços a outros clientes.

## Ferramentas de monitoramento da rede
    
Um IDS (_Intrusion_ _Detection_ _System_) de rede usa placas de rede
em modo promíscuo, analisando todos os pacotes em um ou mais segmentos
da rede. Podemos dividir os IDSs de rede em 2 categorias:
    
- **Detecção de assinatura**: assim como os antivírus, estes
      sistemas tentam comparar os padrões com um banco de dados de
      "assinaturas de ataques". Exemplo: [snort](https://www.snort.org/).
- **Detecção de anomalia**: estes sistemas tentam detectar
      anomalias de funcionamento da rede utilizando algumas
      heurísticas e estatística.
  
### Detecção de assinatura usando `snort`

Para executar o `snort` em modo prolixo (`-v`):

```{bash}
$ sudo snort -v
```

Para mostrar os dados (`-d`) do pacote da camada de aplicação:

```{bash}
$ sudo snort -vd
```

Para mostrar o pacote em estado bruto (_raw_):

```{bash}
$ sudo snort -vX
```
    
Para executar o `snort` em modo detecção de intrusão:

```{bash}
$ sudo snort -dev  -h 192.168.1.0/24 -c /etc/snort/snort.conf
```

O arquivo `snort.conf` deve ser configurado com as regras de detecção.

## Ferramentas de monitoramento de _hosts_
  
- **Controle de acesso**: restringem o acesso aos recursos do
    computador de acordo com as permissões de usuários e
    processos. Exemplos:
    [SELinux](http://selinuxproject.org/page/Main_Page),
    [AppArmor](http://wiki.apparmor.net/index.php/Main_Page),
    [Oracle Solaris Zones](http://goo.gl/flbyDR).
- **Verificadores de integridade**: verificam a integridade dos
    principais arquivos do sistema para detecção de
    alteração. Exemplo: [tripwire](http://www.tripwire.org/).
- **Analisadores de logs**: monitoram os eventos dos serviços para
    detecção de anomalias de acordo com regras estabelecidas pelo
    administrador.  Exemplos:
    [logwatch](http://linux.die.net/man/8/logwatch),
    [logcheck](https://logcheck.alioth.debian.org/).

- [**Honeypots**](http://www.honeypots.net/): são computadores preparados
para serem usados como iscas para varreduras de portas e ataques. Eles
possuem as portas mais vulneráveis abertas, porém, sem serviços
efetivos disponíveis. Estas portas são utilizadas para registrar os
_logs_ de tentativas de varreduras e ataques para serem analisados.

### Verificação de integridade usando _tripwire_

O `tripwire` é uma ferramenta para verificar a alteração da integridade
dos dados. Para gerar o banco de dados com informações sobre os arquivos:

```{bash}
$ sudo tripwire --init
```

Para realizar o teste de integridade:

```{bash}
$ sudo tripwire --check
# Para analisar um diretório específico
$ sudo tripwire --check /bin
```

### Auditoria de registros (_logs_)

Os sistemas que fornecem serviços, tais como servidores web e ftp,
registram os eventos (_logs_) em arquivos para que possa ser feita uma
auditoria. Normalmente, os _logs_ são armazenados em arquivo texto, com
a separação entre as colunas obedecendo um padrão. Por exemplo, a saída
a seguir foi extraída do arquivo de _log_ do servidor _web_ apache:

```
127.0.0.1 - - [10/Jan/2016:00:35:01 -0200] "GET /index.php HTTP/1.1" 200 2396 
"http://localhost/" "Mozilla/5.0 (X11; Ubuntu; Linux armv7l; rv:43.0) 
Gecko/20100101 Firefox 43.0"
```

A primeira coluna informa o IP do _host_ que realizou a requisição,
depois seguem informações a respeito do horário, URL, sistema
operacional e programa que realizou a requisição HTTP. Esta informação
não é usada somente para auditoria, como para verificação de
compatibilidade da versão do navegador com os elementos da página
requisitada, por exemplo.

#### _logcheck_

O [`logcheck`](https://logcheck.org/) 
é um utilitário para visualização dos  _logs_ 
de diversos serviços. 
Para executar o `logcheck` em modo teste (`-t`), 
com a saída impressa na tela (`-o`):


```{bash}
$ sudo -u logcheck logcheck -o -t
```

Para executar em modo _debug_ (`-d`):

```{bash}
$ sudo -u logcheck logcheck -o -d
```

#### _logwatch_

O [`logwatch`](https://sourceforge.net/projects/logwatch/)
é um analisador de registros (_logs_) do sistema.
Para executar o `logwatch`:

```
$ sudo logwatch --detail High --mailto admin@example.edu --range today
```

Para alterar a configuração, basta adicionar um arquivo em 
`/etc/logwatch/conf/`. Por exemplo, o arquivo a seguir 
checa o espaço em disco e chamaremos de `zz-disk_space.conf`:


```
# /etc/logwatch/conf/zz-disk_space.conf
#--------------------------------------
# Show the home directory sizes
$show_home_dir_sizes = 1
$home_dir = "/home"
 
# Show the mail spool size
$show_mail_dir_sizes = 1
$mail_dir = "/var/spool/mail"
 
# Show the system directory sizes /opt /usr/ /var/log
$show_disk_usage = 1
```

# Exercício
    
1. Analise o arquivo de _log_ `/var/log/auth.log` do Linux e descreva 
cada um de seus campos.
2. Execute o `logcheck` no modo teste, escolha uma linha da
saída, e descreva-a em detalhes.

# Referências
  
1. Karen Scarfone; Peter Mell. [Guide to Intrusion
  Detection and Prevention Systems (IDPS): Recommendations of the
  National Institute of Standards and Technology (NIST)"](http://goo.gl/tI5VNi). NIST, 2007.

2. Nikolai Bezroukov. ["Architectural Issues of Intrusion Detection
  Infrastructure in Large Enterprises"](http://goo.gl/uh9IQC).
