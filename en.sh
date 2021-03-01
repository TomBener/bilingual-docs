# Generate English documents

# Remove potential `<!-- ` and ` -->`
sed -i '' -e 's/<!-- //g; s/ -->//g' main.md

# Comment Chinese paragraphs
perl -CSD -Mutf8 -i -pe 's/(.*\p{Han}+.*)/<!-- \1 -->/g' main.md

# Generate `en.docx`
pandoc -C -N -M reference-section-title="References" main.md -o en.docx

# Generate `en.tex`
pandoc --natbib --wrap=none main.md -o en.tex
# Compile LaTeX

# Restore to the original status
sed -i '' -e 's/<!-- //g; s/ -->//g' main.md
