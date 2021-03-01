# Generate Chinese documents

# Remove potential `<!-- ` and ` -->`
sed -i '' -e 's/<!-- //g; s/ -->//g' main.md

# Comment all paragraphs
perl -CSD -Mutf8 -i -pe 's/(^.*\S)/<!-- \1 -->/g' main.md

# Uncomment Chinese paragraphs
perl -CSD -Mutf8 -i -pe 's/<!-- (.*\p{Han}+.*) -->/\1/g' main.md

# Generate `cn.docx`
pandoc -C -N -M reference-section-title="参考文献" --bibliography ref.bib main.md -o cn.docx

# Generate `cn.tex`
pandoc --natbib --wrap=none main.md -o cn.tex
# Compile LaTeX

# Restore to the original status
sed -i '' -e 's/<!-- //g; s/ -->//g' main.md
