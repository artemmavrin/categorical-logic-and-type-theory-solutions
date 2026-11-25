\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{solutions}

% Base class
\PassOptionsToPackage{paper=letter}{typearea}
\LoadClass[fontsize=12pt, oneside, chapterprefix, numbers=noenddot]{scrbook}

% Fonts
\RequirePackage[no-math]{fontspec}
\setmainfont{Latin Modern Roman}
\setsansfont{Latin Modern Sans}
\setmonofont{Latin Modern Mono}
\RequirePackage{microtype}

% Math packages
\let\openbox\relax
\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage{mathtools}
\RequirePackage{xfrac}

% Latin Modern Math, with XITS Math for the script alphabets and \sslash.
\RequirePackage{unicode-math}
\setmathfont{Latin Modern Math}
\setmathfont[range={\mathscr,\mathbfscr,\sslash}]{XITS Math}

% Proof trees in the style of the sequent calculus
% https://www.ctan.org/pkg/bussproofs
\RequirePackage{bussproofs}

% Page Formatting
\RequirePackage[automark,markcase=upper]{scrlayer-scrpage}
\automark{chapter}
\clearpairofpagestyles
\ihead{\headmark}
\ohead{\pagemark}
\cfoot[\pagemark]{}
\setkomafont{pagehead}{\normalfont\slshape}
\renewcommand*\chaptermarkformat{\chapapp\nobreakspace\thechapter.\enskip}
\pagestyle{scrheadings}
\flushbottom

% Programming tools
\RequirePackage{etoolbox}

% Colors
\RequirePackage{xcolor}
\colorlet{@linkcolor}{purple}
\colorlet{@citecolor}{purple}

% Hyperlinks
\RequirePackage[hyperfootnotes=false]{hyperref}
\RequirePackage{bookmark}
\RequirePackage[capitalize]{cleveref}
\hypersetup{
    pdfborder={0 0 0},
    linktoc=all,
    colorlinks=true,
    citecolor=@citecolor,
    linkcolor=@linkcolor,
}
\AtEndPreamble{
    \hypersetup{
        pdfauthor={\@author},
        pdftitle={\@title},
    }
}

% Good practices
\RequirePackage[all, error]{onlyamsmath}
\RequirePackage[l2tabu, orthodox]{nag}

% Theorems and breakable exercise frames
\RequirePackage{keytheorems}
\RequirePackage{tcolorbox}
\tcbuselibrary{breakable}

