.SUFFIXES:	.eps .tex .dvi .ps .pdf

STYLES=JAC2003.cls JACpic2v2.eps JACpic_mc.eps
ARCHIVE=Makefile foss.tex $(STYLES)

default: foss.pdf
all: clean default zip

.tex.dvi:
	latex $* && latex $*
.dvi.ps:
	dvips -o $@ $^

.ps.pdf:
	ps2pdf $^ $@

clean:
	rm -rf *.aux *.dvi *.log *.pdf
zip:
	zip foss`date +%Y%m%d%H%M%S`.zip $(ARCHIVE)
