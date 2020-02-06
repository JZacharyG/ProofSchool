# handout.cls

 A document class for typesetting Proof School handouts.

## Key Features

- It looks pretty good, IMHO.  Page numbers are written as "Page X of Y", the handout's title is printed in the header of subsequent pages, and a little squircle replaces the QED symbol in proofs.  Theorems and definitions and such are typeset in a nice little partial frame to visually set them off from the rest of the text, (hopefully) without being too ostentatious.
- Each problem, optionally along with its solution, is contained in a separate environment.  This makes it easy to reorder the problems, and means that you can intersperse other content between problems (or between parts of problems) without throwing off the numbering.
- You can typeset a problem set and its answer key from the same file with no changes to the body of the document (by passing the option `solutions` to the document class).
- It is very easy to specify either an absolute or relative amount of space to leave below each problem, and absent explicit instructions, a sensible default is used.
- When typeset, the solutions do not effect the amount of space left below a problem, so the overall layout is (approximately) identical between the problem set and the answer key.
- Problems can easily be set in a grid (with a specified number of columns), with problems numbered across the rows.  You do not need to specify explicit line breaks, so it is easy to change the number of columns or reorder the problems at any point.

## Requirements

- This document class requires a fairly recent version of the package `enumitem`, so if you haven't updated it (or your entire LaTeX distribution) in the past few months, you may have problems!  This would manifest as certain options to the `prob` environment not working, namely `space`, `columns`, and `points`.

  You should probably update your whole distribution, technically, but if you understandably don't want to take the time, you can download the latest version [here](https://ctan.org/pkg/enumitem) and then move `enumitem.sty` to `/usr/local/texlive/2018/texmf-dist/tex/latex/enumitem` (or similar, your year might be different, and if you aren't using texlive then I'm not sure...).

## Usage

### Installation

- For a quick and dirty solution, you can just put `handout.cls` in the same directory as the handout that you are making.  Done!

- For a LaTeX distribution based on texlive (including MacTeX), add `handout.cls` to the "local" section (so that it is not overwritten when you next update LaTeX).  If your LaTeX installation is in the default location, I think you'll need to move the file to`/usr/local/texlive/texmf-local/tex/latex/ProofSchool`, or whatever folder name you want at the end.

  You then need to tell LaTeX to update its list of available things by running `sudo texhash` in Terminal.
  
- For MiKTeX, I don't really know, but it's probably easy!

