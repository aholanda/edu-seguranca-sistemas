ifeq ($(OS),Windows_NT)
        RM := del
        DEV_NULL := 2> $$null
else
        DEV_NULL := 2>/dev/null
endif

PANDOC_TEX_FLAGS := --pdf-engine xelatex -V colorlinks -V linkcolor=blue -V urlcolor=blue

# NOTAS
%.pdf: %.md
	pandoc -t pdf $(PANDOC_TEX_FLAGS) -s $< -o $@

# SLIDES
main.pdf: main.aux
	xelatex main.tex

main.aux: main.tex intro.tex proxy.tex
	xelatex $<

crypto.tex: symmetric-cryto-model.png symmetric-key-encrypt.png \
		public-key-encrypt.png

proxy.tex: proxy-open.png proxy-reverse.png

%.png: img/%.svg
	inkscape --export-png=$@ $< 
trash += *.png

# CLEAN
trash += *~ *.aux *.bbl *.blg *.dvi *.idx  *.log *.nav *.out main.pdf *.scn *.snm *.toc *.vrb

clean:
	$(RM) $(trash) $(DEV_NULL)
	$(RM) $$null