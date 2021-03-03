#!/bin/zsh
# Generate English documents

# Comment Chinese paragraphs
perl -CSD -Mutf8 -i -pe 's/(.*\p{Han}+.*)/<!--- \1 -->/g' main.md

# Uncomment commented paragraphs
perl -CSD -Mutf8 -i -pe 's/(<!--- <!-- )(.*)( --> -->)/<!-- \2 -->/g' main.md

# Generate `en.docx`
pandoc -C -N -M reference-section-title="References" main.md -o en.docx

# Generate `en.tex`
pandoc --natbib --wrap=none main.md -o en.tex

# Compile `en.tex` and `cn.tex`

# Restore to the original status
perl -CSD -Mutf8 -i -pe 's/(<!--- )(.*)( -->)/\2/g' main.md
