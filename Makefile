.SUFFIXES:	.fig .eps .tex .dvi .ps .pdf

CODE=THCHMUST04
STYLES=JAC2003.cls JACpic2v2.eps JACpic_mc.eps
FIGS=block_diagram.eps wishbone-enum.eps
FIGFIGS=block_diagram.fig wishbone-enum.fig
ARCHIVE=Makefile $(CODE).tex $(STYLES) $(FIGFIGS) $(FIGS)
.PRECIOUS: $(CODE).ps

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
	rm -rf *.aux *.dvi *.log *.pdf *.bak
zip:
	zip $(CODE)_`date +%Y%m%d%H%M%S`.zip $(ARCHIVE)
view:
	acroread $(CODE).pdf &
