\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{handout}[2019/05/20 A document class for Proof School handouts]
\newcommand{\solutionname}{Solutions}
\newcommand{\first@page@name@block}{\hfill%
	\begin{minipage}[t]{\name@width}%
		\raggedleft
		Name:~\begin{minipage}[t]{\name@line@width}
			\blank[\textbf{\solutionname}]{\name@line@width}\\%
			%\@schoolyear \hfill \squircle \hfill Block \@block%
			\centerline{\@schoolyear \quad \squircle \quad Block \@block}%
		\end{minipage}
		%Date:~\blank{\name@line@width}%
	\end{minipage}}

\newif\if@showname
\@shownametrue
\DeclareOption{noname}{\@shownamefalse\renewcommand{\first@page@name@block}{}}

\newif\ifshowsolutions
\showsolutionsfalse
\DeclareOption{solutions}{\showsolutionstrue}
\DeclareOption{nosolutions}{\showsolutionsfalse}

\newif\ifcancelspace
\cancelspacefalse
\DeclareOption{nospaces}{\cancelspacetrue}
\DeclareOption{spaces}{\cancelspacefalse}

\newif\if@showtitle
\@showtitletrue
\DeclareOption{title}{\@showtitletrue}
\DeclareOption{notitle}{\@showtitlefalse}

\newif\ifload@parskip
\load@parskipfalse
\DeclareOption{parskip}{\load@parskiptrue}
\DeclareOption{parindent}{\load@parskipfalse}

%\newcommand{\section@symbol}{\S}
%\DeclareOption{noS}{\renewcommand{\section@symbol}{}}
%\DeclareOption{quiz}{\renewcommand{\section@symbol}{Quiz}}


\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}

%\ExecuteOptions{12pt, twoside, letterpaper}
\ProcessOptions\relax
\LoadClass{article}

\RequirePackage{setspace}
\onehalfspacing

\RequirePackage[margin=.75in, includehead, headsep=.5\baselineskip,headheight=14.5 pt, footskip=\baselineskip]{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{mathtools,amsthm,amssymb}
\ifload@parskip
	%\RequirePackage[parfill]{parskip}
	\RequirePackage{parskip}
	\def\thm@space@setup{%
		\thm@preskip=\parskip \thm@postskip=0pt%
	}
\fi



\usepackage{tikz, tcolorbox}
\usetikzlibrary{calc}
\tcbuselibrary{skins}

\newlength{\outsideparskip}
\setlength{\outsideparskip}{\parskip}

\newcommand{\PStcbpath@hook}{%
	\path[draw, line cap=round, semithick, rounded corners=1mm]%
		(frame.south east) --% %([xshift=1.5mm, yshift=3mm]frame.south east) |-%
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
		(frame.south east) --% %([xshift=1.5mm, yshift=3mm]frame.south east) |-%
		([xshift=-1.5mm] frame.south west) |-%
		(title.south east);%
	\path[draw, line cap=round, semithick]%
		(title.south east)%
			arc (-90:-20:1.1mm)%
			arc (160:-120:.55mm);%
}
\newcommand{\PStcbpath@doublein}{%
	\path[draw, line cap=round, semithick, rounded corners=1mm]%
		(frame.south east) --% %([xshift=1.5mm, yshift=3mm]frame.south east) |-%
		([xshift=-1.5mm] frame.south west) |-%
		([xshift = 1mm]title.south east);%
	\path[draw, line cap=round, semithick]%
		([xshift = 1mm]title.south east)%
		arc (90:-90:.5mm) --%
		([yshift=-1mm, xshift=-0.5mm]title.south west);%
}
\newcommand{\PStcbpath@doubleout}{%
	\path[draw, line cap=round, thick, rounded corners=1mm]%
		(frame.south east) --% %([xshift=1.5mm, yshift=3mm]frame.south east) |-%
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




%\usepackage{fourier-orns}
%\newtheorem{theorem}{Theorem}
%\newtheorem*{theorem*}{Theorem}
%\newtheorem{lemma}[theorem]{Lemma}
%\newtheorem*{lemma*}{Lemma}
%\newtheorem{corollary}[theorem]{Corollary}
%\newtheorem*{corollary*}{Corollary}
%\newtheorem{claim}[theorem]{Claim}
%\newtheorem*{claim*}{Claim}
%\newtheorem{proposition}[theorem]{Proposition}
%\newtheorem*{proposition*}{Proposition}
%\theoremstyle{definition}
%\newtheorem{definition}[theorem]{Definition}
%\newtheorem*{definition*}{Definition}
%\newtheorem{example}[theorem]{Example}
%\newtheorem*{example*}{Example}

%\RequirePackage{enumerate}
\RequirePackage[shortlabels]{enumitem}
\setlist[enumerate,1]{label={\arabic*.}}
\setlist[enumerate,2]{label={\alph*)}}
\setlist[enumerate,3]{label={\roman*)}}
\setlist[enumerate]{align=left, leftmargin=*, labelindent=0em, labelwidth=0em, labelsep=.5em}
\SetEnumitemKey{bonus}{format={\makebox[0pt][r]{$\star$\,}}}
\SetEnumitemKey{surprising}{format={\makebox[0pt][r]{\tikz[baseline=(txt.base)]{\node[inner xsep=0pt, xshift=.6pt] (txt1){\phantom{I}};\clip (txt1.south west) rectangle (txt1.north east);\node[xslant=-.23](txt){\textit{\textinterrobang}};}\,}}}

