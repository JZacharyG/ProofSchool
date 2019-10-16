\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{handout}[2019/10/15 A document class for Proof School handouts]
\newcommand{\AnswerKeyName}{Answer Key}

\newif\ifshowname
\shownametrue
\DeclareOption{name}{\shownametrue}
\DeclareOption{noname}{\shownamefalse}

\newif\ifshowsolutions
\showsolutionsfalse
\DeclareOption{solutions}{\showsolutionstrue}
\DeclareOption{nosolutions}{\showsolutionsfalse}

\newif\if@cancelspace
\@cancelspacefalse
\DeclareOption{nospaces}{\@cancelspacetrue}
\DeclareOption{spaces}{\@cancelspacefalse}

\newif\if@showtitle
\@showtitletrue
\DeclareOption{title}{\@showtitletrue}
\DeclareOption{notitle}{\@showtitlefalse}

\newif\if@loadparskip
\@loadparskipfalse
\DeclareOption{parskip}{\@loadparskiptrue}
\DeclareOption{parindent}{\@loadparskipfalse}

%\newcommand{\section@symbol}{\S}
%\DeclareOption{noS}{\renewcommand{\section@symbol}{}}
%\DeclareOption{quiz}{\renewcommand{\section@symbol}{Quiz}}


\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}

%\ExecuteOptions{12pt, twoside, letterpaper}
\ProcessOptions\relax
\LoadClass{article}


\RequirePackage{tikz, tcolorbox}
\usetikzlibrary{calc, shapes.callouts, shapes.geometric}
\tcbuselibrary{skins}


\RequirePackage{letltxmacro, etoolbox, textcomp, url}



\RequirePackage{setspace}
\onehalfspacing