% Exercise and solution environments
\newcommand\@exerciselabel[3]{\label{ex:#1.#2.#3}}
\newkeytheoremstyle{exercisestyle}{
    headfont=\bfseries,
    bodyfont=\normalfont,
    headformat={\NUMBER\NOTE},
    spaceabove=\parsep,
    spacebelow=\parsep,
}
\newkeytheorem{exercise}[
    name={},
    style=exercisestyle,
    within=section,
    refname={Exercise,Exercises},
    Refname={Exercise,Exercises},
    postheadhook={%
    \@exerciselabel{\arabic{chapter}}{\arabic{section}}{\arabic{exercise}}%
    \phantomsection%
    \addcontentsline{toc}{subsection}{\arabic{chapter}.\arabic{section}.\arabic{exercise}}%
    },
    tcolorbox-no-titlebar={
        breakable,
        colback=gray!5,
        colframe=black,
        boxrule=0.4pt,
        arc=2pt,
        boxsep=0pt,
        left=10pt,
        right=10pt,
        top=6pt,
        bottom=10pt,
        pad at break=10pt,
    },
]
\newenvironment{solution}[1][Solution]{\begin{proof}[#1]}{\end{proof}}
\newenvironment{altsolution}[1][Alternative Solution]{\begin{proof}[#1]}{\end{proof}}

% Equation and figure numbering
\numberwithin{equation}{exercise}
\numberwithin{figure}{exercise}

% Theorem-like environments
\newkeytheorem{theorem}[within=exercise, style=plain]
\newkeytheorem{lemma}[sibling=theorem, style=plain]
\newkeytheorem{proposition}[sibling=theorem, style=plain]
\newkeytheorem{corollary}[sibling=theorem, style=plain]
\newkeytheorem{claim}[sibling=theorem, style=plain]
\newkeytheorem{definition}[sibling=theorem, style=definition]
\newkeytheorem{example}[sibling=theorem, style=definition]
\newkeytheorem{counterexample}[sibling=theorem, style=definition]
\newkeytheorem{remark}[sibling=theorem, style=definition]
\newkeytheorem{observation}[sibling=theorem, style=definition]
\newkeytheorem{notation}[sibling=theorem, style=definition]
\newkeytheorem{axiom}[sibling=theorem, style=definition]
\crefname{claim}{Claim}{Claims}
\crefname{counterexample}{Counterexample}{Counterexamples}
\crefname{observation}{Observation}{Observations}
\crefname{notation}{Notation}{Notations}
\crefname{axiom}{Axiom}{Axioms}

% Custom lists (e.g., exercise parts lists)
\RequirePackage{enumitem}

% Redefine enumerate behavior
\setlist[enumerate, 1]{label=(\alph*)}
\setlist[enumerate, 2]{label=(\alph*)}

% Exercise parts list
\newlist{parts}{enumerate}{2}
\setlist[parts, 1]{label={(\roman*)}}
\crefname{partsi}{Part}{Parts}

% Use \part instead of \item in parts environments for automatic label generation
\newcommand\@partlabel[4]{\label{ex:#1.#2.#3.#4}}
\newcommand*\@exercisepart{\item\@partlabel{\arabic{chapter}}{\arabic{section}}{\arabic{exercise}}{\roman{partsi}}}
\AtBeginEnvironment{parts}{\let\part\@exercisepart}

% Solution for a problem
\newenvironment{partsolution}[1]{\begin{solution}[Solution, {\normalfont\partref{\arabic{chapter}}{\arabic{section}}{\arabic{exercise}}{#1}}]}{\end{solution}}
\newenvironment{altpartsolution}[1]{\begin{altsolution}[Alternative Solution, {\normalfont\partref{\arabic{chapter}}{\arabic{section}}{\arabic{exercise}}{#1}}]}{\end{altsolution}}

% Remove indent after environments
\newcommand*\@NoIndentAfter{%
    \@ifnextchar\par{%
        \def\par{%
            \everypar{\setbox\z@\lastbox\everypar{}}%
            \@restorepar%
        }%
    }{}%
}
\newrobustcmd*{\NoIndentAfterThis}{\@NoIndentAfter\par\par}

\AfterEndEnvironment{theorem}{\NoIndentAfterThis}
\AfterEndEnvironment{lemma}{\NoIndentAfterThis}
\AfterEndEnvironment{proposition}{\NoIndentAfterThis}
\AfterEndEnvironment{corollary}{\NoIndentAfterThis}
\AfterEndEnvironment{claim}{\NoIndentAfterThis}
\AfterEndEnvironment{proof}{\NoIndentAfterThis}
\AfterEndEnvironment{definition}{\NoIndentAfterThis}
\AfterEndEnvironment{example}{\NoIndentAfterThis}
\AfterEndEnvironment{counterexample}{\NoIndentAfterThis}
\AfterEndEnvironment{remark}{\NoIndentAfterThis}
\AfterEndEnvironment{observation}{\NoIndentAfterThis}
\AfterEndEnvironment{notation}{\NoIndentAfterThis}
\AfterEndEnvironment{axiom}{\NoIndentAfterThis}
\AfterEndEnvironment{enumerate}{\NoIndentAfterThis}
\AfterEndEnvironment{exercise}{\NoIndentAfterThis}
\AfterEndEnvironment{parts}{\NoIndentAfterThis}

% Drawing
\RequirePackage{tikz}
\usetikzlibrary{calc,arrows,cd,positioning}
\tikzcdset{
    diagrams={sep=large},
    arrow style=tikz,
}

% Captions for, e.g., figures
\RequirePackage[labelfont=bf, margin=\parindent]{caption}

% Comma between consecutive footnotes
\RequirePackage[multiple]{footmisc}

% Bibliography/references
\RequirePackage[backend=biber]{biblatex}
% Allow a URL to break inside a word when punctuation breaks do not fit.
\setcounter{biburllcpenalty}{9000}

% Generate solutions body
\newcommand\@MAXCHAPTERS{100}
\newcommand\@MAXSECTIONS{100}
\newcommand\@MAXEXERCISES{100}
\newcommand\@twodigits[1]{%
    \ifnumless{#1}{10}{0#1}{#1}%
}
\newcommand\@chapterdir{}
\newcommand\@sectiondir{}
\newcommand\@exercisefilenoext{}
\newcommand\@chapterlabel[1]{\label{ch:#1}}
\newcommand\@sectionlabel[1]{\label{section:\arabic{chapter}.#1}}
\newcommand{\GenerateSolutions}{
% Loop over chapters
    \foreach \@c in {0,1,...,\@MAXCHAPTERS}{%
        \renewcommand\@chapterdir{./chapters/\@twodigits{\@c}}
        % Each chapter directory should have a main.tex that defines the \chapter
        % for that chapter
        \IfFileExists{\@chapterdir/main.tex}{
        % Advance chapter counter to force correct numbering
            \setcounter{chapter}{\@c}
            \addtocounter{chapter}{-1}
            % Read chapter heading
            \input{\@chapterdir/main}
            % Add chapter label
            \@chapterlabel{\arabic{chapter}}%

            % Loop over sections
            \foreach \@s in {0,1,...,\@MAXSECTIONS}{%
                \renewcommand\@sectiondir{\@chapterdir/sections/\@twodigits{\@s}}
                % Each section directory should have a main.tex that defines the \chapter
                % for that chapter
                \IfFileExists{\@sectiondir/main.tex}{
                % Advance section counter to force correct numbering
                    \setcounter{section}{\@s}
                    \addtocounter{section}{-1}
                    % Read section heading
                    \input{\@sectiondir/main}
                    % Add section label
                    \@sectionlabel{\arabic{section}}%

                    % Loop over exercises in the chapter
                    \foreach \@e in {1,2,...,\@MAXEXERCISES}{%
                        \renewcommand\@exercisefilenoext{\@sectiondir/exercises/\@twodigits{\@e}}
                        \IfFileExists{{\@exercisefilenoext}.tex}{
                        % Advance exercise environment counter based on name from file name
                            \setcounter{exercise}{\@e}%
                            \addtocounter{exercise}{-1}%
                            % Include exercise + solution
                            \input{\@exercisefilenoext}
                        }{}%
                    }{}%
                }{}%
            }%
        }{}%
    }%
}

% Referencing shortcuts
\newcommand\chref[1]{\hyperref[ch:#1]{Chapter~#1}}
\newcommand\exref[3]{\hyperref[ex:#1.#2.#3]{Exercise~#1.#2.#3}}
\newcommand\partref[4]{\ref{ex:#1.#2.#3.#4}}
\newcommand\expartref[4]{\hyperref[ex:#1.#2.#3.#4]{Exercise~#1.#2.#3(#4)}}

% Keep section titles and exercise links inline beneath each chapter.
\newcommand*\@tocsectionnumber[1]{#1.}
\newcommand*\@tocentryseparator{,\space\space}
\DeclareTOCStyleEntry[
    indent=0pt,
    rightindent=0pt,
    entryformat=\textit,
    entrynumberformat=\@tocsectionnumber,
    prepagenumber={},
    pagenumberformat=\@gobble,
    onendentry=\@tocentryseparator,
]{toctext}{section}
\DeclareTOCStyleEntry[
    indent=0pt,
    rightindent=0pt,
    prepagenumber={},
    pagenumberformat=\@gobble,
    onendentry=\@tocentryseparator,
]{toctext}{subsection}
\setuptoc{toc}{totoc}

% Title and headings
\setkomafont{disposition}{\normalfont\bfseries}
\setkomafont{title}{\normalfont}
\setkomafont{chapter}{\huge}
\setkomafont{chapterprefix}{\huge}
\setkomafont{section}{\normalfont\itshape\large}
\renewcommand*\sectionformat{\thesection\hspace{10pt}}
\RedeclareSectionCommand[
    beforeskip=0pt,
    innerskip=10pt,
    afterskip=14pt,
    afterindent=false,
]{chapter}
\RedeclareSectionCommand[afterskip=1.5ex plus 0.2ex]{section}
