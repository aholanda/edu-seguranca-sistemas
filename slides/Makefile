LATEX := xelatex
imgs  := firewall.png
texs  := $(wildcard *.tex)

main.pdf: main.tex $(texs) $(imgs)
	$(LATEX) $<

clean:
	$(RM) *.aux main.log main.nav main.out \
		main.pdf main.snm main.toc

.PHONY: clean

# How to generate png from svg
# inkscape --export-png=out.png in.svg
