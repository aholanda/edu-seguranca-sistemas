LATEX := xelatex
texs  := firewall.tex

main.pdf: main.tex $(texs)
	$(LATEX) $<

clean:
	$(RM) *.aux main.log main.out main.pdf

.PHONY: clean
