.SUFFIXES:	.fig .gif .jpg .eps .tex .dvi .ps .pdf

CODE=CERN_OH
STYLES=JAC2003.cls
PAPERFIGS= $(CODE)f1.eps $(CODE)f2.eps
TALKFIGS= driverarch.pdf adcarch.pdf spec.pdf fmcadc.pdf
FIGS= $(CODE)f1.fig $(CODE)f2.fig $(CODE)f2_talk.fig block_diagram.dia \
	driverarch.fig adcarch.fig spec.fig fmcadc.fig
RASTERS=p_tundra_Tsi148-HR.gif 01a020-_hi.jpg fmcadc.jpg spec.jpg
PAPER=$(CODE).pdf
TALK=$(CODE).pdf
ARCHIVE=Makefile $(CODE).tex $(CODE).ps $(STYLES) $(FIGS) $(RASTERS)

.PRECIOUS: $(CODE).ps $(PAPERFIGS)

default: $(TALK) view_talk
all: clean default zip

$(CODE).dvi: $(PAPERFIGS) $(CODE).tex

.tex.dvi:
	latex $* && latex $*
.dvi.ps:
	dvips -o $@ $^
.fig.eps:
	fig2dev -L eps $^ $@
.jpg.eps:
	jpegtopnm $^ | pnmtops -noturn -nocenter > $@
.gif.eps:
	giftopnm $^ | pnmtops -noturn -nocenter > $@
.dia.eps:
	dia -t eps $^
.eps.pdf:
	epstopdf $^
.ps.pdf:
	ps2pdf $^ $@

$(CODE).dvi: $(CODE).tex $(FIGS)
$(TALK): $(CODE).tex $(TALKFIGS)
	pdflatex $* && pdflatex $*

clean:
	rm -rf *.aux *.dvi *.log *.bak *.eps *.pdf *.nav *.out *.snm *.toc
zip:
	zip $(CODE)_`date +%Y%m%d%H%M%S`.zip $(ARCHIVE)
view:
	acroread $(PAPER) &
view_talk:
	acroread $(TALK) &
