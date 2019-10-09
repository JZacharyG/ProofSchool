# handout.cls

 A document class for typesetting Proof School handouts.

## Usage

### Installation

- For a quick and dirty solution, you can just put `handout.cls` in the same directory as the handout that you are making.  Done!
- texlive (or MacTeX): add `handout.cls` to the local distribution.  If your LaTeX installation is in the default location, move the file to`/usr/local/texlive/texmf-local/tex/latex/ProofSchool`

  You then need to tell LaTeX to update its list of available things by running `sudo texhash` in Terminal
- Overleaf: [This might be helpful](https://www.overleaf.com/learn/latex/Questions/I_have_a_lot_of_.cls,_.sty,_.bst_files,_and_I_want_to_put_them_in_a_folder_to_keep_my_project_uncluttered._But_my_project_is_not_finding_them_to_compile_correctly).

### Document Class Options

To begin, use the document class `handout`.  My typical usage looks like this:
```latex
\documentclass[12pt,twoside,parskip]{handout}
```
or
```latex
\documentclass[12pt,twoside,parskip,solutions]{handout}
```
The following options are recognized:

-  `solutions`/`nosolutions` (default): set whether or not to typeset the solutions to problems.  (It basically just sets `\showsolutiontrue`, if you are familiar with TeX's ifs.)
- `spaces` (default)/`nospaces`: whether or not to leave the specified space after problems.  The `nospaces` option is useful for answer keys if you don't care about preserving formatting and for drafting problem sets, when you want to see as many problems at a time as possible.  Honestly, I don't use this all that often. 
- `parskip`/`parindent` (default): parskip loads the parskip library, which I think looks great.
- `name`( default)/`noname`: whether or not to leave a space for the students' names.
- `title` (default)/`notitle`: whether or not to automatically call `\maketitle` at the start of the document, which typesets the heading for the first page
- Anything that you can do for the `article` document class.  Notably,
  - `10pt`/`11pt`/`12pt`
  - `oneside`/`twoside`

### Problem Environment

You can add problem using the `prob` environment:

``` latex
\begin{prob}
    What shall we do with a drunken sailor?
    \solution
    Shave his belly with a rusty razor.
\end{prob}
```

- You can add parts/subproblems by nesting these environments.  They can be nested up to three levels deep.  The first level is labeled with Arabic numerals, the second with lowercase letters, the third with lowercase roman numerals.
- `space`/`nospace` will determine how much space is left after a problem.  `space` can be passed a length (e.g., `space=2in`), which will leave that much space below the problem for students to write their solution, or it may be passed a number (e.g., `space=2`), which will fill the available space on the page, in proportion to the numbers given (so if one problem is given `space=1` and another `space=2`, then the latter will be given twice as much space as the former).  `space` is equivalent to `space=1`, `nospace` is equivalent to `space=0pt`, and if neither is present, then a sensible default is used (equivalent to `nospace` if this problem contains subparts and `space` if not).
- `points=n` displays the number of points that the question is worth at the beginning of the problem.
- `\solution` and `\solution*`: If this appears inside a problem environment, then everything that follows will only by typeset if solutions are shown (with the option `solutions`).

  Importantly, the solution is placed in the space below the problem, but it does not add any additional space, so the layout of the handout will be otherwise identical whether or not you include solutions.  This means that the solution can spill over into the next problem, or off the end of the page, if you are not careful.  The starred version instead has the solution replace the space that would otherwise have been left.

  If typeset, the solution will be prepended with the contents of `\solutiontitle`, which defaults to ''**SOLUTION:**", but you can renew this command if you'd like.

- Problems can be typeset in placed in rows (numbered across the row, instead of down the column).  This can be achieved in two ways:
  - If you give the `columns=n` option to a problem, then its subproblems will be typeset in $n$ columns
  - If at any point you issue the command`\ProbsInColumns{n}`, then any following problems will be typeset in $n$ columns. `\ProbsNotInColumns` is equivalent to `\ProbsInColumns{0}`, and typesets subsequent problems in the usual way.
  
    This command is useful (compared to the option to the `prob` environment) if you want to change the number of columns at any point, or if you want to use columns for the top level of problems instead of just for subproblems.
  - Be forewarned: the space given to each problem stacks with the space from the other problems in that row, which can lead to some unexpected results!
  - I worked really hard to make these easy to use, so I hope you like 'em!
  
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
  - `\sheetnumber`
  - `\title`
  
  I would suggest making a file named `CourseInfo.tex`, and then `input`ing it in the preamble of every handout.  It would contain the first four (for math classes) or three (for morning classes) of these commands, which would be common to all handouts for a given class.  You can also include any custom macros or other definitions that you want for this class, and all of your handouts will automatically see them!
  
- You can customize the heading placed at the top of the first page, although it isn't quite as easy as I'd like yet.

  - You can use `\renewcommand{\firstpageheader}{[...]}` to use a different header.  This is *also* the sort of thing that I'd recommend putting in `CourseInfo.tex`.

  - The default header is stored in `\headerZG`.

    Currently, the only other predefined header is `\headerZGpic`, which takes one mandatory argument.  This argument should produce an image (perhaps an `\includegraphics`, code for a Ti*k*Z picture, et cetera).

    You can define your own custom header, which should use `\@course`, `\@instructor`, `\@schoolyear`, `\@block`, `\@unit`, `\@unitnumber`, `\@sheetnumber`, and `\@title` to access the information that has been specified for a particular handout.

  - If you have a header that you like, let me know and we can make sure that it is implemented and easily choose-able!

### Odds and Ends

- `\blank`, `\blank*`: the mandatory argument is the length of the blank, the optional argument is typeset if solutions are displayed.  Normally that solution is `\smash`ed so that the blank will have same vertical position whether or not solutions are displayed (even if the solution is tall, or has descenders); the starred variant does not `\smash` the solution, which is useful sometimes!
- `\smartoverline`: I think that overlines look bad for some letters, because it is computed based on the bounding box.  This tries to fix that by starting the overline a little further to the left than in normally would be (based on what the first letter is).
- `\spoilerbreak`: displays the message: "*Spoilers ahead! Proceed with caution...*" in the bottom left corner of the page, then inserts a page break.  An optional argument lets you use a different message.
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

