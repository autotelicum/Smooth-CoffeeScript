1st edition, 3rd revision

p 6
Changed recommended JavaScript supplement to `JavaScript Basics`.

p 8-9 and 186 / 169
Updated to reflect the larger size and better documentation of CoffeeKup 0.3.1 plus a link to Mark Hahn's Introduction.

p 9
Updated to Quick Install guide and native node installers.

p 10
Added reading recommendation to Foreword:
'To get the most out of the book: Start your text editor and in src-no-solutions open the source code file for the chapter you are reading. If you have a wide-screen display then arrange your windows so the book is on one side and the text editor on the other. Then you can read and run the samples, see the results, experiment with the code and solve the exercises.

If you make copies of the files you work on then you can easily undo experiments. If you get stuck with an exercise then copy my solution from the file in the src directory and study it a bit before moving on. Note that in some of the source files you have to indent your solutions to match the surrounding code.'

p 28 / 27 and 227 / 210
Change to keep in sync with upcoming CoffeeScript REPL change - It will no longer be required to type `this.` in the REPL, simply press TAB to see global definitions.

p 128 / 117
Cleaned up second road object representation in Searching. The last pseudo-code line was failing in CoffeeScript 1.1.3 when curly braces and commas were used.

p 161 / 146 and 211 / 194
Changed two standalone `@` to `this` - Using standalone `@` is discouraged (possibly to be deprecated) since standalone `this` is more readable.

Source code changes
    02-BasicCoffeeScript.coffee:369
    05-ErrorHandling.coffee:124
    07-Searching.coffee:14
    08-ObjectOrientation.coffee:194
    A4-NoSolutions.coffee:5
    prelude/prelude.coffee:263,264
    prelude/coffeekup.coffee -> 0.3.1



1st edition, 2nd revision

Added book cover.

Errata:

p 41 top / 39 top
The description of the existential operator should be:
'It returns true unless something is null or undefined.'



1st edition, 1st revision
Addenda, errata & minutiae:

A1-LanguageExtras.coffee: Additional examples see p 199.

Page numbers refer to the initial editions.
Instructor edition / Challenge edition without solutions.

p 1 / 1
  Added hyperlink to book webpage.

p 2 / 2
  Added revision number to copyright line.

p 10 / 10
  Change/add to last paragraph:
You can run samples with coffee filename.coffee.
  ◦•◦
Smooth CoffeeScript comes in two editions; with and without solutions. Complete by chapter source code files are in the src directory. A copy of all files are in src-no-solutions, these files have stops where you can insert your own solutions.
Both editions and accompanying source files can be downloaded from:
http://autotelicum.github.com/Smooth-CoffeeScript/

p 50 / 47
  Move footnote 13 from the number to the preceding text. It looked like a power rather than a footnote reference.

p 114 / 105
  In Exercise 23 add to last sentence in first paragraph: ', they need type and content properties.'

p 125 / 114
  Change last paragraph to:
In `isDefined` we are defining a new function without naming it. This can be useful when you need to create a simple function to give to, for example, `map` or `reduce`. However, when a function becomes more complex than this example, it is usually shorter and clearer to define it by itself and name it.

p 145 / 132, 2nd line after diagram:
  Change from: 'the end points at the value' to: 'the end points are the values'

p 147
  Remove unnecessary parentheses in the solution's 1st line.

p 156 mid / 141 mid
  Change from: 'base classes.' to 'the base class.'

p 165 / 150
  On sketch correct spelling of 'Abstract' in Account Interface note.

p 173 / 157
  Change from: 'pieces of string' to 'pieces of a string'

p 182 / 165
  Change from: 'defining it as an alias for show' to 'defining show as an alias for it'

p 190 / 173
  Change from: 'one response should never stop' to: 'one request should not stop'

p 195 / 178
  Insert before last paragraph:
First choose what your project is going to be about, then look to [https://github.com/languages/CoffeeScript||github] for supporting code and libraries. A couple of interesting ones for web applications are [https://github.com/mauricemach/zappa||Zappa] and [https://github.com/socketstream/socketstream||SocketStream].

p 199 top / 182 top
  Replace paragraph with:
Unicode can be used in identifiers. Letter forms that are very similar to characters in the western alphabets should be avoided. It can be difficult in internationally shared projects due to different keyboard layouts, but useful in teaching math or in a local language.

p 199 mid / 182 mid
  Expanded samples for the do statement. Added a couple of pages of descriptions of bound functions, destructuring assignment, and for ... when.

p 217 / 200
  In 'Classes, Inheritance, and Super', last line replace: "@attr 'title', type: 'text'" with "@inheritedMethodName()"

