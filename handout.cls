\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{handout}[2020/02/06 A document class for Proof School handouts]

\newif\ifshowname
\shownametrue
\newif\ifrunningname
\runningnamefalse
\DeclareOption{name}{\shownametrue\runningnamefalse}
\DeclareOption{runningname}{\shownametrue\runningnametrue}
\DeclareOption{noname}{\shownamefalse\runningnamefalse}

\newcommand{\AnswerKeyName}{Answer Key}
\newif\ifshowsolutions
\newif\if@boxsolutions
\showsolutionsfalse
\@boxsolutionsfalse
\DeclareOption{solutions}{\showsolutionstrue\@boxsolutionsfalse}
\DeclareOption{boxedsolutions}{\showsolutionstrue\@boxsolutionstrue}
\DeclareOption{nosolutions}{\showsolutionsfalse}

\newif\if@cancelspace
\@cancelspacefalse
\DeclareOption{nospaces}{\@cancelspacetrue}
\DeclareOption{spaces}{\@cancelspacefalse}

\newif\if@showtitle
\@showtitletrue
\DeclareOption{title}{\@showtitletrue}
\DeclareOption{notitle}{\@showtitlefalse}

\newif\if@showpagenums
\@showpagenumstrue
\DeclareOption{pagenums}{\@showpagenumstrue}
\DeclareOption{nopagenums}{\@showpagenumsfalse}

\newif\if@boxedtheorems
\@boxedtheoremstrue
\DeclareOption{boxedtheorems}{\@boxedtheoremstrue}
\DeclareOption{noboxedtheorems}{\@boxedtheoremsfalse}
\DeclareOption{boringtheorems}{\@boxedtheoremsfalse}

\newif\if@sharedtheoremnums
\@sharedtheoremnumstrue
\DeclareOption{sharednumbers}{\@sharedtheoremnumstrue}
\DeclareOption{differentnumbers}{\@sharedtheoremnumsfalse}

\newif\if@empty
\@emptyfalse
\DeclareOption{empty}{\@emptytrue}

\newif\if@numbernextprob
\@numbernextprobtrue
\newif\if@checkboxes
\@checkboxesfalse
\DeclareOption{probnumbers}{}
\DeclareOption{checkboxes}{\@checkboxestrue}
\DeclareOption{noprobnumbers}{\@numbernextprobfalse}

\newif\if@loadparskip
\@loadparskipfalse
\DeclareOption{parskip}{\@loadparskiptrue}
\DeclareOption{parindent}{\@loadparskipfalse}

\newif\if@xivpt
\@xivptfalse
\DeclareOption{14pt}{\@xivpttrue}

\DeclareOption*{%
	\PassOptionsToClass{\CurrentOption}{article}%
}

%\ExecuteOptions{12pt, twoside, letterpaper}
\ProcessOptions\relax
\LoadClass{article}

\if@xivpt
	\RequirePackage[14pt]{extsizes}
\fi

\RequirePackage{xparse}

\RequirePackage{tikz, tcolorbox}
\usetikzlibrary{calc, shapes.callouts, shapes.geometric}
\tcbuselibrary{skins}


\RequirePackage{letltxmacro, etoolbox, xpatch, textcomp, url}



\RequirePackage{setspace}
\onehalfspacing

