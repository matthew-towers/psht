# psht

This bash script compiles a LaTeX document written using the
`multiaudience' package into multiple pdf files, one for each audience
specified.

To make it work you must have the
[`multiaudience`](https://ctan.org/pkg/multiaudience?lang=en) package
installed on your system, as well as
[`latexmk`](http://personal.psu.edu/jcc8//software/latexmk-jcc/).  You
need `\usepackage{multiaudience}` in the preamble.

If you run `./psht your-tex-file.tex`, psht will assume that there are
two audiences defined, students and tutors.  This means you must have 
`\SetNewAudience{students}`, and `\SetNewAudience{tutors}` in the
preamble.  It will create `your-tex-file.pdf` and
`your-tex-file_SOLUTIONS.pdf`. Compilation is done using `latexmk` and
the auxiliary files are removed afterwards.

Surround the parts of the LaTeX document you want to appear ONLY in the
solutions file with `\begin{shownto}{-, students} ...
\end{shownto}`. The `-` is negation.

A test file called `test.tex` is included as illustration.

If you supply more arguments after the filename, e.g. `./psht
your-tex-file.tex a b c` psht will compile a version of the document for
each additional argument `arg`, with the audience set to `arg`.  The
filenames will be `your-tex-file_arg.pdf`.

A test file called `multiple_audiences.tex` is included, which has three
audiences `a`, `b`, and `c`.
