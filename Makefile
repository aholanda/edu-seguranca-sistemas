# SLIDES
main.pdf: main.aux
	xelatex main.tex

main.aux: main.tex intro.tex
	xelatex $<
crypto.tex: symmetric-cryto-model.png symmetric-key-encrypt.png \
		public-key-encrypt.png

%.png: img/%.svg
	inkscape --export-png=$@ $< 
trash += *.png

# CLEAN
trash += *.aux *.bbl *.blg *.dvi *.idx  *.log *.nav *.out main.pdf *.scn *.snm *.toc *.vrb

clean:
	$(RM) $(trash)
