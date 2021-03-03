## Author: TomBen
## Email: retompi@gmail.com

## make			Generate both English and Chinese documents
## make all		Generate both English and Chinese documents
## make en		Generate English documents
## make cn		Generate Chinese documents
## make clean		Remove generated documents
## Happy making! 😃️


# Perl with options
PERL = perl -CSD -Mutf8 -i -pe
# Pandoc with options for .docx output
PAND = pandoc -C -N -M reference-section-title
# Pandoc with options for .tex output
PANX = pandoc --natbib --wrap=none

.PHONY: all
all: en cn

.SILENT:
# Generate English documents
en: main.md
	# Comment Chinese paragraphs
	$(PERL) 's/(.*\p{Han}+.*)/<!--- \1 -->/g' $<

	# Uncomment commented paragraphs
	$(PERL) 's/(<!--- <!-- )(.*)( --> -->)/<!-- \2 -->/g' $<
	
	# Generate `en.docx`
	$(PAND)="References" $< -o en.docx
	
	# Generate `en.tex`
	$(PANX) $< -o en.tex

	# Generate PDF via `en.tex` and `cn.tex`
	
	# Restore to the original status
	$(PERL) 's/(<!--- )(.*)( -->)/\2/g' $<

.SILENT:
# Generate Chinese documents
cn: main.md
	# Comment all paragraphs
	$(PERL) 's/(.*\S)/<!--- \1 -->/g' $<
	
	# Uncomment Chinese paragraphs
	$(PERL) 's/<!--- (.*\p{Han}+.*) -->/\1/g' $<
	
	# Uncomment paragraphs which contain Chinese character
	# and the generic HTML comment symbol
	$(PERL) 's/<!--- (.*\p{Han}+.*) -->/\1/g; \
	s/(<!--- <!-- )(.*)( --> -->)/<!-- \2 -->/g' $<

	# Generate `cn.docx`
	$(PAND)="参考文献" --bibliography ref.bib $< -o cn.docx
	
	# Generate `cn.tex`
	$(PANX) $< -o cn.tex
	
	# Generate PDF via `en.tex` and `cn.tex`
	
	# Restore to the original status
	$(PERL) 's/(<!--- )(.*)( -->)/\2/g' $<

.PHONY: clean
clean:
	rm *.docx *.tex
