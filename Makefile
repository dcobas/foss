.SUFFIXES:	.fig .eps .tex .dvi .ps .pdf

STYLES=JAC2003.cls JACpic2v2.eps JACpic_mc.eps
FIGS=block_diagram.eps
FIGFIGS=block_diagram.fig
ARCHIVE=Makefile foss.tex $(STYLES)

default: foss.pdf view
all: clean default zip

foss.dvi: block_diagram.eps foss.tex

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
	zip foss`date +%Y%m%d%H%M%S`.zip $(ARCHIVE)
view:
	acroread foss.pdf &
