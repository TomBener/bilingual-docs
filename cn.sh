#!/bin/zsh
# Generate Chinese documents

# Comment all paragraphs
perl -CSD -Mutf8 -i -pe 's/(.*\S)/<!--- \1 -->/g' main.md

# Uncomment paragraphs which contain Chinese character and the generic HTML comment symbol
perl -CSD -Mutf8 -i -pe 's/<!--- (.*\p{Han}+.*) -->/\1/g; s/(<!--- <!-- )(.*)( --> -->)/<!-- \2 -->/g' main.md

# Generate `cn.docx`
pandoc -C -N -M reference-section-title="参考文献" --bibliography ref.bib main.md -o cn.docx

# Generate `cn.tex`
pandoc --natbib --wrap=none main.md -o cn.tex

# Compile `en.tex` and `cn.tex`

# Restore to the original status
perl -CSD -Mutf8 -i -pe 's/(<!--- )(.*)( -->)/\2/g' main.md