\RequirePackage[margin=.75in, headsep=.5\baselineskip, headheight=14.5 pt, footskip=\baselineskip]{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{mathtools,amsthm,amssymb}
\if@loadparskip
	%\RequirePackage[parfill]{parskip}
	\RequirePackage{parskip}
\fi

\RequirePackage[OT1,T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage{microtype}

\newlength{\outsideparskip} % This length is set to parskip at \begin{document}, to reflect any changes that are made later in the preamble
\newcommand{\restoreparskip}{\setlength{\parskip}{\outsideparskip}}













%%%%%%%%%% Theorems %%%%%%%%%%
\if@boxedtheorems
	\newcommand{\PStcbpath@hook}{%
		\path[draw, line cap=round, rounded corners=1mm]%
			([xshift=1.5in] frame.south west) --%(frame.south east) --%
			([xshift=-1.5mm] frame.south west) |-%
			(title.south east);%
		\path[draw, line cap=round]%
			(title.south east)%
				arc (-90:-40:.85mm)%
				arc (140:-130:.6mm);%
			%([xshift=1.5mm, yshift=3mm]frame.south east)
			%	arc (180:130:.85mm)
			%	arc (-50:220:.6mm);}
	}
	\newcommand{\PStcbpath@toploop}{%
		\path[draw, line cap=round, rounded corners=1mm]%
			([xshift=1.5in] frame.south west) --%(frame.south east) --%
			([xshift=-1.5mm] frame.south west) |-%
			(title.south east);%
		\path[draw, line cap=round]%
			(title.south east)%
				arc (-90:-20:1.1mm)%
				arc (160:-120:.55mm);%
	}
	\newcommand{\PStcbpath@doublein}{%
		\path[draw, line cap=round, rounded corners=1mm]%
			([xshift=1.5in] frame.south west) --%(frame.south east) --%
			([xshift=-1.5mm] frame.south west) |-%
			([xshift = 1mm]title.south east);%
		\path[draw, line cap=round]%
			([xshift = 1mm]title.south east)%
			arc (90:-90:.5mm) --%
			([yshift=-1mm, xshift=-0.5mm]title.south west);%
	}
	\newcommand{\PStcbpath@doubleout}{%
		\path[draw, line cap=round, rounded corners=1mm]%
			([xshift=1.5in] frame.south west) --%(frame.south east) --%
			([xshift=-1.5mm] frame.south west) |-%
			([yshift=-1mm]title.south east);%
		\path[draw, line cap=round]%
			([yshift=-1mm] title.south east)%
			arc (-90:90:.5mm) --%
			([xshift=-1.5mm]title.south west);%
	}
	
	
	
	\newcommand{\newPStheorem}[3]{\newPStcbPair{#1}{#2}{}{\ (}{)}{\PStcbpath@hook}{fontupper=\itshape}{#3}}
	\newcommand{\newPSdefinition}[3]{\newPStcbPair{#1}{#2}{}{\ }{}{\PStcbpath@hook}{}{#3}}
	\newcommand{\newPSexample}[3]{\newPStcbPair{#1}{#2}{}{\textbf{:}\ }{}{\PStcbpath@doublein}{top=2.5mm}{#3}}
	
	% #1: command
	% #2: Category (as it is to be displayed)
	% #3: end of title (always typeset)
	% #4: before name (only typeset if a name is given for the the box)
	% #5: after name (only typeset if a name is given for the the box)
	% #6: frame path
	% #7: additional code
	% #8: counter
	\newcommand{\newPStcbPair}[8]{
		\newPStcb{#1*}{#2}{#3}{#4}{#5}{#6}{before upper={\restoreparskip},#7}{}%
		\newPStcb{#1}{#2}{#3}{#4}{#5}{#6}{before upper={\restoreparskip\addtocounter{#8}{-1}\refstepcounter{#8}},#7}{\stepcounter{#8}\ \csname the#8\endcsname}%
	}
	% #1: command
	% #2: Category (as it is to be displayed)
	% #3: end of title (always typeset)
	% #4: before name (only typeset if a name is given for the the box)
	% #5: after name (only typeset if a name is given for the the box)
	% #6: frame path
	% #7: additional code
	% #8: number (in the starred versions, nothing, in the unstarred version, it should increment and print the number)
	\newcommand{\newPStcb}[8]{
		\newtcolorbox{#1}[1][\@nil]{
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
	\newcounter{psh@thmcount}\setcounter{psh@thmcount}{0}
	\newPStheorem{theorem}{Theorem}{psh@thmcount}
	
	\if@sharedtheoremnums
		\newPStheorem{lemma}{Lemma}{psh@thmcount}
		\newPStheorem{corollary}{Corollary}{psh@thmcount}
		\newPStheorem{claim}{Claim}{psh@thmcount}
		\newPStheorem{conjecture}{Conjecture}{psh@thmcount}
		\newPStheorem{proposition}{Proposition}{psh@thmcount}
		\newPSdefinition{definition}{Definition}{psh@thmcount}
		\newPSexample{example}{Example}{psh@thmcount}
		\newPSexample{remark}{Remark}{psh@thmcount}
	\else
		\newcounter{psh@lemcount}\setcounter{psh@lemcount}{0}
		\newPStheorem{lemma}{Lemma}{psh@lemcount}
		
		\newcounter{psh@corcount}\setcounter{psh@corcount}{0}
		\newPStheorem{corollary}{Corollary}{psh@corcount}
		
		\newcounter{psh@claimcount}\setcounter{psh@claimcount}{0}
		\newPStheorem{claim}{Claim}{psh@claimcount}
		
		\newcounter{psh@conjcount}\setcounter{psh@conjcount}{0}
		\newPStheorem{conjecture}{Conjecture}{psh@conjcount}
		
		\newcounter{psh@propcount}\setcounter{psh@propcount}{0}
		\newPStheorem{proposition}{Proposition}{psh@propcount}
		
		\newcounter{psh@defcount}\setcounter{psh@defcount}{0}
		\newPSdefinition{definition}{Definition}{psh@defcount}
		
		\newcounter{psh@examplecount}\setcounter{psh@examplecount}{0}
		\newPSexample{example}{Example}{psh@examplecount}
		
		\newcounter{psh@remcount}\setcounter{psh@remcount}{0}
		\newPSexample{remark}{Remark}{psh@remcount}
	\fi
\else
	\if@sharedtheoremnums
		\newtheorem{theorem}{Theorem}                  \newtheorem*{theorem*}{Theorem}
		\newtheorem{lemma}[theorem]{Lemma}             \newtheorem*{lemma*}{Lemma}
		\newtheorem{corollary}[theorem]{Corollary}     \newtheorem*{corollary*}{Corollary}
		\newtheorem{claim}[theorem]{Claim}             \newtheorem*{claim*}{Claim}
		\newtheorem{conjecture}[theorem]{Conjecture}   \newtheorem*{conjecture*}{Conjecture}
		\newtheorem{proposition}[theorem]{Proposition} \newtheorem*{proposition*}{Proposition}
		\theoremstyle{definition}
		\newtheorem{definition}[theorem]{Definition}   \newtheorem*{definition*}{Definition}
		\newtheorem{example}[theorem]{Example}         \newtheorem*{example*}{Example}
		\newtheorem{remark}[theorem]{Remark}         \newtheorem*{remark*}{Remark}
	\else
		\newtheorem{theorem}{Theorem}         \newtheorem*{theorem*}{Theorem}
		\newtheorem{lemma}{Lemma}             \newtheorem*{lemma*}{Lemma}
		\newtheorem{corollary}{Corollary}     \newtheorem*{corollary*}{Corollary}
		\newtheorem{claim}{Claim}             \newtheorem*{claim*}{Claim}
		\newtheorem{conjecture}{Conjecture}   \newtheorem*{conjecture*}{Conjecture}
		\newtheorem{proposition}{Proposition} \newtheorem*{proposition*}{Proposition}
		\theoremstyle{definition}
		\newtheorem{definition}{Definition}   \newtheorem*{definition*}{Definition}
		\newtheorem{example}{Example}         \newtheorem*{example*}{Example}
		\newtheorem{remark}{Remark}           \newtheorem*{remark*}{Remark}
	\fi
\fi
















%%%%%%%%%% Problem Environment %%%%%%%%%%

\RequirePackage[shortlabels]{enumitem}

\newcommand{\checkbox}{\tikz[baseline={(0,0)}]{\draw[line join=round](-1mm,-1mm) rectangle (4mm,4mm);}}

\setlist[enumerate,1]{label={\arabic*.}}
\setlist[enumerate,2]{label={\alph*)}}
\setlist[enumerate,3]{label={\roman*)}}
\setlist[enumerate]{align=left, leftmargin=*, labelindent=0em, labelwidth=0em, labelsep=.5em}
\setlist[enumerate]{topsep=-\parskip, noitemsep}
\setlist[itemize]{topsep=-\parskip, noitemsep}

\newlist{prob}{enumerate}{3}
\setlist[prob,1]{label={\arabic*.}, ref={\arabic*}}
\setlist[prob,2]{label={\alph*)}, ref={\alph*}}
\setlist[prob,3]{label={\roman*)}, ref={\roman*}}
%\setlist[prob]{align=left, leftmargin=*, labelindent=0em, labelwidth=0em, itemindent=0em}
\setlist[prob]{align=left, leftmargin=!, labelindent=0em, labelsep=.5em, labelwidth=1em}
\if@checkboxes
	\setlist[prob,1]{labelwidth=1.25em, label={{\noexpand\checkbox}}, ref={}}
\fi
\newcommand{\placeprobpic}[1]{\makebox[0pt][r]{#1\,}}
\newcommand{\DeclareProbPic}[2]{\SetEnumitemKey{#1}{format={\placeprobpic{#2}}}}
%\newcommand{\placeprobpic}[1]{\makebox[0pt][r]{#1\hspace{0.5pt}}}
\DeclareProbPic{check}{\checkbox\,}
\DeclareProbPic{bonus}{$\star$}
\DeclareProbPic{discuss}{%
	\tikz{
		\node[draw, ellipse callout, callout pointer arc=30, callout relative pointer={(0.3ex, -0.5ex)}, minimum width=1.25ex, minimum height=.8ex, inner sep=0pt, outer sep=2pt] at (.3ex, -.4ex) {};
		\node[draw, fill=white, ellipse callout, callout pointer arc=30, callout relative pointer={(-0.3ex, -0.6ex)}, minimum width=1.25ex, minimum height=.8ex, inner sep=0pt, outer sep=2pt] {};
	}}
\DeclareProbPic{stop}{\tikz[baseline=(sign.south)]{\node[draw, regular polygon, regular polygon sides=8, minimum width=.8em, inner sep=0pt] (sign){\makebox[0pt][c]{\resizebox{.65em}{.25em}{\textsf{STOP}}}};}}
\DeclareProbPic{exciting}{\textit{\makebox[2pt][l]{\raisebox{0.5pt}{\small!}}!}}
\DeclareProbPic{surprising}{\textit{\textinterrobang}}
\DeclareProbPic{play}{\raisebox{-2pt}[0pt][0pt]{%
	\tikz[scale=.18]{
		\draw (0,0) circle (1);
		\draw[fill=gray, rotate=25] (0,1) arc (90:-90:0.75 and 1) arc (-90:90:0.15 and 1);
		\draw[fill=lightgray, rotate=25] (0,1) arc (90:270:0.6 and 1) arc (270:90:1);
	}}}
\DeclareProbPic{calculator}{\raisebox{-1.5pt}[0pt][0pt]{\resizebox{.9em}{!}{%
	\tikz{
		\node[draw,rounded corners=3pt, inner sep=1pt]{$\kern-.2em\begin{smallmatrix}+-\\\times\div\end{smallmatrix}\kern-.2em$};
	}}}}
\DeclareProbPic{attention}{%
	\tikz[thin, line cap=round, scale=1.8]{
		\draw
			(-.08, .05)
				.. controls +(-15:.02) and +(190:.03).. (-.01, .075)
				.. controls +(10:.02) and +(90:.01).. (.045, .025)
				.. controls +(-90:.01) and +(-45:.055).. (-.016, .038)
			(.009, .07)
				.. controls +(0:.05) and +(175:.013).. (.1, .07)
				.. controls +(-5:.055) and +(0:.06).. (.1, .033)
				.. controls +(180:.04) and +(4:.015).. (.043, .031)
			(.054, .031)
				.. controls +(-42:.02) and +(20:.065).. (.02, -.015)
				.. controls +(200:.04) and +(-150:.035).. (.005, .02)
			(.06, .004)
				.. controls +(-10:.02) and +(20:.035).. (.05, -.034)
				.. controls +(-160:.025) and +(-110:.025).. (.007, -.02)
			(.07, -.024)
				.. controls +(-30:.01) and +(20:.035).. (.058, -.058)
				.. controls +(-160:.025) and +(-110:.025).. (.02, -.04)
			(.018, -.052)
				.. controls +(183:.075) and +(0:.035).. (-.08, -.029);
	}}


\DeclareProbPic{pencil}{%
	\tikz[scale=.65, rotate=25, very thin, baseline={(0,.2)}]{
		\draw (-.1,1) -- (-.1, .25) -- (0,0) -- (.1, .25) -- (.1,1);
		\fill (0,0) -- (-.03, .075) arc (180:360:.03 and .0075) -- cycle;
		\draw (0,.8) -- (0,.225);
		\draw (0,1) circle (.1 and .025);
		\draw (-.1,.9) arc (180:360:.1 and .025);
		\draw (-.1,.825) arc (180:360:.1 and .025);
		\foreach \ang in {30,45,...,150}
			\draw[ultra thin] (0,.8825)++(-\ang:.1 and .025) -- +(0,-.04);
		\draw (0,.225) .. controls +(0:.02) and +(190:.03) .. (.05,.2) .. controls +(10:.02) and +(220:.015) .. (.1,.25);
		\draw (0,.225) .. controls +(180:.02) and +(-10:.03) .. (-.05,.2) .. controls +(170:.02) and +(-40:.015) .. (-.1,.25);
	}}


\newif\if@showpoints        \@showpointsfalse
\newif\if@usedefaultspace   \@usedefaultspacetrue
\newif\if@probsincolumns    \@probsincolumnsfalse
\newif\if@inacolumn         \@inacolumnfalse
\newif\if@usenaturalheight
\newif\if@insolution        \@insolutionfalse
\newif\if@firstprob         \@firstprobtrue

\def\@numcolumns{1}

\newcommand{\ProbsInColumns}[1]{\ifnum#1=0 \@probsincolumnsfalse\def\@numcolumns{1}\else\@probsincolumnstrue\def\@numcolumns{#1}\fi}
\newcommand{\ProbsNotInColumns}{\ProbsInColumns{0}}
\enitkv@key{}{columns}[3]{\ProbsInColumns{#1}}
\enitkv@key{}{points}{\@showpointstrue\def\@numpoints{#1}}
\enitkv@key{}{space}[1]{\set@solutionspace{#1}\@usedefaultspacefalse}
\SetEnumitemKey{nospace}{space=0pt}
\SetEnumitemKey{no space}{nospace}
\enitkv@key{}{spaces}{\fancysetlength{\@defaultsolutionspace}{#1}}
\SetEnumitemKey{nospaces}{spaces=0pt}
\SetEnumitemKey{no spaces}{nospaces}
\SetEnumitemKey{fixspaces}{spaces={\glueexpr \stretch{1}/\@numcolumns}}
\SetEnumitemKey{fix spaces}{fixspaces}

\newlength{\ProbColSep}     \setlength{\ProbColSep}{0.5cm}
\def\probcolsep{\ProbColSep} % deprecated, only here for compatibility

\NewDocumentCommand{\ifsoln}{O{}m}{\ifshowsolutions#2\else#1\fi}

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
		\begingroup\lrbox{\solutionbox}%
			\if@boxsolutions%
				\varwidth[t]{\dimexpr\linewidth-2\fboxsep-2\fboxrule}%
			\else%
				\minipage[t]{\linewidth}%
			\fi%
			\restoreparskip%
			{\SolutionPrefixFont\SolutionPrefix}%
			\ignorespaces%
	}%
}

\newlength{\@defaultsolutionspace}
\setlength{\@defaultsolutionspace}{\stretch{1}}

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

\newenvironment{prob*}[1][]{\@numbernextprobfalse\prob[#1]}{\endprob}

\renewcommand{\prob}[1][]{%
	\if@probsincolumns%
		\@inacolumntrue%
		\pgfmathparse{(\linewidth-((\@numcolumns)-1)*\ProbColSep)/(\@numcolumns)}%
		\minipage[t]{\pgfmathresult pt}%
		\restoreparskip%
	\fi%
	\@probsincolumnsfalse%
	\@usenaturalheightfalse%
	\def\@solutionspace{0pt}%
	\@showpointsfalse%
	\@usedefaultspacetrue%
	\allow@solution%
	\if@numbernextprob%
		\if@firstprob%
			\old@prob[series=pro, #1]%
		\else%	
			\old@prob[resume=pro, #1]%
		\fi%
	\else%
		\old@prob[leftmargin=!, labelindent=0em, labelsep=0em, labelwidth=0em, label={}, ref={}, #1]%
		\@numbernextprobtrue%
	\fi%
	\@firstprobtrue%
	\item \if@showpoints(\@numpoints\if\@numpoints1\relax\:\!\pointsymbol\else\,\pointssymbol\fi)\fi%
}

\renewcommand{\endprob}{%
	\if@insolution%
		\if@boxsolutions%
			\endvarwidth%
		\else%
			\endminipage%
		\fi%
		\endlrbox\endgroup%
		\par%
		\ifshowsolutions%
			\if@cancelspace%
				\@usenaturalheighttrue%
			\fi%
			\if@usenaturalheight% show solution, natural space
				% I used to have \vspace*{2\lineskip} before the \par, but now I'm not sure why that was needed...
				\if@boxsolutions%
					\fbox{\usebox{\solutionbox}}%
				\else%
					\usebox{\solutionbox}%
				\fi%
				{}\par%
				\@usedefaultspacefalse%
				\def\@solutionspace{0pt}%
			\else% show solutions, fixed space
				\smash{\aligntop{%
				\if@boxsolutions%
					\fbox{\usebox{\solutionbox}}%
				\else%
					\usebox{\solutionbox}%
				\fi}}%
				\par\vspace*{\dimexpr -\baselineskip-\parskip}%
			\fi%
		\fi%
	\else%
		\par%
	\fi%
	\if@usedefaultspace%
		\def\@solutionspace{0pt}%
		\if@firstprob%
			\def\@solutionspace{\@defaultsolutionspace}%
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
\AfterEndEnvironment{prob*}{\global\@firstprobfalse\ignorespaces}











%%%%%%%%%% Headers and Footers %%%%%%%%%%

\fancypagestyle{firstpage}{%
	\fancyhead{}
	\renewcommand{\headrule}{}
}

\pagestyle{fancy}
\fancyhf{}% clear default for head and foot
\fancyfoot[L]{{\SpoilerFont\@spoilertext}}
\fancyhead[L]{\FancyShortTitle}
\if@empty
	\renewcommand{\headrule}{}
\else
	\if@showpagenums
		\fancyfoot[R]{Page \thepage\ of \pageref{LastPage}}
	\fi
	\ifrunningname
		\fancyhead[RO]{\NameSpace}
		\fancyhead[RE]{\CourseShortName}
	\else
		\fancyhead[R]{\CourseShortName}
	\fi
	\renewcommand\headrule{\vskip-.7\baselineskip\hrulefill\quad\raisebox{-.5\height}{\squircle}\quad\hrulefill}
\fi

\newcommand{\TitleFont}{\large\bfseries\boldmath}
\def\Title{}
\def\ShortTitle{}
\RenewDocumentCommand{\title}{O{#2}m}{%
	\def\ShortTitle{#1}%
	\def\Title{#2}%
}

\def\Block{}
\newcommand{\block}[1]{\def\Block{#1}}

\newcommand{\SchoolNameFont}{\scshape}
\def\SchoolName{Proof School}
\newcommand{\school}[1]{\def\SchoolName{#1}}

\def\SchoolYear{YYYY--YY}
\newcommand{\schoolyear}[1]{\def\SchoolYear{#1}}

\newcommand{\CourseNameFont}{}
\def\CourseName{}
\def\CourseShortName{}
\NewDocumentCommand{\course}{O{#2}m}{%
	\def\CourseShortName{#1}%
	\def\CourseName{#2}%
}

\def\InstructorName{}
\def\InstructorFullName{}
\NewDocumentCommand{\instructor}{O{#2}m}{%
	\def\InstructorFullName{#1}%
	\def\InstructorName{#2}%
}

\def\UnitName{}
\newcommand{\unit}[1]{\def\UnitName{#1}}

\def\UnitNumber{}
\newcommand{\unitnumber}[1]{\def\UnitNumber{#1}}

\def\WeekNumber{}
\newcommand{\weeknumber}[1]{\def\WeekNumber{#1}}

\def\SheetNumber{}
\newcommand{\sheetnumber}[1]{\def\SheetNumber{#1}}

\def\Date{}
\renewcommand{\date}[1]{\def\Date{#1}}

\let\author\undefined

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
\newcommand{\@blankspacertext}{jgy}
%\newcommand{\@blankspacertext}{$\tfrac11$}

\NewDocumentCommand{\blank}{sO{}m}{%
	\IfBooleanTF{#1}% (if starred)
		{\smash{\@blank{#2}{}{#3}}}%
		{\@blank{#2}{}{#3}}}
\NewDocumentCommand{\filledblank}{sO{#3}mm}{%
	\IfBooleanTF{#1}% (if starred)
		{\smash{\@blank{#2}{#3}{#4}}}%
		{\@blank{#2}{#3}{#4}}}
\newcommand{\@blank}[3]{%
	\leavevmode%
	\begingroup%
		\savebox{\@blanktext}{\vphantom{\@blankspacertext}\ifshowsolutions#1\else#2\fi}%
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
\newcommand{\NameSpace}{\ifshowname\NameLineText\makebox[\NameLineLength][c]{\ifsoln[\StudentName]{\textbf{\AnswerKeyName}}}\fi}

\newcommand{\NameLineText}{Name:~}
\newlength{\NameLineLength}
\setlength{\NameLineLength}{1.75in}

\newcommand{\headerZG}{%
	\renewcommand{\CourseNameFont}{\large}%
	\LSheader%
		{{\TitleFont\FancyTitle}\\{\CourseNameFont\CourseName\ifx\UnitName\empty\else: \UnitName\fi}}%
		{\ifshowname\NameLine\\\fi\makebox[\NameLineLength]{~\SchoolYear\hfill\squircle\hfill Block \Block~}}%
}

\newcommand{\headerZGpic}[1]{%
	\renewcommand{\CourseNameFont}{\large}%
	\PLSheader%
		{#1}%
		{c}{\centering{\TitleFont\FancyTitle}\\{\CourseNameFont\CourseName\ifx\UnitName\empty\else: \UnitName\fi}}%
		{t}{\ifshowname\NameLine\\\fi\makebox[\NameLineLength]{~\SchoolYear\hfill\squircle\hfill Block \Block~}}%
}

\RequirePackage{varwidth}

% useful for making the picture extend into the margins
% #1: bottom
% #2: top
% #3: left/right
% #4: image
\newcommand{\lprotrude}[4][0pt]{\raisebox{\depth-#1}[\totalheight-#2-#1]{\makebox[\width-#3][r]{#4}}}
\newcommand{\rprotrude}[4][0pt]{\raisebox{\depth-#1}[\totalheight-#2-#1]{\makebox[\width-#3][l]{#4}}}
\newcommand{\protrude}{\lprotrude}

\newsavebox{\@headersectionP} % Picture (fit to contents) 
\newsavebox{\@headersectionS} % Short section (varwidth, fit to contents)
\newsavebox{\@headersectionL} % Long section (parbox, fill available space)

\newlength{\HeaderSectionSep}
\setlength{\HeaderSectionSep}{.25em}
% #1: height
% #2: width
% #3: outer alignment
% #4: alignment for Short section's box
% #5: contents of Short section's box
% #6: alignment of Long section's box
% #7: contents of Long section's box
\newcommand{\@fillheaderboxes}[7][\height]{%
	\savebox{\@headersectionS}{\begin{varwidth}[#3][#1][#4]{#2}#5\end{varwidth}}%
	\ifdim\wd\@headersectionS=0pt%
		\savebox{\@headersectionL}{\parbox[#3][#1][#6]{#2}{#7}}%
	\else%
		\savebox{\@headersectionL}{\parbox[#3][#1][#6]{\dimexpr #2-\wd\@headersectionS-\HeaderSectionSep}{#7}}%
	\fi%
}

% expects three boxes, doesn't add space if the following box is empty, assumes the first is nonempty.  Assumes that no arguments are left blank
\newcommand{\@arrangethreeboxes}[3]{%
	\usebox{#1}%
	\ifdim\wd#2>0pt%
		\hfill%
		\usebox{#2}%
	\fi%
	\ifdim\wd#3>0pt%
		\hfill%
		\usebox{#3}%
	\fi%
}
\newcommand{\@arrangetwoboxes}[2]{%
	\usebox{#1}%
	\ifdim\wd#2>0pt%
		\hfill%
		\usebox{#2}%
	\fi%
}

\newcommand{\@PLSheader}[5]{%
	\savebox{\@headersectionP}{#1}%
	\@fillheaderboxes%
		[\ht\@headersectionP]{\linewidth-\wd\@headersectionP-\HeaderSectionSep}{b}%
		{#4}{\raggedleft#5}%
		{#2}{\raggedright#3}%
	\@arrangethreeboxes{\@headersectionP}{\@headersectionL}{\@headersectionS}%
}

\newcommand{\@LSPheader}[5]{%
	\savebox{\@headersectionP}{#5}%
	\@fillheaderboxes%
		[\ht\@headersectionP]{\linewidth-\wd\@headersectionP-\HeaderSectionSep}{b}%
		{#3}{\raggedleft#4}%
		{#1}{\raggedright#2}%
	\@arrangethreeboxes{\@headersectionL}{\@headersectionS}{\@headersectionP}%
}

\newcommand{\@PSLheader}[5]{%
	\savebox{\@headersectionP}{#1}%
	\@fillheaderboxes%
		[\ht\@headersectionP]{\linewidth-\wd\@headersectionP-\HeaderSectionSep}{b}%
		{#2}{\raggedright#3}%
		{#4}{\raggedleft#5}%
	\@arrangethreeboxes{\@headersectionP}{\@headersectionS}{\@headersectionL}%
}

\newcommand{\@SLPheader}[5]{%
	\savebox{\@headersectionP}{#5}%
	\@fillheaderboxes%
		[\ht\@headersectionP]{\linewidth-\wd\@headersectionP-\HeaderSectionSep}{b}%
		{#1}{\raggedright#2}%
		{#3}{\raggedleft#4}%
	\@arrangethreeboxes{\@headersectionS}{\@headersectionL}{\@headersectionP}%
}

\newcommand{\PLLheader}[5]{%
	\savebox{\@headersectionP}{#1}%
	\usebox{\@headersectionP}%
	\hfill%
	\makebox[0pt][l]{\parbox[b][\ht\@headersectionP][#2]{\linewidth-\wd\@headersectionP-\HeaderSectionSep}{\raggedright#3}}%
	\parbox[b][\ht\@headersectionP][#4]{\linewidth-\wd\@headersectionP-\HeaderSectionSep}{\raggedleft#5}%
}

\newcommand{\LPLheader}[5]{%
	\savebox{\@headersectionP}{#3}%
	\parbox[b][\ht\@headersectionP][#1]{.5\linewidth-.5\wd\@headersectionP-\HeaderSectionSep}{\raggedright#2}%
	\hfill%
	\usebox{\@headersectionP}%
	\hfill%
	\parbox[b][\ht\@headersectionP][#4]{.5\linewidth-.5\wd\@headersectionP-\HeaderSectionSep}{\raggedleft#5}%
}

\newcommand{\LLPheader}[5]{%
	\savebox{\@headersectionP}{#5}%
	\makebox[0pt][l]{\parbox[b][\ht\@headersectionP][#1]{\linewidth-\wd\@headersectionP-\HeaderSectionSep}{\raggedright#2}}%
	\parbox[b][\ht\@headersectionP][#3]{\linewidth-\wd\@headersectionP-\HeaderSectionSep}{\raggedleft#4}%
	\hfill%
	\usebox{\@headersectionP}%
}

\newcommand{\@LSheader}[2]{%
	\@fillheaderboxes{\linewidth}{t}%
		{t}{\raggedleft#2}%
		{t}{\raggedright#1}%
	\@arrangetwoboxes{\@headersectionL}{\@headersectionS}\\%
}

\newcommand{\@SLheader}[2]{%
	\@fillheaderboxes{\linewidth}{t}%
		{t}{\raggedright#1}%
		{t}{\raggedleft#2}%
	\@arrangetwoboxes{\@headersectionS}{\@headersectionL}\\%
}

\newcommand{\LLheader}[2]{%
	\makebox[0pt][l]{\parbox[t]{\linewidth}{\raggedright#1}}%
	\parbox[t]{\linewidth}{\raggedleft#2}\\%
}

\newcommand{\twopartheaderpic}{\PLSheader} % deprecated
\newcommand{\threepartheader}{\PLSheader} % deprecated
\newcommand{\PLSheader}{\@ifstar\PLLheader\@PLSheader}
\newcommand{\PSLheader}{\@ifstar\PLLheader\@PSLheader}
\newcommand{\LSPheader}{\@ifstar\LLPheader\@LSPheader}
\newcommand{\SLPheader}{\@ifstar\LLPheader\@SLPheader}

\newcommand{\PSSheader}{\PLLheader}

\newcommand{\twopartheader}{\LSheader} % deprecated
\newcommand{\LSheader}{\@ifstar\LLheader\@LSheader}
\newcommand{\SLheader}{\@ifstar\LLheader\@SLheader}


\newlength{\HeaderHeight}
\setlength{\HeaderHeight}{1in}

\newcommand{\gridheader}[8][\TitleFont\strut\FancyTitle\strut]{%
	\makebox[0pt][l]{\parbox[b][\HeaderHeight]{#8}{%
		\raggedright #2\vfill}}%
	\makebox[0pt][l]{\parbox[b][\HeaderHeight]{#8}{%
		\centering #3\vfill}}%
	\makebox[0pt][l]{\parbox[b][\HeaderHeight]{#8}{%
		\raggedleft #4\vfill}}%
	\makebox[0pt][l]{\raisebox{0pt}[\height][0pt]{\parbox[b][\HeaderHeight]{#8}{%
		\raggedright\vspace*{\fill}#5}}}%
	\makebox[0pt][l]{\raisebox{0pt}[\height][0pt]{\parbox[b][\HeaderHeight]{#8}{%
		\centering\vspace*{\fill}#6}}}%
	\makebox[0pt][l]{\raisebox{0pt}[\height][0pt]{\parbox[b][\HeaderHeight]{#8}{%
		\raggedleft\vspace*{\fill}#7}}}%
	\raisebox{0pt}[\height][0pt]{\parbox[b][\HeaderHeight]{#8}{%
		\centering\vspace*{\fill}#1\vspace*{\fill}}}%
}%

\newcommand{\boxedheader}[7][\TitleFont\strut\FancyTitle\strut]{{%
	\setlength{\fboxsep}{3pt}%
	\fbox{%
		\gridheader[#1]{#2}{#3}{#4}{#5}{#6}{#7}{\linewidth-2\fboxrule-2\fboxsep}%
	}%
}}

\newcommand{\tcboxedheader}[7][\TitleFont\strut\FancyTitle\strut]{%
	\begin{tcolorbox}[
			enhanced, empty,
			boxrule=0pt, boxsep=0pt,
			%left=3pt, right=3pt, top=3pt, bottom=3pt,
			%frame code={\draw[rounded corners] (frame.south west) rectangle (frame.north east);}
			% rounded corners=1mm if you want to match the theorems?
			left=0pt, right=0pt, top=0pt, bottom=0pt,
			frame code={\draw[rounded corners] ([shift={(-1.5mm,-1.5mm)}]frame.south west) rectangle ([shift={(1.5mm,1.5mm)}]frame.north east);}
		]
		\gridheader[#1]{#2}{#3}{#4}{#5}{#6}{#7}{\linewidth}
	\end{tcolorbox}
}


\newcommand{\teeheader}[3][\TitleFont\FancyTitle]{%
	\begin{center}%
	\begin{tikzpicture}[outer sep=1mm, inner sep=0pt]
		\node[anchor=south, align=center] (T) at (0,0)
			{#1\strut};%
		\node[anchor=north east, align=right] (L) at (0,0)
			{\strut#2\strut};
		\node[anchor=north west, align=left] (R) at (0,0)
			{\strut#3\strut};
		\draw (T.south east) -- (T.south west);
		\draw ([yshift=-1mm] L.north east) -- ([yshift=2mm] L.south east) -- ([yshift=2mm] R.south west);
	\end{tikzpicture}%
	\end{center}%
}


\newcommand{\HeaderStyleMS}{
	\renewcommand{\SheetNumberPrefix}{Handout~}
	\renewcommand{\SheetNumberPostfix}{:\ }
	\renewcommand{\SchoolNameFont}{}
	\renewcommand{\TitleFont}{\Large}
	\renewcommand{\FirstPageHeader}{%
		\boxedheader%
			{\CourseNameFont\CourseName}{}{Teacher: \InstructorName}%
			{Week \WeekNumber}{}{{\SchoolNameFont\SchoolName} \SchoolYear}}
}

\newcommand{\HeaderStyleZG}{
	\renewcommand{\FirstPageHeader}{\headerZG}
}

\newcommand{\HeaderStyleZGpic}[1]{
	\renewcommand{\FirstPageHeader}{\headerZGpic{#1}}
}

\newcommand{\FirstPageHeader}{}
\HeaderStyleZG

\renewcommand{\maketitle}{{%
	\thispagestyle{firstpage}%
	\onehalfspacing%
	\noindent%
	\FirstPageHeader%
	\par%
	\bigskip%
	\vspace{-\parskip}%
	% FIX ME: \noindent for first line of text after heading?
}}







%%%%%%%%%% Section Headings %%%%%%%%%%
\usepackage[compact]{titlesec}
\titleformat*{\section}{\Large\bfseries\boldmath}
\titleformat*{\subsection}{\large\bfseries\boldmath}
\titleformat*{\subsubsection}{\normalsize\bfseries\boldmath}









%%%%%%%%%% Squircles %%%%%%%%%%
\usetikzlibrary{decorations.pathmorphing}
\newcommand{\Squircle}[2]{\resizebox{!}{#1}{\tikz{\draw[line width=.11cm,#2] (-.5, -.5) rectangle (.5, .5) (0,0) circle (.25);}}}

\pgfdeclaredecoration{vertical random steps}{start}
{%
  \state{start}[width=+0pt,next state=step,persistent precomputation=\pgfdecoratepathhascornerstrue]{}%
  \state{step}[auto end on length=1.5\pgfdecorationsegmentlength,
               auto corner on length=1.5\pgfdecorationsegmentlength,
               width=+\pgfdecorationsegmentlength]
  {
    \pgfpathlineto{
      \pgfpointadd
      {\pgfpoint{\pgfdecorationsegmentlength}{0pt}}
      {\pgfpoint{0pt}{rand*\pgfdecorationsegmentamplitude}}
    }
  }%
  \state{final}
  {}%
}%

\newcommand{\SquircleStripes}[8][1]{\resizebox{!}{#2}{\tikz{%
	\draw[line width=.02cm, #3] (-.53, -.53) rectangle (.53, .53) (0,0) circle (.25+#1*.05);
	\draw[line width=.02cm, #4] (-.51, -.51) rectangle (.51, .51) (0,0) circle (.25+#1*.03);
	\draw[line width=.02cm, #5] (-.49, -.49) rectangle (.49, .49) (0,0) circle (.25+#1*.01);
	\draw[line width=.02cm, #6] (-.47, -.47) rectangle (.47, .47) (0,0) circle (.25-#1*.01);
	\draw[line width=.02cm, #7] (-.45, -.45) rectangle (.45, .45) (0,0) circle (.25-#1*.03);
	\draw[line width=.02cm, #8] (-.43, -.43) rectangle (.43, .43) (0,0) circle (.25-#1*.05);
}}}
\newcommand{\SquircleRainbow}[2][1]{\SquircleStripes[#1]{#2}{red}{orange}{yellow}{green!90!black}{blue!60!cyan}{violet!80}}
\newcommand{\SquircleFadeIn}[3][1]{\def\tmp{#3}\ifx\tmp\empty\def\tmp{black}\fi\SquircleStripes[#1]{#2}{\tmp!80}{\tmp!70}{\tmp!60}{\tmp!50}{\tmp!40}{\tmp!30}}
\newcommand{\SquircleFadeOut}[3][1]{\def\tmp{#3}\ifx\tmp\empty\def\tmp{black}\fi\SquircleStripes[#1]{#2}{\tmp!30}{\tmp!40}{\tmp!50}{\tmp!60}{\tmp!70}{\tmp!80}}
\newcommand{\SquircleSoft}[2]{\def\tmp{#2}\ifx\tmp\empty\def\tmp{black}\fi\Squircle{#1}{
	\tmp!10, line width=.165cm,
	postaction={draw, \tmp!20, line width=.135cm},
	postaction={draw, \tmp!40, line width=.105cm},
	postaction={draw, \tmp!60, line width=.075cm},
	postaction={draw, \tmp!75, line width=.045cm},
	postaction={draw, \tmp, line width=.015cm}}}
\newcommand{\SquircleOuterLine}[3]{\Squircle{#1}{black,#3,postaction={draw=gray, line width={\dimexpr .11cm-.8pt},#2}}}
\newcommand{\SquircleInnerLine}[3]{\Squircle{#1}{gray,#2,postaction={draw=black, thin,#3}}}
\newcommand{\SquircleShakyLine}[4][]{\SquircleInnerLine{#2}{#3}{line join=bevel, decorate, decoration={vertical random steps, amplitude=.045cm, segment length=.022cm,#1},#4}}
\newcommand{\SquircleCrazyLine}[4][]{\SquircleInnerLine{#2}{#3}{line join=bevel, decorate, decoration={random steps, segment length=.02cm, amplitude=.04cm,#1},#4}}
\newcommand{\squircle}[1][]{{\settoheight{\dimen255}{I}\Squircle{\dimen255}{line width=.1cm, #1}}}








%%%%%%%%%% Hooks %%%%%%%%%%
\AtBeginDocument{%
	\setlength{\outsideparskip}{\parskip}%
	\ifdim\parskip>0pt%
		\xpatchcmd{\proof}{\topsep6\p@\@plus6\p@\relax}{}{}{}%
		%\def\thm@space@setup{%
		%	\thm@preskip=\parskip \thm@postskip=0pt%
		%}
	\fi%
	\if@showtitle%
		\maketitle%
	\fi%
}








%%%%%%%%%% Assorted %%%%%%%%%%
\renewcommand{\qedsymbol}{\squircle}

\newcommand{\SpoilerFont}{\itshape}
\newcommand{\@spoilertext}{}
\newcommand{\DefaultSpoilerText}{Spoilers ahead! Proceed with caution\ldots}
\newcommand{\spoilerbreak}[1][\DefaultSpoilerText]{\renewcommand{\@spoilertext}{#1}\newpage\renewcommand{\@spoilertext}{}}

\newcommand{\ScratchWorkFont}{\itshape}
\newcommand{\DefaultScratchWorkText}{Scratch work}
\newcommand{\scratchpage}[1][\DefaultScratchWorkText]{\newpage\begin{center}\ScratchWorkFont#1\end{center}}

\newcommand{\bonus}{{\Large{$\star$}}}% depricated

% I just think there is too much space around displayed equations?
\apptocmd\normalsize{%
	\abovedisplayskip=7pt plus 3pt minus 4pt%
	\abovedisplayshortskip=0pt plus 3pt%
	\belowdisplayskip=7pt plus 3pt minus 4pt%
	\belowdisplayshortskip=7pt plus 3pt minus 4pt%
}{}{}

% A fix for the bad spacing around \left and \right
% Taken from: https://tex.stackexchange.com/questions/2607/spacing-around-left-and-right
\let\originalleft\left
\let\originalright\right
\renewcommand{\left}{\mathopen{}\mathclose\bgroup\originalleft}
\renewcommand{\right}{\aftergroup\egroup\originalright}

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
\NewDocumentCommand{\smartoverline}{O{#2}m}{%
	{%
		\StrChar{#1}{1}[\tmp]%
		\IfSubStr{Uacehikqtxy}{\tmp}{\def\tmp{0.04em}}{%
		\IfSubStr{CGIOQdgjosz}{\tmp}{\def\tmp{0.1em}}{%
		\IfSubStr{BDEFHJKLMNPRXZSf}{\tmp}{\def\tmp{0.16em}}{%
		\IfSubStr{A}{\tmp}{\def\tmp{0.2em}}{\def\tmp{0em}}}}}%
		\mathmakebox[0pt][l]{\hspace*{\tmp}\overline{\mathmakebox[\dimexpr \width-\tmp]{\phantom{#2}}}}%
	}%
	#2%
}

\newcommand{\intersentencespace}{\spacefactor\sfcode`. \space}

\newtcolorbox{centeredframe}[1][0pt]{
	before upper={\restoreparskip},
	enhanced,
	empty,
	boxrule=0mm,
	boxsep=0mm,
	left=#1,
	right=#1,
	top=1.5mm,
	bottom=1.5mm,
	frame code={\draw[rounded corners=1mm] ([shift={(#1-1.5mm,0pt)}]frame.south west) rectangle ([shift={(-1*#1+1.5mm,0pt)}]frame.north east);},
}

\newtcolorbox{partialframe}[1][0pt]{
	before upper={\restoreparskip},
	enhanced,
	empty,
	boxrule=0mm,
	boxsep=0mm,
	left=#1,
	right=#1,
	top=1.5mm,
	bottom=1.5mm,
	frame code={\draw[line cap=round, rounded corners=1mm] ([shift={(#1+1.5in,0pt)}]frame.south west) -- ([shift={(#1-1.5mm,0pt)}]frame.south west) |- ([shift={(#1+1in,0pt)}]frame.north west);},
}

% lower it's argument so that the top is aligned with the top of a normal line of text (specifically, the height of an `I').  An optional argument allows you to specify the perceived depth.
\newcommand{\aligntop}[2][\dimexpr\totalheight-\dimen255]{{\settoheight{\dimen255}{I}\raisebox{\dimexpr\dimen255-\height}[\dimen255][#1]{#2}}}


\newcommand{\TermFont}{\bfseries\boldmath}
\newcommand{\term}[1]{%
	{\TermFont{#1}}%
}
