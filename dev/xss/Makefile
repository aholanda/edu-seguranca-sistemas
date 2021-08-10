FILES := index.html do.php do-fix.php
WWWDIR := /var/www/html/xss/

$(FILES): $(WWWDIR)
	sudo cp $(FILES) $<

$(WWWDIR):
	if [ ! -e $@ ]; then \
		sudo apt-get install apache2 php libapache2-mod-php; \
		sudo mkdir $@; \
	fi