- Overleaf: [This might be helpful](https://www.overleaf.com/learn/latex/Questions/I_have_a_lot_of_.cls,_.sty,_.bst_files,_and_I_want_to_put_them_in_a_folder_to_keep_my_project_uncluttered._But_my_project_is_not_finding_them_to_compile_correctly)?

### Document Class Options

To begin, use the document class `handout`.  My typical usage looks like this:
```latex
\documentclass[12pt,twoside,parskip]{handout}
```
... or, when I want an answer key:
```latex
\documentclass[12pt,twoside,parskip,solutions]{handout}
```
The following options are recognized:

-  `solutions`/`boxedsolutions`/`nosolutions` (default): whether and how to typeset the solutions to problems.  (It basically just sets `\showsolutiontrue`, if you are familiar with TeX's ifs.)  If `boxedsolutions` is given, then solutions are typeset and are put in in `\fbox`es.
- `spaces` (default)/`nospaces`: whether or not to leave the specified space after problems.  The `nospaces` option is useful for answer keys if you don't care about preserving formatting and for drafting problem sets, when you want to see as many problems at a time as possible.  Honestly, I don't use this it that often. 
- `parskip`/`parindent` (default): parskip loads the parskip library, which I think looks great.
- `name` (default)/`runningname`/`noname`: whether and how to leave a space for the students' names.  It is up to the heading to respect this option (by consulting `\ifshowname`).  If `runningname` is given, then the name is additionally printed in the header of every page (`oneside`) or every odd page (`twoside`).
- `title` (default)/`notitle`: whether or not to automatically call `\maketitle` at the start of the document, which typesets the heading for the first page.
- `pagenums`(default)/`nopagenums`: turns on/off the page numbers in the lower right corner.
- `probnumbers` (default)/`checkboxes`/`noprobnumbers`: whether and how to display problem numbers.  `checkboxes` replaces the problem numbers with checkboxes, `noprobnumbers` removes the problem numbers.  In either of the latter two options, subproblems are still numbered.
- `boxedtheorems`(default)/`noboxedtheorems`: switches between having a frame around theorems and such and a more traditional style.
- `sharednumbers`(default)/`differentnumbers`: whether to use the same counter for theorems, definitions, et cetera or a separate one for each ("Theorem 1, Lemma 2, Theorem 3" vs "Theorem 1, Lemma 1, Theorem 2")
- `14pt` to set the base font size to 14pt, complementing the options `10pt`, `11pt`, and `12pt`, provided by the `article` class.
- Anything that you can do for the `article` document class.  Notably,
  - `10pt`/`11pt`/`12pt`
  - `oneside`/`twoside`
  - `letterpaper`/`a4paper`/...

### Problem Environment

You can add problem using the `prob` environment:

``` latex
\begin{prob}[points=5]
    What shall we do with a drunken sailor?
    \solution
    Shave his belly with a rusty razor.
\end{prob}
```

You can add parts/subproblems by nesting these environments up to three levels deep.  The first level is labeled with numbers, the second with lowercase letters, the third with lowercase roman numerals.

The `prob*` environment creates an unnumbered problem, which has all of the features of a problem (including easy control of spacing and the ability to add solutions) in a format that looks more or less like a normal block of text!  Unless explicitly suppressed, subproblems will still be numbered as usual.

#### Solutions

If `\solution` or `\solution*` appears inside a problem environment, then everything that follows will only by typeset if solutions are shown (with the option `solutions`).

Importantly, the solution is placed in the space below the problem, but (if using `\solution`, not `\solution*`) it does not add any additional space, so the layout of the handout will be identical whether or not you show solutions.  This unfortunately means that the solution can spill over into the next problem, or off the end of the page, if you are not careful.  

The starred version instead has the solution replace the space that would otherwise have been left.

If typeset, the solution will be prepended with the contents of `\SolutionPrefixFont\SolutionPrefix`, which default to `\bfseries` and `SOLUTION:` respectively , but you can `\renewcommand` either of them if you’d like.
#### Problems in Columns/Grids
Problems can be placed in a grid (numbered across the row, instead of down the column).  This can be achieved with the `columns` option described below, or by issuing the command `\ProbsInColumns{n}`, where n is the desired number of columns. `\ProbsNotInColumns` is equivalent to `\ProbsInColumns{0}`, and causes subsequent problems to be typeset in the usual way.  This command is useful (in comparison to corresponding option to the `prob` environment) if you want to change the number of columns part way through a grid, or if you want to use columns for the top level of problems instead of just for subproblems.

You do not need to add explicit linebreaks, but any linebreaks that you do add will be respected.  The first problem in a grid should be preceeded by a blank line.

The space between columns is controlled by the length `\ProbColSep`, which is initially .5cm, and can be changed with `\setlength{\ProbColSep}{...}`.

**Be forewarned:** the spaces below all problems in a row stack, which can lead to some unexpected results.

```latex
\begin{prob}[columns=2]
    Differentiate each of the following with respect to x:
    
    \begin{prob}
        $e^x$
    \end{prob}
    \begin{prob}
        $x^\pi$
    \end{prob}
    \begin{prob}
        $e^\pi$
    \end{prob}
    \begin{prob}
        $x^x$
    \end{prob}
    \ProbsInColumns{3}
    \begin{prob}
        $\sin(x)$
    \end{prob}
    \begin{prob}
        $\cos(x)$
    \end{prob}
    \begin{prob}
        $\sec^3(x)$
    \end{prob}
\end{prob}
```

#### Optional Options

The problem environment recognizes the following options (in square brackets after the `\begin{prob}`):

- `space`/`nospace` will determine how much space is left after a problem.  `space` can be passed a length (e.g., `space=2in`), which will leave that much space below the problem for students to write their solution, or it may be passed a number (e.g., `space=2`), which will fill the available space on the page, in proportion to the numbers given (so if one problem is given `space=1` and another `space=2`, then the latter will be given twice as much space as the former).  `space` is equivalent to `space=1`, `nospace` is equivalent to `space=0pt`, and if neither is present, then a sensible default is used (equivalent to `nospace` if this problem contains subparts and `space` if not).
- `spaces`/`nospaces` sets the default space for this problem and its subproblems (can still be explicitly overwritten by use `space` on the subproblem).
- `points=n` displays the number of points that the question is worth at the beginning of the problem.
- `columns=n`: typesets any subproblems of this problem in a grid with n columns.
- `bonus`/`exciting`/`surprising`/`play`/`stop`/`discuss`/`calculator`/`attention`/`check`: displays a little picture to the left of the problem number, to communicate in some way with the student.  This picture is, respectively: a star, a pair of exclamation marks, an interrobang, a beach ball, a stop sign, a pair of speech bubbles, an array of arithmetic operations, a pointing hand, and a checkbox.  I'd love to add more, or give them different names, if it would be helpful to you.
- This environment is implemented as a enumerate-like environment using the `enumitem` package; any other options are just passed along to the underlying list (so for example, you can pass in  `start=23` to begin counting at 23).

### Headings

- There are a couple of commands used to declare the information that might be present in the heading:
  - `\course`
  - `\instructor`
  - `\schoolyear`
  - `\block`
  - `\unit`
  - `\unitnumber`
  - `\weeknumber`
  - `\date`
  - `\sheetnumber`
  - `\title`
  - `\studentname`
  - `\school`, which defaults to `Proof School`, and so will generally not be needed.  But hey, maybe you teach elsewhere as well?
  
  I would suggest making a file named `CourseInfo.tex`, and then `\input`ing it in the preamble of every handout.  It would contain the first four (for math classes) or three (for morning classes) of these commands, which would be common to all handouts for a given class.  You can also include any custom macros or other definitions that you want for this class, and all of your handouts will automatically see them!
  
- A heading is automatically placed at the top of the first page (unless the `notitle` option is given to the document class).  There are a few that are pre-defined, and you can fairly easily make your own!
  - You can use `\renewcommand{\FirstPageHeader}{...}` to use a different header.  This is *also* the sort of thing that I'd recommend putting in `CourseInfo.tex`.
  - So far, the predefined headers are
    - `\boxedheader`, which takes 6 mandatory arguments which populate, respectively, upper left corner, upper center, upper right corner, lower left corner, lower center, and lower right corner.  There is also an optional argument which controls the center, which defaults to the title of the handout (specifically, `\TitleFont\strut\FancyTitle\strut`.
    - `\tcboxedheader`, which has the same interface as `\boxedheader` but a slightly more fun appearance (rounded corners, box extends slightly into the margin).
    - `\**header` where  `**` is one of `LS`, `SL`, or `LL`.  These are fairly minimal headings which divide the space into two sections. `S` creates a short section whose width is only as wide as the contents require, and `L` creates a long section, which fills the remaining space.  The `LL` combination has each take the full width of the page, so the two sections can overlap (equivalent to `\LSheader*` and `\SLheader*`).  In each case, the command takes two mandatory arguments, containing the contents of the two sections.
    - `\***header` where `***` is one of `PLS`, `PSL`, `PLL`, `LSP`, `SLP`, `LLP`, or `LPL`. These headers have three parts: a picture and two text boxes which are the same height as the picture.  They appear in the order specified: `P` for picture, `S` for a text box that is fit to its content, `L` for a text box that takes up the remaining space. The text boxes in `PLL` and `LLP` each take up all of the space left after the image, and so overlap.  In `LPL`, the picture is centered and the text boxes fill the space on either side.

      For each, there are five mandatory arguments, one for the picture and two for each text box, which are given in the order in which those elements appear.  The two arguments for each text box are first the vertical alignment of the text (`t`, `c`, or `b`), then the contents.
    - `\teeheader` is a header with a centered title and a vertical line drawn underneath and the text of your choice on either side of it.  This header takes two mandatory arguments, for the text on the left and right respectively, and one optional argument to overwrite the centered text (which defaults to `\TitleFont\FancyTitle`).
  - You may `\renewcommand` any of the following to customize the look of your heading:
    - `\SheetNumberPrefix`: text prepended to the `\SheetNumber`, if it exists. By default, this is `\S`, but maybe you'd like `Handout~` or similar.
    - `\SheetNumberPostfix`: text that is appended to the `\SheetNumber`, it if exists, to separate it from the `\Title`.  By default, this is just a space, but maybe you'd want a colon or some such
    - `\NameLineText`: the text prepended to the line where students will write their name.  By default, `Name:~`.
    - `\NameLineLength`: is the length of the line where they'd write their name.  If there is a date line, it is likely of the same length.  This is a length, so you should set it with `\setlength`, not `\renewcommand`.
    - `\TitleFont`: the font used for the `\Title` of the handout.  By default, `\large\bfseries\boldmath`
    - `\SchoolNameFont`: the font used for the school name.  By default, `\scshape`.
    - `\CourseNameFont`: the font used for the `\CourseName`.  By default, this command is empty.
  - If you define your own custom header, the following macros are available to you:
    - `\CourseName`
    - `\InstructorName`
    - `\SchoolName`
    - `\SchoolYear`
    - `\Block`
    - `\UnitName`
    - `\UnitNumber`
    - `\WeekNumber`
    - `\Date`
    - `\SheetNumber`
    - `\Title`
    - `\FancyTitle`, which contains the title, prepended with the unit number and sheet number (if present)
    - `\NameLine`
    - `\NameSpace`
  - For example, Mia's boxed headings can be achieved by placing the following in the preamble (or, preferably, in a shared `CourseInfo.tex` file).
    ```latex
    \renewcommand{\SheetNumberPrefix}{Handout~}
    \renewcommand{\SheetNumberPostfix}{:\ }
    \renewcommand{\SchoolNameFont}{}
    \renewcommand{\TitleFont}{\Large}
    \renewcommand{\FirstPageHeader}{\boxedheader{\CourseNameFont\CourseName}{}{Teacher: \InstructorName}{Week \WeekNumber}{}{{\SchoolNameFont\SchoolName} \SchoolYear}}
    ```
  Or, if you like shortcuts, this is all bundled into the macro `\HeaderStyleMS`.
- If you have a header that you like, let me know and we can make sure that it is implemented and easily choose-able!

### Odds and Ends

- `\blank`, `\blank*`: Leaves a blank that students can fill in.  One mandatory argument sets the length of the blank, one optional argument is for a solution.  In the starred variant, the blank is `\smash`ed so that very large solutions won't throw off the vertical spacing.
- `\smartoverline`: I think that `\overline`s look bad for some letters, because it is computed based on the bounding box and so can extend pretty far from the top of the letter.  This tries to fix that by starting the overline a little further to the left than in normally would be (based on what the first letter is).
- `\spoilerbreak`: displays the message: "*Spoilers ahead! Proceed with caution...*" in the bottom left corner of the page, then inserts a page break.  An optional argument lets you use a different message.  You can also `\renewcommand` the following:
  - `\SpoilerFont`: the font used, by default `\itshape`.
  - `\DefaultSpoilerText`: the default text used.  By default, as stated above, `Spoilers ahead! Proceed with caution\ldots`.
- `\scratchpage`: makes a new page with *Scratch work* centered at the top.  You can also `\renewcommand` the following:
  - `\ScratchWorkFont`: the font used, by default `\itshape`.
  - `\DefaultScratchWorkText`: the default text used.  By default `Scratch work`.
- Theorems!  If you have passed the `noboxedtheorems` option to the document class, these are in the style of the `amsthm` package.  Otherwise, classes up your theorems and definitions and such in fancy boxes!  Either way, the following are defined, but you can make more if you want.
  - `theorem`/`theorem*`
  - `lemma`/`lemma*`
  - `corollary`/`corollary*`
  - `claim`/`claim*`
  - `conjecture`/`conjecture*`
  - `proposition`/`proposition*`
  - `definition`/`definition*`
  - `example`/`example*`
  - `remark`/`remark*`
- Squircles!
  - `\squircle` makes a small squircle!  The qed symbol at the end of a proof defaults to this symbol.
  - `\Squircle` makes a big squircle.  It takes two mandatory arguments, first the size, then the style (this can be any style that Ti*k*Z will recognize in a `\draw` command—notably, the name of a color).
  
  There are also some fun variants.  For each, the first mandatory argument controls the size of the squircle.  Further options are demonstrated in the file SampleSquircles.tex
  - `\SquircleRainbow` 
  - `\SquircleFadeIn`
  - `\SquircleFadeOut`
  - `\SquircleSoft`
  - `\SquircleOuterLine`
  - `\SquircleInnerLine`
  - `\SquircleShakyLine`
  - `\SquircleCrazyLine`
- `\ifsoln` typesets its mandatory argument if solutions are displayed, and its optional argument otherwise.

## Change Log

### v1.3

- Added an option for 14pt font.
- References to subproblems now only include the letter for that subproblem (so problem "1a" would be referenced as "a", not "a)" or "1a" or "1a)").
- The section, subsection, and subsubsection headings are somewhat less intrusive, with less vertical space.  They also now make math in the section heading bold, to match the surrounding text.
- Added a `\term` command to semantically style new terms when you introduce them.
- Some commands have been rewritten using the `xparse` package, so that (matched) square brackets in optional arguments don't need to be protected.
- Corrections (including fixing the spacing above a `proof`) are now based on a nonzero `\parskip`, determined at the start of the document, instead of only being applied if the `parskip` option is given to the document class.

  In particular, this means that the corrections will still be applied if you load the package yourself.  This is necessary if you like the `parfill` option, in which case you should *not* use the `parskip` option and should instead call `\usepackage[parfill]{parskip}` in the preamble.

### v1.2

- Added an option to leave a blank for the student's name on only the first page (`name`) or on every page (`runningname`).
- Added an option to put a box around solutions (`boxedsolutions`).
- Added an option to use separate counters for theorems, lemmas, definitions, et cetera (`differentnumbers`).
- Added `prob*` environment for unnumbered problem.  This has all the features of a problem, but should otherwise blend in with the surrounding text.
- Added an option to have no problem numbers (`noprobnumbers`) or to use a check box instead of the problem number (`checkboxes`).  In each case, this applies only to top level problems, and any of their subproblems will still be numbered.
- Added an option to use amsthm-style theorems (`noboxedtheorems`) instead of having a partial frame around them.
- Reduced excess spacing above proofs when `\parskip` is nonzero.
- Added more space between problem numbers and any picture that is placed next to it.
- Added more pictures which can be used to decorate problems (`check` and `attention`).
- Added length `\ProbColSep` to control the space between columns of problems.
- Added keyword `spaces` to `prob` environment to control the default space left for its subproblems.
- Changed the default `\CourseNameFont` from `\large` to no default.
- Added `\date` command to let you specify the date of a handout (though you'll need to make sure the header displays this information).
- Lowered the line in `\blank`s so that it can fit normal descenders like j, g, and y.
- Changed the behavior of `\blank` and `\blank*`.  Now, the line is always lowered to fit the content (when displaying the solution), but if the starred version is given, the entire blank is `\smash`ed so that it does not change other formatting on the page.
- Added command `\NameSpace` which looks the same as `\NameLine`, just without the line.
- Added a more rich collection of headers to replace `\twopartheader` and `twopartheaderpic`, which are now deprecated.  The equivalent commands are `\LSheader` and `PLSheader`, respectively.
- All headers are now set with `\onehalfspacing` by default.
- Lots of new squircles!
- A fix for a bug(?) in LaTeX which results in sometimes quirky spacing around `\left` and `\right`.

### v1.1

- Fixed a bug preventing the `bonus` keyword to the `prob` environment from working.