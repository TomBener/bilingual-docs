## Author: TomBen
## Email: retompi@gmail.com

## make			Generate both English and Chinese documents
## make all		Generate both English and Chinese documents
## make en		Generate English documents
## make cn		Generate Chinese documents
## make clean		Remove generated documents
## Happy making! 😃️


.PHONY: all
all: en cn

# Sed with options
SED = sed -i '' -e 's/<!-- //g; s/ -->//g'
# Perl with options
PERL = perl -CSD -Mutf8 -i -pe
# Pandoc with options for .docx output
PAND = pandoc -C -N -M
# Pandoc with options for .tex output
PANX = pandoc --natbib --wrap=none

.SILENT:
# Generate English documents
en: main.md
	# Comment Chinese paragraphs
	$(PERL) 's/(.*\p{Han}+.*)/<!-- \1 -->/g' $<
	
	# Generate `en.docx`
	$(PAND) reference-section-title="References" $< -o en.docx
	
	# Generate `cn.tex`
	$(PANX) $< -o en.tex
	# Compile LaTeX
	
	# Restore to the original status
	$(SED) $<

.SILENT:
# Generate Chinese documents
cn: main.md
	# Comment all paragraphs
	$(PERL) 's/(^.*\S)/<!-- \1 -->/g' $<
	
	# Uncomment Chinese paragraphs
	$(PERL) 's/<!-- (.*\p{Han}+.*) -->/\1/g' $<
	
	# Generate `cn.docx`
	$(PAND) reference-section-title="参考文献" --bibliography ref.bib $< -o cn.docx
	
	# Generate `cn.tex`
	$(PANX) $< -o cn.tex
	# Compile LaTeX
	
	# Restore to the original status
	$(SED) $<

.PHONY: clean
clean:
	rm *.docx *.tex 
