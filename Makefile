TEXES := crypto.tex ementa.tex  intro.tex  malware.tex  net.tex  vpn.tex  wireless.tex

# SLIDES
main.pdf: main.tex
	-xelatex $<
	-xelatex $<

main.tex: $(TEXES)

crypto.tex: symmetric-cryto-model.png symmetric-key-encrypt.png \
		public-key-encrypt.png

%.png: img/%.svg
	inkscape --export-png=$@ $< 
trash += *.png

# CLEAN
trash += *.aux *.bbl *.blg *.dvi *.idx  *.log *.nav *.out main.pdf *.scn *.snm *.toc *.vrb

clean:
	$(RM) $(trash)
