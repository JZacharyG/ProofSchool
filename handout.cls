\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{handout}[2019/10/08 A document class for Proof School handouts]
\newcommand{\answerkeyname}{Answer Key}

\newif\if@showname
\@shownametrue
\DeclareOption{noname}{\@shownamefalse}

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
	\path[draw, line cap=round, thick, rounded corners=1mm]%
		(frame.south east) --%
		([xshift=-1.5mm] frame.south west) |-%
		([yshift=-1mm]title.south east);%
	\path[draw, line cap=round, thick]%
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
\enitkv@key{}{space}[1]{\set@solution@space{#1}\@usedefaultspacefalse}
\SetEnumitemKey{nospace}{space=0pt}
\enitkv@key{}{columns}[3]{\ProbsInColumns{#1}}

\newlength{\probcolsep}     \setlength{\probcolsep}{0.5cm}

\newcommand{\ifsoln}[2][]{\ifshowsolutions{#2}\else{#1}\fi}

\newcommand{\pointssymbol}{$^\text{p\!\underline{\,ts}}$}
\newcommand{\pointsymbol}{$^\text{p\!\underline{\,t}}$}

\newsavebox{\solutionbox}
\newcommand{\solutiontitle}{\textbf{SOLUTION:\ }}

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
			\solutiontitle%
			\ignorespaces%
	}%
}

\newcommand{\set@solution@space}[1]{%
	\pgfmathparse{#1}%
	\ifpgfmathunitsdeclared%
		\def\solution@space{#1}%
	\else%
		\def\solution@space{\stretch{#1}}%
	\fi%
}

\LetLtxMacro{\old@prob}{\prob}
\LetLtxMacro{\old@endprob}{\endprob}

\renewcommand{\prob}[1][]{%
	\if@probsincolumns%
		\@inacolumntrue%
		\pgfmathparse{(\linewidth-((\@numcolumns)-1)*\probcolsep)/(\@numcolumns)}%
		\minipage[t]{\pgfmathresult pt}%
	\fi%
	\@probsincolumnsfalse%
	\@usenaturalheightfalse%
	\def\solution@space{0pt}%
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
				\def\solution@space{0pt}%
			\else%
				\raisebox{0pt}[0pt][0pt]{\usebox{\solutionbox}}\par\vspace*{\dimexpr -\baselineskip-\parskip}% show solutions, fixed space
			\fi%
		\fi%
	\else%
		\par%
	\fi%
	\if@usedefaultspace%
		\def\solution@space{0pt}%
		\if@firstprob%
			\def\solution@space{\stretch{1}}%
		\fi%
	\fi%
	\old@endprob%
	\if@cancelspace%
		\def\solution@space{0pt}%
	\fi%
	\if@inacolumn%
		\global\let\tmp@solution@space\solution@space%
		\endminipage%
		\vspace*{\tmp@solution@space}%
		\global\let\tmp@solution@space\undefined%	
		\hfill%
	\else%
		\vspace*{\solution@space}%
	\fi%
}
\AfterEndEnvironment{prob}{\global\@firstprobfalse\ignorespaces}














\fancypagestyle{firstpage}{%
	\fancyhead{}
	\renewcommand{\headrule}{}
}

\newcommand{\squircle}{\settoheight{\dimen255}{I}\resizebox{\dimen255}{!}{\tikz{\draw[join=round,very thick] (0, 0) rectangle (.4, .4) (.2,.2) circle (.1);}}}
\renewcommand{\qedsymbol}{\squircle}

\pagestyle{fancy}
\fancyhf{}% clear default for head and foot
\fancyfoot[R]{Page \thepage\ of \pageref{LastPage}}
\fancyfoot[L]{{\spoilerfont\spoilertext}}
\fancyhead[L]{\make@sheet@number\@shorttitle}
\if@showname
	\fancyhead[RO]{\nametext~\blank[\answerkeyname]{\name@line@width}}
\fi
%\renewcommand\headrule{\vskip-.7\baselineskip\hrulefill\quad\raisebox{-.5ex}{\decofourleft}~\raisebox{-0.7975 ex}{\squircle}~\raisebox{-.5ex}{\decofourright}\quad\hrulefill}
\renewcommand\headrule{\vskip-.7\baselineskip\hrulefill\quad\raisebox{-.5\height}{\squircle}\quad\hrulefill}

\def\@title{}
\def\@shorttitle{}
\renewcommand{\title}[2][\@nil]{
	\def\@shorttitle{#1}
	\ifx\@shorttitle\@nnil
		\def\@shorttitle{#2}
	\fi
	\def\@title{#2}
}

\def\@block{}
\newcommand{\block}[1]{\def\@block{#1}}

\def\@schoolyear{YYYY-YY}
\newcommand{\schoolyear}[1]{\def\@schoolyear{#1}}

\def\@course{}
\newcommand{\course}[1]{\def\@course{#1}}

\def\@instructor{}
\newcommand{\instructor}[1]{\def\@instructor{#1}}

\def\@unit{}
\newcommand{\unit}[1]{\def\@unit{#1}}

\def\@unitnumber{}
\newcommand{\unitnumber}[1]{\def\@unitnumber{#1}}

\def\@sheetnumber{}
\newcommand{\sheetnumber}[1]{\def\@sheetnumber{#1}}

\let\author\undefined
\let\date\undefined % TODO: you should be able to specify the date!

%\newcommand{\blank}[1]{\rule[-2pt]{#1}{.4pt}}
\newcommand{\blank}{\@ifstar\blank@starred\blank@unstarred}
\newcommand{\blank@starred}[2][]{\underline{\makebox[#2][c]{\ifshowsolutions{#1}\fi}}}
\newcommand{\blank@unstarred}[2][]{\blank@starred[\smash{#1}]{#2}}

\let\oldS\S
\def\S{{\fontfamily{cmr}\selectfont\oldS}} % I really don't like the bold section symbol that Latin Modern uses with T1 encoding... although their normal weight version is pretty decent.  The Computer Modern with T1 is my favorite combo, I think.

\newcommand{\make@sheet@number}{%
	\ifx\@sheetnumber\empty\else%
		{\S}%
		\ifx\@unitnumber\empty\else%
			\@unitnumber.%
		\fi%
		\@sheetnumber\ %
	\fi%
}

\newcommand{\nametext}{Name:}
\newlength{\name@line@width}
\setlength{\name@line@width}{1.75in}

\newcommand{\headerZG}{%
	\newlength{\name@width}%
	\if@showname%
		\settowidth{\name@width}{\nametext~}%
		\addtolength{\name@width}{\dimexpr \name@line@width+1em}%
	\else%
		\setlength{\name@width}{0pt}%
	\fi%
	\begin{minipage}[t]{\dimexpr \linewidth-\name@width}%
		{\large\bfseries\boldmath%
		\strut\make@sheet@number\@title\\}%
		{\large%\Fontauri%
			\@course%
			\ifx\@unit\empty\else%
				: \@unit%
			\fi%
		}%
	\end{minipage}%
	\begin{minipage}[t]{\name@width}%
		\raggedleft
		\nametext~\begin{minipage}[t]{\name@line@width}
			\blank[\textbf{\answerkeyname}]{\name@line@width}\\%
			\centerline{\@schoolyear \quad \squircle \quad Block \@block}%
		\end{minipage}
		%Date:~\blank{\name@line@width}%
	\end{minipage}\par%
	\bigskip%
	\vspace{-\parskip}%
}
\newcommand{\headerZGpic}[1]{%
	\newsavebox{\headerZG@pic}%
	\savebox{\headerZG@pic}{\raisebox{\depth}{#1}}%
	\newlength{\name@width}%
	\if@showname%
		\settowidth{\name@width}{\nametext~}%
		\addtolength{\name@width}{\dimexpr \name@line@width+1em}%
	\else%
		\setlength{\name@width}{0pt}%
	\fi%
	\noindent%
	\usebox\headerZG@pic%
	\hfill%
	\begin{minipage}[b][\ht\headerZG@pic][c]{\dimexpr \linewidth-\wd\headerZG@pic-1em-\name@width}%
		\centering%
		{\large\bfseries\boldmath%
		\strut\make@sheet@number\@title\\}%
		{\large%\Fontauri%
			\@course%
			\ifx\@unit\empty\else%
				: \@unit%
			\fi%
		}%
	\end{minipage}%
	\if@showname%
		\begin{minipage}[b][\ht\headerZG@pic][t]{\name@width}%
			\raggedleft%
			\nametext~\begin{minipage}[t]{\name@line@width}%
			\blank[\textbf{\answerkeyname}]{\name@line@width}\\[-4pt]%
			\centering \@schoolyear \quad \squircle \quad Block \@block%
			\end{minipage}%
		\end{minipage}%
	\fi%
	\par%
	\bigskip%
	\vspace{-\parskip}%
}
\newcommand{\firstpageheader}{\headerZG}

\RequirePackage{afterpage}
\renewcommand{\maketitle}{%
	%\newgeometry{margin=.75in, footskip=\baselineskip}% :/ I don't like that this makes it harder to change the geometry from the handout itself...
	%\afterpage{\aftergroup\restoregeometry}%
	\thispagestyle{firstpage}%
	%\null%
	%\vspace{\dimexpr -\baselineskip-\headheight-\headsep-\parskip}%
	\noindent%
	\firstpageheader%
	\let\maketitle\undefined%
	% FIX ME: \noindent for first line of text after heading?
}
\if@showtitle
	\AtBeginDocument{\maketitle}
\fi

\newcommand{\spoilerfont}{\itshape}
\newcommand{\spoilertext}{}
\newcommand{\spoilerbreak}[1][Spoilers ahead! Proceed with caution\ldots]{\renewcommand{\spoilertext}{#1}\newpage\renewcommand{\spoilertext}{}}

\RequirePackage[OT1,T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage{microtype}

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