\RequirePackage[margin=.75in, headsep=.5\baselineskip, headheight=14.5 pt, footskip=\baselineskip]{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{mathtools,amsthm,amssymb}
\if@loadparskip
	%\RequirePackage[parfill]{parskip}
	\RequirePackage{parskip}
	\def\thm@space@setup{%
		\thm@preskip=\parskip \thm@postskip=0pt%
	}
\fi

\RequirePackage[OT1,T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage{microtype}

\newlength{\outsideparskip}
\setlength{\outsideparskip}{\parskip}














%%%%%%%%%% Theorems %%%%%%%%%%

\newcommand{\PStcbpath@hook}{%
	\path[draw, line cap=round, semithick, rounded corners=1mm]%
		([xshift=1.5in] frame.south west) --%(frame.south east) --%
		([xshift=-1.5mm] frame.south west) |-%
		(title.south east);%
	\path[draw, line cap=round, semithick]%
		(title.south east)%
			arc (-90:-40:.85mm)%
			arc (140:-130:.6mm);%
		%([xshift=1.5mm, yshift=3mm]frame.south east)
		%	arc (180:130:.85mm)
		%	arc (-50:220:.6mm);}
}
\newcommand{\PStcbpath@toploop}{%
	\path[draw, line cap=round, semithick, rounded corners=1mm]%
		(frame.south east) --%
		([xshift=-1.5mm] frame.south west) |-%
		(title.south east);%
	\path[draw, line cap=round, semithick]%
		(title.south east)%
			arc (-90:-20:1.1mm)%
			arc (160:-120:.55mm);%
}
\newcommand{\PStcbpath@doublein}{%
	\path[draw, line cap=round, semithick, rounded corners=1mm]%
		(frame.south east) --%
		([xshift=-1.5mm] frame.south west) |-%
		([xshift = 1mm]title.south east);%
	\path[draw, line cap=round, semithick]%
		([xshift = 1mm]title.south east)%
		arc (90:-90:.5mm) --%
		([yshift=-1mm, xshift=-0.5mm]title.south west);%
}
\newcommand{\PStcbpath@doubleout}{%
	\path[draw, line cap=round, semithick, rounded corners=1mm]%
		(frame.south east) --%
		([xshift=-1.5mm] frame.south west) |-%
		([yshift=-1mm]title.south east);%
	\path[draw, line cap=round, semithick]%
		([yshift=-1mm] title.south east)%
		arc (-90:90:.5mm) --%
		([xshift=-1.5mm]title.south west);%
}


\newcounter{tcbthm} % all theorems and definitions and everything share this counter
\setcounter{tcbthm}{0}

\newcommand{\newPStheorem}[2]{\newPStcbPair{#1}{#2}{}{\ (}{)}{\PStcbpath@hook}{fontupper=\itshape}}
\newcommand{\newPSdefinition}[2]{\newPStcbPair{#1}{#2}{}{\ }{}{\PStcbpath@hook}{}}
\newcommand{\newPSexample}[2]{\newPStcbPair{#1}{#2}{}{\textbf{:}\ }{}{\PStcbpath@doublein}{top=2.5mm}}

% #1: command
% #2: Category (as it is to be displayed)
% #3: end of title (always typeset)
% #4: before name (only typeset if a name is given for the the box)
% #5: after name (only typeset if a name is given for the the box)
% #6: frame path
% #7: additional code
% #8: number (in the starred versions, nothing, in the unstarred version, it should increment and print the number)
\newcommand{\newPStcbPair}[7]{
	\newPStcb{#1*}{#2}{#3}{#4}{#5}{#6}{#7}{}%
	\newPStcb{#1}{#2}{#3}{#4}{#5}{#6}{before upper={\addtocounter{tcbthm}{-1}\refstepcounter{tcbthm}},#7}{\stepcounter{tcbthm}\ \thetcbthm}%
}
\newcommand{\newPStcb}[8]{
	\newtcolorbox{#1}[1][\@nil]{
		before upper={\setlength{\parskip}{\outsideparskip}},
		title={\raisebox{0pt}[\height][0pt]{\textbf{#2#8}% raisebox is there to smash the depth, so that the hight of the title above the frame line is consistent.  There may well be a better way to do this!
			\def\tmp{##1}\ifx\tmp\@nnil\else#4\tmp#5\fi#3}},
		enhanced,
		empty,
		boxrule=0mm,
		boxsep=0mm,
		left=0mm,
		right=0mm,
		top=1.5mm,
		bottom=1.5mm,
		coltitle=black,
		attach boxed title to top left,
		boxed title style={
			empty,
			boxrule=0mm,
			boxsep=0mm,
			left=0mm,
			right=0mm,
			top=0mm,
			bottom=1.5mm,
		},
		frame code={#6},
		#7
	}
}

\newPStheorem{theorem}{Theorem}
\newPStheorem{lemma}{Lemma}
\newPStheorem{corollary}{Corollary}
\newPStheorem{claim}{Claim}
\newPStheorem{conjecture}{Conjecture}
\newPStheorem{proposition}{Proposition}
\newPSdefinition{definition}{Definition}
\newPSexample{example}{Example}

















%%%%%%%%%% Problem Environment %%%%%%%%%%

\RequirePackage[shortlabels]{enumitem}

\setlist[enumerate,1]{label={\arabic*.}}
\setlist[enumerate,2]{label={\alph*)}}
\setlist[enumerate,3]{label={\roman*)}}
\setlist[enumerate]{align=left, leftmargin=*, labelindent=0em, labelwidth=0em, labelsep=.5em}
\setlist[enumerate]{topsep=-\parskip, noitemsep}
\setlist[itemize]{topsep=-\parskip, noitemsep}

\newlist{prob}{enumerate}{3}
\setlist[prob,1]{label={\arabic*.}, ref={\arabic*}}
\setlist[prob,2]{label={\alph*)}, ref={\arabic{probi}\alph*}}
\setlist[prob,3]{label={\roman*)}, ref={\alph{probii}\;\!\roman*)}}
%\setlist[probs]{align=left, leftmargin=*, labelindent=0em, labelwidth=0em, itemindent=0em}
\setlist[prob]{align=left, leftmargin=!, labelindent=0em, labelsep=.5em, labelwidth=1em}


\SetEnumitemKey{bonus}{format={\makebox[0pt][r]{$\star$\hspace{0.5pt}}}}
\SetEnumitemKey{discuss}{format={\makebox[0pt][r]{\tikz{
	\node[draw, ellipse callout, callout pointer arc=30, callout relative pointer={(0.3ex, -0.5ex)}, minimum width=1.25ex, minimum height=.8ex, inner sep=0pt, outer sep=2pt] at (.3ex, -.4ex){};
	\node[draw, fill=white, ellipse callout, callout pointer arc=30, callout relative pointer={(-0.3ex, -0.6ex)}, minimum width=1.25ex, minimum height=.8ex, inner sep=0pt, outer sep=2pt] {};
}\hspace{0.5pt}}}}
\SetEnumitemKey{stop}{format={\makebox[0pt][r]{\tikz[baseline=(sign.south)]{\node[draw, regular polygon, regular polygon sides=8, minimum width=.8em, inner sep=0pt] (sign){\makebox[0pt][c]{\resizebox{.65em}{.25em}{\textsf{STOP}}}};}\hspace{0.5pt}}}}
\SetEnumitemKey{exciting}{format={\makebox[0pt][r]{\textit{\makebox[2pt][l]{\raisebox{0.5pt}{\small!}}!}\hspace{0.5pt}}}}
\SetEnumitemKey{surprising}{format={\makebox[0pt][r]{\textit{\textinterrobang}\hspace{0.5pt}}}}
\SetEnumitemKey{play}{format={\makebox[0pt][r]{\raisebox{-2pt}[0pt][0pt]{\tikz[scale=.18]{
	\draw (0,0) circle (1);
	\draw[fill=gray, rotate=25] (0,1) arc (90:-90:0.75 and 1) arc (-90:90:0.15 and 1);
	\draw[fill=lightgray, rotate=25] (0,1) arc (90:270:0.6 and 1) arc (270:90:1);
}}\hspace{0.5pt}}}}
\SetEnumitemKey{calculator}{format={\makebox[0pt][r]{\raisebox{-1.5pt}[0pt][0pt]{\resizebox{.9em}{!}{\tikz{\node[draw,rounded corners=3pt, inner sep=1pt]{$\kern-.2em\begin{smallmatrix}+-\\\times\div\end{smallmatrix}\kern-.2em$}}}}\hspace{0.5pt}}}}
%\SetEnumitemKey{surprising}{format={\makebox[0pt][r]{\tikz[baseline=(txt.base)]{\node[inner xsep=0pt, xshift=.6pt] (txt1){\phantom{?}};\clip (txt1.south west) rectangle (txt1.north east);\node[xslant=-.23](txt){\textit{\textinterrobang}};}\hspace{0.5pt}}}}


\newif\if@showpoints        \@showpointsfalse
\newif\if@usedefaultspace   \@usedefaultspacetrue
\newif\if@probsincolumns    \@probsincolumnsfalse
\newif\if@inacolumn         \@inacolumnfalse
\newif\if@usenaturalheight
\newif\if@insolution        \@insolutionfalse
\newif\if@firstprob         \@firstprobtrue

\newcommand{\ProbsInColumns}[1]{\ifnum#1=0 \@probsincolumnsfalse\else\@probsincolumnstrue\def\@numcolumns{#1}\fi}
\newcommand{\ProbsNotInColumns}{\ProbsInColumns{0}}

\enitkv@key{}{points}{\@showpointstrue\def\v{#1}}
\enitkv@key{}{space}[1]{\set@solutionspace{#1}\@usedefaultspacefalse}
\SetEnumitemKey{nospace}{space=0pt}
\enitkv@key{}{columns}[3]{\ProbsInColumns{#1}}

\newlength{\probcolsep}     \setlength{\probcolsep}{0.5cm}

\newcommand{\ifsoln}[2][]{\ifshowsolutions{#2}\else{#1}\fi}

\newcommand{\pointssymbol}{$^\text{p\!\underline{\,ts}}$}
\newcommand{\pointsymbol}{$^\text{p\!\underline{\,t}}$}

\newsavebox{\solutionbox}
\newcommand{\SolutionPrefixFont}{\bfseries}
\newcommand{\SolutionPrefix}{SOLUTION:\ }

\newcommand{\allow@solution}{%
	\def\solution{\@ifstar\solution@star\solution@nostar}%
	\def\solution@star%
	{%
		\@usenaturalheighttrue%
		\solution@nostar%
	}%
	\def\solution@nostar%
	{%
		\@insolutiontrue%
		\begingroup\lrbox{\solutionbox}\minipage[t]{\linewidth}%
			\setlength{\parskip}{\outsideparskip}%
			{\SolutionPrefixFont\SolutionPrefix}%
			\ignorespaces%
	}%
}

\newcommand{\set@solutionspace}[1]{%
	\pgfmathparse{#1}%
	\ifpgfmathunitsdeclared%
		\def\@solutionspace{#1}%
	\else%
		\def\@solutionspace{\stretch{#1}}%
	\fi%
}

\LetLtxMacro{\old@prob}{\prob}
\LetLtxMacro{\old@endprob}{\endprob}

\renewcommand{\prob}[1][]{%
	\if@probsincolumns%
		\@inacolumntrue%
		\pgfmathparse{(\linewidth-((\@numcolumns)-1)*\probcolsep)/(\@numcolumns)}%
		\minipage[t]{\pgfmathresult pt}%
		\setlength{\parskip}{\outsideparskip}%
	\fi%
	\@probsincolumnsfalse%
	\@usenaturalheightfalse%
	\def\@solutionspace{0pt}%
	\@showpointsfalse%
	\@usedefaultspacetrue%
	\allow@solution%
	\if@firstprob%
		\old@prob[series=pro, #1]%
	\else%	
		\old@prob[resume=pro, #1]%
	\fi%
	\@firstprobtrue%
	\item \if@showpoints(\v\if\v1\relax\:\!\pointsymbol\else\,\pointssymbol\fi)\fi%
}

\renewcommand{\endprob}{%
	\if@insolution%
		\endminipage\endlrbox\endgroup%
		\par%
		\ifshowsolutions%
			\if@cancelspace%
				\@usenaturalheighttrue%
			\fi%
			\if@usenaturalheight%
				% I used to have \vspace*{2\lineskip} before the \par, but now I'm not sure why that was needed...
				\usebox{\solutionbox}{}\par% show solution, natural space
				\@usedefaultspacefalse%
				\def\@solutionspace{0pt}%
			\else%
				\raisebox{0pt}[0pt][0pt]{\usebox{\solutionbox}}\par\vspace*{\dimexpr -\baselineskip-\parskip}% show solutions, fixed space
			\fi%
		\fi%
	\else%
		\par%
	\fi%
	\if@usedefaultspace%
		\def\@solutionspace{0pt}%
		\if@firstprob%
			\def\@solutionspace{\stretch{1}}%
		\fi%
	\fi%
	\old@endprob%
	\if@cancelspace%
		\def\@solutionspace{0pt}%
	\fi%
	\if@inacolumn%
		\global\let\tmp@solutionspace\@solutionspace%
		\endminipage%
		\vspace*{\tmp@solutionspace}%
		\global\let\tmp@solutionspace\undefined%	
		\hfill%
	\else%
		\vspace*{\@solutionspace}%
	\fi%
}
\AfterEndEnvironment{prob}{\global\@firstprobfalse\ignorespaces}











%%%%%%%%%% Headers and Footers %%%%%%%%%%

\fancypagestyle{firstpage}{%
	\fancyhead{}
	\renewcommand{\headrule}{}
}

\pagestyle{fancy}
\fancyhf{}% clear default for head and foot
\fancyfoot[R]{Page \thepage\ of \pageref{LastPage}}
\fancyfoot[L]{{\SpoilerFont\@spoilertext}}
\fancyhead[L]{\FancyShortTitle}
\ifshowname
	\fancyhead[RO]{\NameLine}
\fi
%\renewcommand\headrule{\vskip-.7\baselineskip\hrulefill\quad\raisebox{-.5ex}{\decofourleft}~\raisebox{-0.7975 ex}{\squircle}~\raisebox{-.5ex}{\decofourright}\quad\hrulefill}
\renewcommand\headrule{\vskip-.7\baselineskip\hrulefill\quad\raisebox{-.5\height}{\squircle}\quad\hrulefill}

\newcommand{\TitleFont}{\large\bfseries\boldmath}
\def\Title{}
\def\ShortTitle{}
\renewcommand{\title}[2][\@nil]{
	\def\ShortTitle{#1}
	\ifx\ShortTitle\@nnil
		\def\ShortTitle{#2}
	\fi
	\def\Title{#2}
}

\def\Block{}
\newcommand{\block}[1]{\def\Block{#1}}

\newcommand{\SchoolNameFont}{\scshape}
\def\SchoolName{Proof School}
\newcommand{\school}[1]{\def\SchoolName{#1}}

\def\SchoolYear{YYYY--YY}
\newcommand{\schoolyear}[1]{\def\SchoolYear{#1}}

\newcommand{\CourseNameFont}{\large}
\def\CourseName{}
\newcommand{\course}[1]{\def\CourseName{#1}}

\def\InstructorName{}
\def\InstructorFullName{}
\newcommand{\instructor}[2][\@nil]{
	\def\InstructorFullName{#1}
	\ifx\InstructorFullName\@nnil
		\def\InstructorFullName{#2}
	\fi
	\def\InstructorName{#2}
}

\def\UnitName{}
\newcommand{\unit}[1]{\def\UnitName{#1}}

\def\UnitNumber{}
\newcommand{\unitnumber}[1]{\def\UnitNumber{#1}}

\def\WeekNumber{}
\newcommand{\weeknumber}[1]{\def\WeekNumber{#1}}

\def\SheetNumber{}
\newcommand{\sheetnumber}[1]{\def\SheetNumber{#1}}


\let\author\undefined
\let\date\undefined % TODO: you should be able to specify the date!

\def\StudentName{}
\newcommand{\studentname}[1]{\def\StudentName{#1}}

\newcommand{\fancysetlength}[2]{%
	\pgfmathparse{#2}%
	\ifpgfmathunitsdeclared%
		\setlength{#1}{#2}%
	\else%
		\setlength{#1}{\stretch{#2}}%
	\fi%
}

\newlength{\@blanklength}
\newbox{\@blanktext}

\newcommand{\blank}{\@ifstar\blank@starred\blank@unstarred}
\newcommand{\blank@unstarred}[2][]{\filledblank@unstarred[#1]{}{#2}}
\newcommand{\blank@starred}[2][]{\filledblank@starred[#1]{}{#2}}

\newcommand{\filledblank}{\@ifstar\filledblank@starred\filledblank@unstarred}
\newcommand{\filledblank@unstarred}[3][]{\filledblank@starred[\smash{#1}]{\smash{#2}}{#3}}
\newcommand{\filledblank@starred}[3][]{%
	\leavevmode%
	\begingroup%
		\savebox{\@blanktext}{\ifsoln[#2]{#1}}%
		\fancysetlength{\@blanklength}{#3}%
		\hspace*{\glueexpr \@blanklength/2}%
		\makebox[0pt][c]{\usebox{\@blanktext}}%
		\hspace*{\glueexpr \@blanklength/-2}%
		\leaders\hrule height \dimexpr -\dp\@blanktext-1.2pt depth \dimexpr \dp\@blanktext+1.6pt\hskip \@blanklength\kern\z@%
	\endgroup%
}


\let\oldS\S
\def\S{{\fontfamily{cmr}\selectfont\oldS}} % I really don't like the bold section symbol that Latin Modern uses with T1 encoding... although their normal weight version is pretty decent.  The Computer Modern with T1 is my favorite combo, I think.
\newcommand{\SheetNumberPrefix}{\S}
\newcommand{\SheetNumberPostfix}{\ }
\newcommand{\FancySheetNumber}{%
	\ifx\SheetNumber\empty\else%
		\SheetNumberPrefix%
		\ifx\UnitNumber\empty\else%
			\UnitNumber.%
		\fi%
		\SheetNumber%
		\SheetNumberPostfix%
	\fi%
}
\newcommand{\FancyTitle}{\FancySheetNumber\Title\mbox{}}
\newcommand{\FancyShortTitle}{\FancySheetNumber\ShortTitle\mbox{}}

\newcommand{\NameLine}{\ifshowname\NameLineText\filledblank[\textbf{\AnswerKeyName}]{\StudentName}{\NameLineLength}\fi}

\newcommand{\NameLineText}{Name:~}
\newlength{\NameLineLength}
\setlength{\NameLineLength}{1.75in}

\newlength{\@namewidth}
% This is soon to be deprecated
\newcommand{\headerZG}{%
	\ifshowname%
		\settowidth{\@namewidth}{\NameLineText}%
		\addtolength{\@namewidth}{\dimexpr \NameLineLength+1em}%
	\else%
		\setlength{\@namewidth}{0pt}%
	\fi%
	\begin{minipage}[t]{\dimexpr \linewidth-\@namewidth}%
		{\TitleFont%
		\FancyTitle\\}%
		{\CourseNameFont%
			\CourseName%
			\ifx\UnitName\empty\else%
				: \UnitName%
			\fi%
		}%
	\end{minipage}%
	\begin{minipage}[t]{\@namewidth}%
		\raggedleft%
		\NameLineText\begin{minipage}[t]{\NameLineLength}%
			\filledblank[\textbf{\AnswerKeyName}]{\StudentName}{\NameLineLength}\\%
			\centerline{\SchoolYear \quad \squircle \quad Block \Block}%
		\end{minipage}%
		%Date:~\blank{\NameLineLength}%
	\end{minipage}%
}
% This is soon to be deprecated
\newcommand{\headerZGpic}[1]{%
	\newsavebox{\headerZG@pic}%
	\savebox{\headerZG@pic}{\raisebox{\depth}{#1}}%
	\ifshowname%
		\settowidth{\@namewidth}{\NameLineText}%
		\addtolength{\@namewidth}{\dimexpr \NameLineLength+.25em}%
	\else%
		\setlength{\@namewidth}{0pt}%
	\fi%
	\noindent%
	\usebox\headerZG@pic%
	\hfill%
	\begin{minipage}[b][\ht\headerZG@pic][c]{\dimexpr \linewidth-\wd\headerZG@pic-.25em-\@namewidth}%
		\centering%
		{\TitleFont%
		\strut\FancyTitle\\}%
		{\CourseNameFont%
			\CourseName%
			\ifx\UnitName\empty\else%
				: \UnitName%
			\fi%
		}%
	\end{minipage}%
	\ifshowname%
		\begin{minipage}[b][\ht\headerZG@pic][t]{\@namewidth}%
			\raggedleft%
			\NameLineText\begin{minipage}[t]{\NameLineLength}%
			\filledblank[\textbf{\AnswerKeyName}]{\StudentName}{\NameLineLength}\\[-4pt]%
			\centering \SchoolYear \quad \squircle \quad Block \Block%
			\end{minipage}%
		\end{minipage}%
	\fi%
}

\newlength{\HeaderHeight}
\setlength{\HeaderHeight}{1in}
\newcommand{\boxedheader}[6]{%
	\fbox{%
		\setlength{\dimen255}{\dimexpr \textwidth-2\fboxrule-2\fboxsep}%
		\makebox[0pt][l]{\parbox[b][\HeaderHeight]{\dimen255}{%
			\raggedright #1\vfill}}%
		\makebox[0pt][l]{\parbox[b][\HeaderHeight]{\dimen255}{%
			\centering #2\vfill}}%
		\makebox[0pt][l]{\parbox[b][\HeaderHeight]{\dimen255}{%
			\raggedleft #3\vfill}}%
		\makebox[0pt][l]{\raisebox{0pt}[\height][0pt]{\parbox[b][\HeaderHeight]{\dimen255}{%
			\raggedright\vspace*{\fill}#4}}}%
		\makebox[0pt][l]{\raisebox{0pt}[\height][0pt]{\parbox[b][\HeaderHeight]{\dimen255}{%
			\centering\vspace*{\fill}#5}}}%
		\makebox[0pt][l]{\raisebox{0pt}[\height][0pt]{\parbox[b][\HeaderHeight]{\dimen255}{%
			\raggedleft\vspace*{\fill}#6}}}%
		\raisebox{0pt}[\height][0pt]{\parbox[b][\HeaderHeight]{\dimen255}{%
			\centering\vspace*{\fill}\TitleFont\strut\FancyTitle\strut\vspace*{\fill}}}%
	}%
}

\newcommand{\tcboxedheader}[6]{%
	\begin{tcolorbox}[
		enhanced, empty,
		boxrule=0pt, boxsep=0pt,
		left=0pt, right=0pt, top=0pt, bottom=0pt,
		% rounded corners=1mm if you want to match the theorems?
		frame code={\draw[rounded corners] ([shift={(-1.5mm,-1.5mm)}]frame.south west) rectangle ([shift={(1.5mm,1.5mm)}]frame.north east);}]
		\makebox[0pt][l]{\parbox[b][\HeaderHeight]{\textwidth}{%
			\raggedright #1\vfill}}%
		\makebox[0pt][l]{\parbox[b][\HeaderHeight]{\textwidth}{%
			\centering #2\vfill}}%
		\makebox[0pt][l]{\parbox[b][\HeaderHeight]{\textwidth}{%
			\raggedleft #3\vfill}}%
		\makebox[0pt][l]{\raisebox{0pt}[\height][0pt]{\parbox[b][\HeaderHeight]{\textwidth}{%
			\raggedright\vspace*{\fill}#4}}}%
		\makebox[0pt][l]{\raisebox{0pt}[\height][0pt]{\parbox[b][\HeaderHeight]{\textwidth}{%
			\centering\vspace*{\fill}#5}}}%
		\makebox[0pt][l]{\raisebox{0pt}[\height][0pt]{\parbox[b][\HeaderHeight]{\textwidth}{%
			\raggedleft\vspace*{\fill}#6}}}%
		\raisebox{0pt}[\height][0pt]{\parbox[b][\HeaderHeight]{\textwidth}{%
			\centering\vspace*{\fill}\TitleFont\strut\FancyTitle\strut\vspace*{\fill}}}%
	\end{tcolorbox}
}

\newcommand{\FirstPageHeader}{\headerZG}

\renewcommand{\maketitle}{%
	\thispagestyle{firstpage}%
	\noindent%
	\FirstPageHeader%
	%\let\maketitle\undefined%
	\par%
	\bigskip%
	\vspace{-\parskip}%
	% FIX ME: \noindent for first line of text after heading?
}
\if@showtitle
	\AtBeginDocument{\maketitle}
\fi









%%%%%%%%%% Assorted %%%%%%%%%%

\newcommand{\squircle}[1][]{\settoheight{\dimen255}{I}\resizebox{\dimen255}{!}{\tikz{\draw[very thick,#1] (0, 0) rectangle (.4, .4) (.2,.2) circle (.1);}}}
\renewcommand{\qedsymbol}{\squircle}

\newcommand{\SpoilerFont}{\itshape}
\newcommand{\@spoilertext}{}
\newcommand{\DefaultSpoilerText}{Spoilers ahead! Proceed with caution\ldots}
\newcommand{\spoilerbreak}[1][\DefaultSpoilerText]{\renewcommand{\@spoilertext}{#1}\newpage\renewcommand{\@spoilertext}{}}

\newcommand{\bonus}{{\Large{$\star$}}}

% I just think there is too much space around displayed equations?
\apptocmd\normalsize{%
	\abovedisplayskip=7pt plus 3pt minus 4pt%
	\abovedisplayshortskip=0pt plus 3pt%
	\belowdisplayskip=7pt plus 3pt minus 4pt%
	\belowdisplayshortskip=7pt plus 3pt minus 4pt%
}{}{}

\RequirePackage{xstring}
%\newcommand{\smartoverline}[2][\@nil]{%
%	{\def\tmp{#1}%
%	\ifx\tmp\@nnil%
%		\StrChar{#2}{1}[\tmp]%
%		\IfSubStr{Uacehikqtxy}{\tmp}{\def\tmp{0.04em}}{%
%		\IfSubStr{CGIOQdgjosz}{\tmp}{\def\tmp{0.1em}}{%
%		\IfSubStr{BDEFHJKLMNPRXZSf}{\tmp}{\def\tmp{0.16em}}{%
%		\IfSubStr{A}{\tmp}{\def\tmp{0.2em}}{\def\tmp{0em}}}}}%
%	\fi%
%	\mathmakebox[0pt][l]{\hspace*{\tmp}\overline{\mathmakebox[\dimexpr \width-\tmp]{\phantom{#2}}}}}#2%
%}
% The optional argument, if present, is used in place of the required argument for the purpose of computing the initial offset.
% useful if you want to put an overline over something set in \mathit, for example.
\newcommand{\smartoverline}[2][\@nil]{%
	{\def\tmp{#1}%
	\ifx\tmp\@nnil%
		\StrChar{#2}{1}[\tmp]%
	\else%
		\StrChar{#1}{1}[\tmp]%
	\fi%
	\IfSubStr{Uacehikqtxy}{\tmp}{\def\tmp{0.04em}}{%
	\IfSubStr{CGIOQdgjosz}{\tmp}{\def\tmp{0.1em}}{%
	\IfSubStr{BDEFHJKLMNPRXZSf}{\tmp}{\def\tmp{0.16em}}{%
	\IfSubStr{A}{\tmp}{\def\tmp{0.2em}}{\def\tmp{0em}}}}}%
	\mathmakebox[0pt][l]{\hspace*{\tmp}\overline{\mathmakebox[\dimexpr \width-\tmp]{\phantom{#2}}}}}#2%
}

\newcommand{\intersentencespace}{\spacefactor\sfcode`. \space}
