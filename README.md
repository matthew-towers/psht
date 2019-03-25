# psht

This bash script compiles a problem sheet written in LaTeX into two pdf
files, one including solutions and one not including solutions.

To make it work you must have the
[`multiaudience`](https://ctan.org/pkg/multiaudience?lang=en) package
installed on your system, as well as
[`latexmk`](http://personal.psu.edu/jcc8//software/latexmk-jcc/).  Put `\usepackage{multiaudience}`,
`\SetNewAudience{students}`, and `\SetNewAudience{tutors}` in the
preamble.

Surround the parts of the LaTeX document you want to appear ONLY in the
solutions file with `\begin{shownto}{-, students} ...
\end{shownto}`. The `-` is negation.

Then run `./psht your-tex-file.tex`. This will create
`your-tex-file.pdf` and `your-tex-file_SOLUTIONS.pdf`. Compilation is
done using `latexmk` and the auxiliary files are removed afterwards.

A test file called `test.tex` is included as illustration.
