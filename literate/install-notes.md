
# Quick CoffeeScript Install

## CoffeeScript with Node and npm

Node now includes the npm package manager on OS X and Windows.
Choose .pkg on OS X and .msi on Windows and install node from
<http://nodejs.org/dist/v0.6.3/>

Open a command line (on Windows 7 right-click and select 'Run as Administrator'):

    npm -g install coffee-script

If you get errors from npm then you may have to manually delete files from previous installations.
See <https://github.com/joyent/node/wiki/Installation>. Test installation with

    node --version
    #    v0.6.3
    
    coffee --version
    #    CoffeeScript version 1.1.3
    
    coffee -e "console.log 'Hello World'"
    #    Hello World

More information at <http://jashkenas.github.com/coffee-script/#installation>


## Optional Smooth CoffeeScript

To install [Smooth CoffeeScript](http://autotelicum.github.com/Smooth-CoffeeScript),
download and unpack the latest master archive from
<https://github.com/autotelicum/Smooth-CoffeeScript/archives/master>

Open a command line terminal, change directory to `Smooth-CoffeeScript/src` then

    coffee 01-Introduction.coffee
    #    Verify that you can see some 55 results.


##Optional Test WebSockets

Open a command line terminal, change directory to `Smooth-CoffeeScript/src` and run:

    coffee 10-TestWebSockets.coffee

Verify that your web browser started and you can see: `RESPONSE: Cowabunga!`
If not then open the file `prelude/prelude.coffee` and see the section `User settings`. 
To stop a web server or other script that does not stop by itself press: `Ctrl-C`.


-----------------------------------------------------------------------------

Formats	[Markdown](install-notes.md)	[PDF](install-notes.pdf)	[HTML](install-notes.html)
Copyright autotelicum © 2554/2011 ![License CCBYSA](ccbysa.png)


<!-- Commands used to format this document:

Edit ,>markdown2pdf --listings --xetex '--template=pandoc-template.tex' -o install-notes.pdf; open install-notes.pdf

Edit ,>pandoc -f markdown -t html -S --css pandoc-template.css --template pandoc-template.html -B readability-embed.js -B menu-embed.js -o install-notes.html; open install-notes.html
-->
