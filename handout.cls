\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{handout}[2018/08/27 A document class for Proof School handouts]

\newcommand{\first@page@name@block}{\hfill%
	\begin{minipage}[t]{\name@width}%
		\raggedleft
		Name:~\blank{\name@line@width}\\%
		%\@schoolyear, Block \@block%
		Date:~\blank{\name@line@width}%
	\end{minipage}}

\DeclareOption{noname}{\renewcommand{\first@page@name@block}{}}
\newcommand{\load@optional@packages}{}
\DeclareOption{parskip}{\renewcommand{\load@optional@packages}{\RequirePackage[parfill]{parskip}}}
%\newcommand{\section@symbol}{\S}
%\DeclareOption{noS}{\renewcommand{\section@symbol}{}}
%\DeclareOption{quiz}{\renewcommand{\section@symbol}{Quiz}}


\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}

%\ExecuteOptions{12pt, twoside, letterpaper}
\ProcessOptions\relax
\LoadClass{article}

\load@optional@packages
\RequirePackage{setspace}
\onehalfspacing

\RequirePackage[margin=.75in, includehead, headsep=.5\baselineskip, footskip=\baselineskip]{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{mathtools,amsthm,amssymb}
\RequirePackage{url}
%\usepackage{fourier-orns}
\newtheorem{theorem}{Theorem}
\newtheorem*{theorem*}{Theorem}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem*{lemma*}{Lemma}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem*{corollary*}{Corollary}
\newtheorem{claim}[theorem]{Claim}
\newtheorem*{claim*}{Claim}
\theoremstyle{definition}
\newtheorem{definition}[theorem]{Definition}
\newtheorem*{definition*}{Definition}
\RequirePackage{enumerate}

\RequirePackage{tikz}

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
\fancyhead[RO]{Name:~\blank{\name@line@width}}
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

\newcommand{\blank}[1]{\rule[-2pt]{#1}{.4pt}}

\newcommand{\make@sheet@title}{%
	\ifx\@sheetnumber\empty\else%
		\S%
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
		\make@sheet@title\\}%
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

\AtBeginDocument{\maketitle}

\newcommand{\spoilerfont}{\itshape}
\newcommand{\spoilertext}{}
%\fancypagestyle{spoilers}{\fancyfoot[R]{\spoilerfont\spoilertext}}
%\fancypagestyle{spoilers}{\fancyfoot[R]{\spoilerfont\spoilertext}}
\newcommand{\spoilerbreak}[1][Spoilers ahead! Proceed with caution\ldots]{\renewcommand{\spoilertext}{#1}\newpage\renewcommand{\spoilertext}{}}
%\newcommand{\spoilerbreak}[1][Spoilers ahead! Proceed with caution\ldots]{\renewcommand{\spoilertext}{\parbox[b]{\dimexpr .5\textwidth-1.5cm}{\raggedleft #1}}\newpage\renewcommand{\spoilertext}{}}

\usepackage{miama}
%\usepackage{aurical}
\usepackage[T1]{fontenc}
\newcommand{\students}[1]{{\fmmfamily\huge #1}}


\newcommand{\bonus}{{\Large{$\star$}}}
