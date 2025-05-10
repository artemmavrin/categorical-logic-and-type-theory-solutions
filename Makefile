LATEX := pdflatex
LATEXFLAGS := --shell-escape --file-line-error
NONSTOP := --interaction=nonstopmode

LATEXMK := latexmk
LATEXMKFLAGS := -quiet -recorder -use-make -pdf
CONTINUOUS := -pvc

MAIN := solutions
CLS := solutions.cls
BIB := refs.bib
TEX := $(shell find chapters -name "*.tex" -type f)

RM := rm -rf

.PHONY: help pdf continuous clean

help:
	@ echo "Usage:"
	@ echo "    make pdf            Build the PDF."
	@ echo "    make continuous     Continuously build the PDF."
	@ echo "    make clean          Delete auxiliary files."
	@ echo "    make help           View these usage instructions."

pdf: $(MAIN).pdf

$(MAIN).pdf: $(MAIN).tex $(CLS) $(BIB) $(TEX)
	$(LATEXMK) $(LATEXMKFLAGS) -pdflatex="$(LATEX) $(LATEXFLAGS) %O %S" $<

continuous: $(MAIN).tex
	$(LATEXMK) $(LATEXMKFLAGS) $(CONTINUOUS) -pdflatex="$(LATEX) $(LATEXFLAGS) $(NONSTOP) %O %S" $<

clean:
	$(LATEXMK) -C
	$(RM) *.bbl
	$(RM) *.run.xml
	$(RM) *."synctex(busy)"
