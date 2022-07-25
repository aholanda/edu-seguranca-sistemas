LATEX := xelatex
imgs  := $(wildcard *.png)
texs  := $(wildcard *.tex)

main.pdf: main.tex $(texs) $(imgs)
	$(LATEX) $< && $(LATEX) $<

article: main.tex
	xelatex "\def\ishandout{1} \input{main.tex}" \
	&& xelatex "\def\ishandout{1} \input{main.tex}"

clean:
	$(RM) *.aux main.log main.nav main.out \
		main.pdf main.snm main.toc

.PHONY: article clean

# How to generate png from svg
# inkscape --export-png=out.png in.svg
