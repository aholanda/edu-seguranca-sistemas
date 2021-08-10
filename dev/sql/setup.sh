#!/bin/bash

# Echo and execute first argument
ecx() {
    echo $1
    $1
}

purge() {
    ecx "sudo apt purge -y apache2* php* postgresql-* libapache2-mod-php* php*-pgsql"
}

pkg_install() {
    ecx "sudo apt install -y $1"
}

install() {
    ecx "rm -rf src/ dev.zip"
    ecx "wget http://book.holanda.xyz/sec/dev.zip"
    ecx "unzip dev.zip"
    purge
    pkg_install php-pgsql
    pkg_install postgresql
    pkg_install libapache2-mod-php
}

sql() {
    ecx "sudo -u postgres psql -a -f comandos.sql"
}

# copy file with problems
web() {
    ecx "sudo cp ./index.html ./login.php /var/www/html"
}

# copy the bug fix
fix() {
    ecx "sudo cp ./login-fix.php /var/www/html/login.php"
}


case "$1" in
    install)
	install
	;;
    sql)
	sql
	 ;;
     web)
	 web
	 ;;
     fix)
	 fix
	 ;;
     purge)
	 purge
	 ;;
     *)
	 echo "Usage: $0 {install|sql|web|fix|purge}"
	 echo "* install - remove and install packages needed to test SQL injection;"
	 echo "* sql - prepare the database;"
	 echo "* web - copy the files, like forms, to test the injection;"
	 echo "* fix - copy the files containing the fix to SQL injection;"
	 echo "* purge - clean the environment."
	 exit 3
	 ;;
esac

exit 0
