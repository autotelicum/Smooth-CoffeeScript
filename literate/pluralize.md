
# Pluralize --- _[Smooth CoffeeScript](http://autotelicum.github.com/Smooth-CoffeeScript/)_

This literate program is _interactive_ in its HTML form.
Select a code segment to edit it.
The generated code and output is updated as you type.
Source and other document formats are at the end of the document.


**How do you add 's' to a word when there is more than one of something?**

It is often seen in JavaScript with the ternary operator `?:` but that
is hard-coding at the expense of future maintenance and
internationalization.

First some preliminaries. Let's `show` the results whether we are
running in a server or a web client. Something like
`show = if exports? then console.log else alert`.
And wrap the different methods in a `test` function
so we can see if they work.

~~~~ {.coffeescript}
test = (points) ->
~~~~

## Readable ways

The simplest readable way

~~~~ {.coffeescript}
  show "0: You got #{points} point#{if points > 1 then 's' else ''}"
~~~~

Encapsulate in a function, future i18n will be easier

~~~~ {.coffeescript}
  pluralIf = (stem, cond) -> stem + (if cond then 's' else '')
  show "1: You got #{points} #{pluralIf 'point', points > 1}"
~~~~

Encapsulate in a function, handle negative numbers

~~~~ {.coffeescript}
  pluralUnless = (stem, cond) -> stem + (unless cond then 's' else '')
  show "2: You got #{points} #{pluralUnless 'point', -2 < points < 2}"
~~~~

Encapsulate in a String method, could collide with another definition

~~~~ {.coffeescript}
  String::pluralIf ?= (cond) -> this + (if cond then 's' else '')
  show "3: You got #{points} #{'point'.pluralIf points > 1}"
~~~~

## Tricks

Use the existential operator to catch the singular undefined

~~~~ {.coffeescript}
  show "4: You got #{points} point#{('s' if points > 1) ? ''}"
~~~~

Convert the condition to a number and do an array lookup

~~~~ {.coffeescript}
  show "5: You got #{points} point#{['','s'][+(points > 1)]}"
~~~~

Use the inverted condition to ask for a letter.

`true => charAt 1 => ''` --- `false => charAt 0 => 's'`

~~~~ {.coffeescript}
  show "6: You got #{points} point#{'s'.charAt points <= 1}"
~~~~

Create an array whose length is determined by the condition.
It consists of empty elements so join it with 's'

~~~~ {.coffeescript}
  show "7: You got #{points} point#{Array(1+(points>1)).join 's'}"
~~~~

Concatenate to an empty array, undefined does nothing

~~~~ {.coffeescript}
  show "8: You got #{points} point#{[].concat ('s' if points > 1)}"
~~~~

## Contributed

Create an array with either 's' or undefined
--- from [satyr](https://gist.github.com/satyr)

~~~~ {.coffeescript}
  show "9: You got #{points} point#{['s' if points > 1]}"
~~~~

## Test

Run a test for a small range of numbers

~~~~ {.coffeescript}
test n for n in [-3..3]
~~~~

-----------------------------------------------------------------------------

\VerbatimInput[baselinestretch=1,fontsize=\footnotesize,numbers=left]{pluralize.coffee}

## Output

~~~~ {.output}

~~~~

\VerbatimInput[baselinestretch=1,fontsize=\footnotesize,numbers=left]{pluralize.output}

## JavaScript

~~~~ {.js-source}

~~~~

\VerbatimInput[baselinestretch=1,fontsize=\footnotesize,numbers=left]{pluralize.js}

-----------------------------------------------------------------------------

Formats [CoffeeScript](pluralize.coffee)	[Markdown](pluralize.md) [PDF](pluralize.pdf) [HTML](pluralize.html)
--- [autotelicum](http://twitter.com/#!/autotelicum) © 2554/2011 ![License CCBYSA](ccbysa.png)

<!---------------------------------------------------------------------------
Commands used to extract code, execute it, and to format this document:

Edit ,>ssam -n 'x/^~~+[   ]*{\.coffeescript.*}$/+,/^~~+$/-'p
Edit ,>ssam -n 'x/^~~+[   ]*{\.coffeescript.*}$/+,/^~~+$/-' |tee pluralize.coffee | coffee -cs >pluralize.js; echo 'show=console.log' | cat - pluralize.coffee | coffee -s >pluralize.output; plumb pluralize.output
Edit ,>pandoc -f markdown -t html -S --css pandoc-template.css --template pandoc-template.html -B readability-embed.js -B embed.html | ssam 's/(<code class="sourceCode coffeescript")/\1 contenteditable=\"true\"/g' >pluralize.html; open pluralize.html; plumb pluralize.html
Edit ,>markdown2pdf --listings --xetex '--template=pandoc-template.tex' -o pluralize.pdf; open pluralize.pdf

To execute these commands; middle-button select them in the acme environment.
acme and ssam are part of the plan9 OS and can run on *nix variants via plan9port.
The formatting is done with pandoc, a universal markup converter, and TeX.
---------------------------------------------------------------------------->
