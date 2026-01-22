.PHONY: all build clean help

# Filename without extension
SOURCE := sping.2026.math.0481.001.syllabus
PDF := $(SOURCE).pdf
TEX := $(SOURCE).tex

# LaTeX compiler (lualatex required for tagpdf accessibility support)
COMPILER := lualatex
COMPILER_FLAGS := -interaction=nonstopmode -halt-on-error

all: $(PDF)

build: clean $(PDF)

$(PDF): $(TEX)
	$(COMPILER) $(COMPILER_FLAGS) $(TEX)
	$(COMPILER) $(COMPILER_FLAGS) $(TEX)

clean:
	rm -f $(SOURCE).aux $(SOURCE).log $(SOURCE).out $(SOURCE).toc
	rm -f $(SOURCE).fdb_latexmk $(SOURCE).fls
	rm -f *~

distclean: clean
	rm -f $(PDF)

help:
	@echo "LaTeX Syllabus Build System"
	@echo ""
	@echo "Available targets:"
	@echo "  make all       - Build the PDF (default)"
	@echo "  make build     - Clean and rebuild the PDF"
	@echo "  make clean     - Remove intermediate files"
	@echo "  make distclean - Remove all generated files including PDF"
	@echo "  make help      - Show this help message"
