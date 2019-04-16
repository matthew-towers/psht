#!/bin/bash

# the following taken from
# https://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash
filenameWithExtension=$1
extension="${filenameWithExtension##*.}"
filename="${filenameWithExtension%.*}"

if [ $# -eq 1 ]  # one filename arg, so assume students and tutors
then
    if [ -e "${filename}_SOLUTIONS.tex" ]
    then
        echo "Solutions tex file already exists. Quitting."
        exit 1
    fi

    if [ -e "${filename}_TEMP.tex" ]
    then
        echo "Temp tex file already exists. Quitting."
        exit 1
    fi


    (echo -e '\\def\\CurrentAudience{tutors}'; cat "$filenameWithExtension") > "${filename}_SOLUTIONS.tex"

    (echo -e '\\def\\CurrentAudience{students}'; cat "$filenameWithExtension") > "${filename}_TEMP.tex"

    latexmk -pdf "${filename}_SOLUTIONS.tex"
    latexmk -c
    latexmk -pdf -jobname="$filename" "${filename}_TEMP.tex"
    latexmk -c

    rm "${filename}_TEMP.tex" 
    rm "${filename}_SOLUTIONS.tex"
else
    # further arguments were supplied, later ones are audiences
    # for each argument AUD after the first,
    #  - check if filename_AUD.tex exists. If so, quit
    #  - otherwise make filename_AUD.tex with the appropriate prefix
    #  - then compile it and clean up
    #  - then erase the temporary file filename_AUD.tex
    for audience in "${@:2}" 
    do
        if [ -e "${filename}_$audience.tex" ]
        then
            echo "${filename}_$audience.tex already exists. Quitting."
            exit 1
        fi
        (echo -e "\\def\\CurrentAudience{${audience}}"; cat "$filenameWithExtension") > "${filename}_${audience}.tex"
        latexmk -pdf "${filename}_${audience}.tex"
        latexmk -c
        rm "${filename}_${audience}.tex"
    done
fi
