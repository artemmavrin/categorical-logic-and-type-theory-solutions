$ENV{'TZ'}='America/Los_Angeles';

# Use LuaLaTeX
$pdf_mode = 4;
$lualatex = 'lualatex %O --interaction=nonstopmode --file-line-error --synctex=1 %S';

# Entry point
@default_files = ('solutions.tex');

# Bibliography backend (biber)
$bibtex_use = 2;
$biber = 'biber %O %S';

# Clean up auxiliary files
$clean_ext = 'synctex.gz synctex.gz(busy) run.xml tex.bak bbl bcf fdb_latexmk run tdo %R-blx.bib bbl-SAVE-ERROR';

# Enable recorder for better dependency tracking
$recorder = 1;

# Maximum number of compilation runs
$max_repeat = 5;

# Show CPU time used
$show_time = 1;
