#!/bin/bash

# the following taken from
# https://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash
filenameWithExtension=$1
extension="${filenameWithExtension##*.}"
filename="${filenameWithExtension%.*}"

(echo -e '\\def\\CurrentAudience{tutors}'; cat "$filenameWithExtension") > "${filename}_SOLUTIONS.tex"

(echo -e '\\def\\CurrentAudience{students}'; cat "$filenameWithExtension") > "${filename}_TEMP.tex"

latexmk -pdf "${filename}_SOLUTIONS.tex"
latexmk -c
latexmk -pdf -jobname="$filename" "${filename}_TEMP.tex"
latexmk -c

rm "${filename}_TEMP.tex" 
rm "${filename}_SOLUTIONS.tex"
