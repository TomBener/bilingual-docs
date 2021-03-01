# make		Generate both English and Chinese documents
# make all		Generate both English and Chinese documents
# make en		Generate English documents
# make cn		Generate Chinese documents
# make clean		Remove generated documents
# Happy making!


.PHONY: all
all: en cn

.SILENT:
# Generate English documents
en: main.md
	# Remove potential `<!-- ` and ` -->`
	sed -i '' -e 's/<!-- //g; s/ -->//g' $<
	
	# Comment Chinese paragraphs
	perl -CSD -Mutf8 -i -pe 's/(.*\p{Han}+.*)/<!-- \1 -->/g' $<
	
	# Generate `en.docx`
	pandoc -C -N -M reference-section-title="References" $< -o en.docx
	
	# Generate `cn.tex`
	pandoc --natbib --wrap=none $< -o en.tex
	# Compile LaTeX
	
	# Restore to the original status
	sed -i '' -e 's/<!-- //g; s/ -->//g' $<

.SILENT:
# Generate Chinese documents
cn: main.md
	# Remove potential `<!-- ` and ` -->`
	sed -i '' -e 's/<!-- //g; s/ -->//g' $<
	
	# Comment all paragraphs
	perl -CSD -Mutf8 -i -pe 's/(^.*\S)/<!-- \1 -->/g' $<
	
	# Uncomment Chinese paragraphs
	perl -CSD -Mutf8 -i -pe 's/<!-- (.*\p{Han}+.*) -->/\1/g' $<
	
	# Generate `cn.docx`
	pandoc -C -N -M reference-section-title="参考文献" --bibliography ref.bib $< -o cn.docx
	
	# Generate `cn.tex`
	pandoc --natbib --wrap=none $< -o cn.tex
	# Compile LaTeX
	
	# Restore to the original status
	sed -i '' -e 's/<!-- //g; s/ -->//g' $<

.PHONY: clean

clean:
	rm *.docx *.tex 
