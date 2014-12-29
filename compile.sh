#!/bin/bash
project=Resume

latexmk -shell-escape -pdf -e '$pdflatex=q/pdflatex %O -synctex=1 %S/' $project.tex
latexmk -c
rm "$project.synctex.gz"
