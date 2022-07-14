LATEX := xelatex
imgs  := firewall.png
texs  := $(wildcard *.tex)

main.pdf: main.tex $(texs) $(imgs)
	$(LATEX) $<

clean:
	$(RM) *.aux main.log main.nav main.out \
		main.pdf main.snm main.toc

.PHONY: clean
