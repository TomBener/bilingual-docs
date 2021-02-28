# Generate English document

# Remove potential `<!-- ` and ` -->`
sed -i '' -e 's/<!-- //g; s/ -->//g' main.md

# Comment Chinese paragraphs
perl -CSD -Mutf8 -i -pe 's/(.*\p{Han}+.*)/<!-- \1 -->/g' main.md

# Generate `main-en.docx`
pandoc -C -N -M reference-section-title="References" main.md -o main-en.docx

# Generate `main-cn.tex`
pandoc --natbib --wrap=none main.md -o main-en.tex
