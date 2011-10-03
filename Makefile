.SUFFIXES:	.fig .eps .tex .dvi .ps .pdf

CODE=THCHMUST04
STYLES=JAC2003.cls JACpic2v2.eps JACpic_mc.eps
FIGS= $(CODE)f1.eps $(CODE)f2.eps
FIGFIGS= $(CODE)f1.fig $(CODE)f2.fig
ARCHIVE=Makefile $(CODE).tex $(CODE).ps $(STYLES) $(FIGFIGS) $(FIGS)
.PRECIOUS: $(CODE).ps $(FIGS)

default: $(CODE).pdf view
all: clean default zip

$(CODE).dvi: $(FIGS) $(CODE).tex

.tex.dvi:
	latex $* && latex $*
.dvi.ps:
	dvips -o $@ $^
.fig.eps:
	fig2dev -L eps $^ $@
.ps.pdf:
	ps2pdf $^ $@

clean:
	rm -rf *.aux *.dvi *.log *.pdf *.bak *.eps
zip:
	zip $(CODE)_`date +%Y%m%d%H%M%S`.zip $(ARCHIVE)
view:
	acroread $(CODE).pdf &
