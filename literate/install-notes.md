
# Quick CoffeeScript Install

## Mac OS X

Download and run the node installer from:

    http://nodejs.org/dist/v0.6.2/node-v0.6.2.pkg

Download and unpack CoffeeScript from

    http://github.com/jashkenas/coffee-script/tarball/1.1.3

Then in the unpacked directory run in Terminal:

    sudo ./bin/cake install


## Windows XP & 7

Download and run the node installer from:

    http://nodejs.org/dist/v0.6.2/node-v0.6.2.msi

Download and unpack CoffeeScript from

    http://github.com/jashkenas/coffee-script/zipball/1.1.3

Create a file in the `bin` directory named `coffee.cmd` and insert:

    @node "%COFFEE_PATH%bin\coffee" %*

Rename the directory to for example `coffeescript` and move it to `C:\Program Files`

Add an environment variable:

    SET COFFEE_PATH = C:\Program Files\coffeescript\

Insert `%COFFEE_PATH%bin` into your `PATH`:

    SET PATH = %PATH%;%COFFEE_PATH%bin;

You can add `COFFEE_PATH` and modify your `PATH` in:
Control panel, System, Advanced System Settings (only on Windows 7), Advanced tab, Environment Variables.

![Windows path screenshots](WindowsPath.png)\ 


## Test of the setup

Open a command line terminal and run:

    node --version
    #    v0.6.2
    
    coffee --version
    #    CoffeeScript version 1.1.3
    
    coffee -e "console.log 'Hello World'"
    #    Hello World

If not then you need to go back to the installation steps
and verify that you got everything set up according to the
descriptions on the node.js and CoffeeScript web sites:

    https://github.com/joyent/node/wiki/Installation
    http://jashkenas.github.com/coffee-script/#installation


## Optional Smooth CoffeeScript

To install [Smooth CoffeeScript](http://autotelicum.github.com/Smooth-CoffeeScript),
download and unpack the latest archive from

    https://github.com/autotelicum/Smooth-CoffeeScript/archives/master

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
Copyright autotelicum © 2554/2011 ![License CCBYNCSA](ccbyncsa.png)


<!-- Commands used to format this document:

Edit ,>markdown2pdf --listings --xetex '--template=pandoc-template.tex' -o install-notes.pdf; open install-notes.pdf

Edit ,>pandoc -f markdown -t html -S --css pandoc-template.css --template pandoc-template.html -B readability-embed.js -o install-notes.html; open install-notes.html
-->