\setlist[enumerate]{topsep=-\parskip, noitemsep}
\setlist[itemize]{topsep=-\parskip, noitemsep}








% TODO: When you finally update the problem environment, transfer this line into the solution minipages:
% \setlength{\parskip}{\outsideparskip}

\newlength{\mysep}
\setlength{\mysep}{0.5cm}

\newlist{probs}{enumerate}{3}
\setlist[probs,1]{label={\arabic*.}, ref={\arabic*}}
\setlist[probs,2]{label={\alph*)}, ref={\alph*}}
\setlist[probs,3]{label={\roman*)}, ref={\alph{probsii}\;\!\roman*)}}
%\setlist[probs]{align=left, leftmargin=*, labelindent=0em, labelwidth=0em, itemindent=0em}
\setlist[probs]{align=left, leftmargin=!, labelindent=0em, labelsep=.5em, labelwidth=1em}

%\let\oldprobs\probs
%\renewcommand{\probs}{hey!\oldprobs\relax\item}

\newif\if@insolution
\@insolutionfalse
\newif\iffirstprob
\firstprobtrue
\newsavebox{\solutionbox}

\newcommand{\ifsoln}[2][]{\ifshowsolutions{#2}\else{#1}\fi}

\newcommand{\allow@solution}{%
	\def\solution%
	{%
		\@insolutiontrue%
		\begingroup\lrbox{\solutionbox}%
		\ifcancelspace%
			\minipage[t]{\linewidth}%
		\else%
			\minipage[t][0pt]{\linewidth}%
		\fi%
		\setlength{\parskip}{\outsideparskip}%
		\textbf{SOLUTION:}\ %
	}%
}

\newcommand{\set@solution@space}[1]{%
	\ifcancelspace%
		\def\solution@space{0pt}%
	\else%
		\pgfmathparse{#1}%
		\ifpgfmathunitsdeclared%
			\def\solution@space{#1}%
		\else%
			\def\solution@space{\stretch{#1}}%
		\fi%
	\fi%
}

\newenvironment{@prob}[1]{%
	\allow@solution%
	\iffirstprob%
		\probs[series=pro, #1]%
	\else%
		\probs[resume=pro, #1]%
	\fi%
	\firstprobtrue%
	\item%
}%
{%
	\if@insolution%
		\endminipage%
		\endlrbox\endgroup%
		\ifshowsolutions%
			\par\usebox{\solutionbox}%
			\vspace*{\dimexpr -\baselineskip-\parskip}%
		\fi%
	\fi%
	\endprobs%
	\global\firstprobfalse%
}

\newenvironment{prob}[1][0pt]%
{\set@solution@space{#1}\@prob{}}%
{\end@prob\vspace*{\solution@space}}

\newenvironment{prob*}[1][0pt]%
{\set@solution@space{#1}\@prob{format={\makebox[0pt][r]{$\star$\,}}}}%
{\end@prob\vspace*{\solution@space}}

\newenvironment{hprob}[2][0pt]%
{%
	\set@solution@space{#1}%
	\pgfmathparse{1/(#2)*\linewidth-((#2)-1)/(#2)*\mysep}%
	\begin{minipage}[t]{\pgfmathresult pt}%
	\@prob{}%
}%
{%
	\end@prob%
	\end{minipage}%
	\hspace{\mysep}%
	\vspace{\solution@space}%
	\ignorespaces%
}

\newenvironment{hprob*}[2][0pt]%
{%
	\set@solution@space{#1}%
	\pgfmathparse{1/(#2)*\linewidth-((#2)-1)/(#2)*\mysep}%
	\begin{minipage}[t]{\pgfmathresult pt}%
	\@prob{format={\makebox[0pt][r]{$\star$\,}}}%
}%
{%
	\end@prob%
	\end{minipage}%
	\hspace{\mysep}%
	\vspace{\solution@space}%
	\ignorespaces%
}













\RequirePackage{url}

%\usepackage{aurical}
%\usepackage[T1]{fontenc}

\fancypagestyle{firstpage}{%
	\fancyhead{}
	\renewcommand{\headrule}{}
}

\newcommand{\squircle}{\resizebox{1.595ex}{!}{\tikz{\draw[join=round,very thick] (0, 0) rectangle (.4, .4) (.2,.2) circle (.1);}}}
\renewcommand{\qedsymbol}{\squircle}

\pagestyle{fancy}
\fancyhf{}% clear default for head and foot
\fancyfoot[C]{Page \thepage\ of \pageref{LastPage}}
\fancyfoot[R]{{\spoilerfont\spoilertext}}
\if@showname
	\fancyhead[RO]{Name:~\blank[\solutionname]{\name@line@width}}
\fi
%\renewcommand\headrule{\vskip-.7\baselineskip\hrulefill\quad\raisebox{-.5ex}{\decofourleft}~\raisebox{-0.7975 ex}{\squircle}~\raisebox{-.5ex}{\decofourright}\quad\hrulefill}
\renewcommand\headrule{\vskip-.7\baselineskip\hrulefill\quad\raisebox{-0.7975 ex}{\squircle}\quad\hrulefill}
\fancyhead[L]{\make@sheet@title}

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
\let\date\undefined

%\newcommand{\blank}[1]{\rule[-2pt]{#1}{.4pt}}
\newcommand{\blank}{\@ifstar\blank@starred\blank@unstarred}
\newcommand{\blank@starred}[2][]{\underline{\makebox[#2][c]{\ifshowsolutions{#1}\fi}}}
\newcommand{\blank@unstarred}[2][]{\blank@starred[\smash{#1}]{#2}}

\let\oldS\S
\def\S{{\fontfamily{cmr}\selectfont\oldS}} % I really don't like the bold section symbol that Latin Modern uses with T1 encoding... although their normal weight version is pretty decent.  The Computer Modern with T1 is my favorite combo, I think.

\newcommand{\make@sheet@title}{%
	\ifx\@sheetnumber\empty\else%
		{\S}%
		\ifx\@unitnumber\empty\else%
			\@unitnumber.%
		\fi%
		\@sheetnumber\ %
	\fi%
	\@title%
}

\newlength{\name@line@width}
\setlength{\name@line@width}{1.75in}

\renewcommand{\maketitle}{%
	\thispagestyle{firstpage}%
	\newlength{\name@width}%
	\settowidth{\name@width}{Name:~}%
	\addtolength{\name@width}{\name@line@width}%
	\newlength{\title@width}%
	\setlength{\title@width}{\textwidth}%
	\addtolength{\title@width}{-\name@width}%
	\addtolength{\title@width}{-1em}%
	\null
	
	\vspace{-\baselineskip}%
	\vspace{-\headheight}%
	\vspace{-\headsep}%
	\vspace{-\parskip}%
	\noindent%
	\begin{minipage}[t]{\title@width}%
		{\large\bfseries\boldmath%
		\strut\make@sheet@title\\}%
		{\large%\Fontauri%
			\@course%
			\ifx\@unit\empty\else%
				: \@unit%
			\fi%
		}%
	\end{minipage}%
	\first@page@name@block\\\par%
	\bigskip%
	\vspace{-\parskip}%
	\let\maketitle\undefined%
	% FIX ME: \noindent for first line of text after heading?
}
\if@showtitle
	\AtBeginDocument{\maketitle}
\fi

\newcommand{\spoilerfont}{\itshape}
\newcommand{\spoilertext}{}
\newcommand{\spoilerbreak}[1][Spoilers ahead! Proceed with caution\ldots]{\renewcommand{\spoilertext}{#1}\newpage\renewcommand{\spoilertext}{}}
%\newcommand{\spoilerbreak}[1][Spoilers ahead! Proceed with caution\ldots]{\renewcommand{\spoilertext}{\parbox[b]{\dimexpr .5\textwidth-1.5cm}{\raggedleft #1}}\newpage\renewcommand{\spoilertext}{}}

\usepackage{miama}
%\usepackage{aurical}
\usepackage[OT1,T1]{fontenc}
\usepackage{lmodern}
\usepackage{microtype}
\newcommand{\students}[1]{{\fmmfamily\huge #1}}


\newcommand{\bonus}{{\Large{$\star$}}}

% I just think there is too much space around displayed equations?
\apptocmd\normalsize{%
	\abovedisplayskip=7pt plus 3pt minus 4pt%
	\abovedisplayshortskip=0pt plus 3pt%
	\belowdisplayskip=7pt plus 3pt minus 4pt%
	\belowdisplayshortskip=7pt plus 3pt minus 4pt%
}{}{}
