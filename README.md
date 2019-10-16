# handout.cls

 A document class for typesetting Proof School handouts.

## Key Features

- It looks pretty good, IMHO.  Page numbers are written as "Page X of Y", the handout's title is printed in the header of subsequent pages, and a little squircle replaces the QED symbol in proofs.  Theorems and definitions and such are typeset in a nice little partial frame to visually set them off from the rest of the text, (hopefully) without being too ostentatious.
- Each problem, optionally along with its solution, is contained in a separate environment.  This makes it easy to reorder the problems, and means that you can intersperse other content between problems (or between parts of problems) without throwing off the numbering.
- You can typeset a problem set and its answer key from the same file with no changes to the body of the document (by passing the option `solutions` to the document class).
- It is very easy to specify either an absolute or relative amount of space to leave below each problem, and absent explicit instructions, a sensible default is used.
- When typeset, the solutions do not effect the amount of space left below a problem, so the overall layout is (approximately) identical between the problem set and the answer key.
- Problems can easily be set in a grid (with a specified number of columns), with problems numbered across the rows.  You do not need to specify explicit line breaks, so it is easy to change the number of columns or reorder the problems at any point.

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

-  `solutions`/`nosolutions` (default): set whether or not to typeset the solutions to problems.  (It basically just sets `\showsolutiontrue`, if you are familiar with TeX's ifs.)
- `spaces` (default)/`nospaces`: whether or not to leave the specified space after problems.  The `nospaces` option is useful for answer keys if you don't care about preserving formatting and for drafting problem sets, when you want to see as many problems at a time as possible.  Honestly, I don't use this it that often. 
- `parskip`/`parindent` (default): parskip loads the parskip library, which I think looks great.
- `name`( default)/`noname`: whether or not to leave a space for the students' names.
- `title` (default)/`notitle`: whether or not to automatically call `\maketitle` at the start of the document, which typesets the heading for the first page.
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

You can add parts/subproblems by nesting these environments.  They can be nested up to three levels deep.  The first level is labeled with Arabic numerals, the second with lowercase letters, the third with lowercase roman numerals.
#### Solutions
If `\solution` or `\solution*` appears inside a problem environment, then everything that follows will only by typeset if solutions are shown (with the option `solutions`).

Importantly, the solution is placed in the space below the problem, but (if using `\solution`) it does not add any additional space, so the layout of the handout will be identical whether or not you show solutions.  This unfortunately means that the solution can spill over into the next problem, or off the end of the page, if you are not careful.  The starred version instead has the solution replace the space that would otherwise have been left.

If typeset, the solution will be prepended with the contents of `\solutiontitle`, which defaults to ’’**SOLUTION:** ”, but you can renew this command if you’d like.
#### Problems in Columns/Grids
Problems can be placed in a grid (numbered across the row, instead of down the column).  This can be achieved with the option described below, or by issuing the command `\ProbsInColumns{n}`, where n is the desired number of columns. `\ProbsNotInColumns` is equivalent to `\ProbsInColumns{0}`, and causes subsequent problems to be typeset in the usual way.  This command is useful (in comparison to corresponding option to the `prob` environment) if you want to change the number of columns part way through a grid, or if you want to use columns for the top level of problems instead of just for subproblems.

You do not need to add explicit linebreaks, but any linebreaks that you do add will be respected.  The first problem in a grid should be preceeded by a blank line.

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
- `points=n` displays the number of points that the question is worth at the beginning of the problem.
- `columns=n`: typesets any subproblems of this problem in a grid with n columns.
- `bonus`/`exciting`/`surprising`/`play`/`stop`/`discuss`/`calculator`: displays a little picture to the left of the problem number, to communicate in some way with the student.  This picture is, respectively: a star, a pair of exclamation marks, an interrobang, a beach ball, a stop sign, a pair of speech bubbles, and an array of arithmetic operations.  I'd love to add more, or give them more helpful names, if it would be helpful to you.

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
  - `\sheetnumber`
  - `\title`
  - `\studentname`
  - `\school`, which defaults to `Proof School`, and so will generally not be needed.  But hey, maybe you teach elsewhere as well?
  
  I would suggest making a file named `CourseInfo.tex`, and then `\input`ing it in the preamble of every handout.  It would contain the first four (for math classes) or three (for morning classes) of these commands, which would be common to all handouts for a given class.  You can also include any custom macros or other definitions that you want for this class, and all of your handouts will automatically see them!
  
- A heading is automatically placed at the top of the first page (unless the `notitle` option is given to the document class).  There are a few that are pre-defined, and you can fairly easily make your own!

  - You can use `\renewcommand{\FirstPageHeader}{[...]}` to use a different header.  This is *also* the sort of thing that I'd recommend putting in `CourseInfo.tex`.

  - So far, the predefined headers are

    - `\headerZG` (default)
    - `\headerZGpic`, which takes one mandatory argument.  This argument should produce an image (perhaps an `\includegraphics`, code for a Ti*k*Z picture, et cetera).
    - `\boxedheader`, which takes 6 mandatory arguments which populate, respectively, upper left corner, upper center, upper right corner, lower left corner, lower center, and lower right corner.  The center is always the title of the handout.
    - `\tcboxedheader`, which has the same interface as `\boxedheader` but a slightly more fun appearance (rounded corners, box extends slightly into the margin).

  - You may `\renewcommand` any of the following to customize the look of your heading:
    - `\SheetNumberPrefix`: text prepended to the `\SheetNumber`, if it exists. By default, this is `\S`, but maybe you'd like `Handout~` or similar.
    - `\SheetNumberPostfix`: test that is appended to the `\SheetNumber`, it if exists, to separate it from the `\Title`.  By default, this is just a space, but maybe you'd want a colon or some such
    - `\NameText`: the text prepended to the line where students will write their name.  By default, `Name:`.
    - `\NameLineWidth`: is the length of the line where they'd write their name.  If there is a date line, it is likely of the same length.  This is a length, so you should set it with `\setlength`, not `\renewcommand`.
    - `\TitleFont`: the font used for the `\Title` of the handout.  By default, `\large\bfseries\boldmath`
    - `\SchoolNameFont`: the font used for the school name.  By default, `\scshape`.
    - `\CourseNameFont`: the font used for the `\CourseName`.  By default, `\large`.

  - If you define your own custom header, the following macros are available to you:

    - `\CourseName`
    - `\InstructorName`
    - `\SchoolName`
    - `\SchoolYear`
    - `\Block`
    - `\UnitName`
    - `\UnitNumber`
    - `\WeekNumber`
    - `\SheetNumber`
    - `\Title`
    - `\FancyTitle`, which contains the title, prepended with the unit number and sheet number (if present)
    - `NameLine`
    

- If you have a header that you like, let me know and we can make sure that it is implemented and easily choose-able!

### Odds and Ends

- `\blank`, `\blank*`: the mandatory argument is the length of the blank, the optional argument is typeset if solutions are displayed.  Normally that solution is `\smash`ed so that the blank will have same vertical position whether or not solutions are displayed (even if the solution is tall, or has descenders); the starred variant does not `\smash` the solution, which is useful sometimes!
- `\smartoverline`: I think that `\overline`s look bad for some letters, because it is computed based on the bounding box and so can extend far from the top of the letter.  This tries to fix that by starting the overline a little further to the left than in normally would be (based on what the first letter is).
- `\spoilerbreak`: displays the message: "*Spoilers ahead! Proceed with caution...*" in the bottom left corner of the page, then inserts a page break.  An optional argument lets you use a different message.  You can also `\renewcommand` the following:
  - `\SpoilerFont`: the font used, by default `\itshape`.
  - `\DefaultSpoilerText`: the default text used.  By default, as stated above, `Spoilers ahead! Proceed with caution\ldots`.
- Fancy theorems!  Puts your theorems and definitions and such in fancy boxes!  Currently the following are defined, but you can make more if you want.
  - `theorem`/`theorem*`
  - `lemma`/`lemma*`
  - `corollary`/`corollary*`
  - `claim`/`claim*`
  - `conjecture`/`conjecture*`
  - `proposition`/`proposition*`
  - `definition`/`definition*`
  - `example`/`example*`
- `\squircle` makes a small squircle!  The qed symbol at the end of a proof has been replaced by a squircle.
- `\ifsoln` typesets its mandatory argument if solutions are displayed, and its optional argument otherwise.

