fs = require "fs"
show = console.log

String::contains = (pattern) ->
  ///#{pattern}///.test @

leadingWhitespace = (str) ->
  (str.match /(\s*)\w/)[1] ? ""

errorWrapper = (action) ->
  (err, args...) ->
    if err then throw err
    action args...

ifFileExists = (filename, action) ->
  fs.stat filename, errorWrapper (stat) ->
    if stat.isFile() then action()

getFileAsLines = (filename, action) ->
  ifFileExists filename, ->
    fs.readFile filename, "utf8",
      errorWrapper (content) ->
        action content.split "\n"

saveFile = (filename, content) ->
  fs.writeFile filename, content,
    errorWrapper -> show "Saved #{filename}"

stripSolutions = (lines) ->
  out = ""
  inSolution = false
  concat = (str) -> out += str + "\n"
  for line in lines
    if line.contains "'--- Exercise \\d+ ---'"
      inSolution = true
      concat line
      indent = leadingWhitespace line
      concat "#{indent}process.exit()" +
        " # Replace this line with your solution"
    else if inSolution
      if line.contains "'--- End of Exercise ---'"
        concat line
        inSolution = false
      # else ignore line in solution
    else
      concat line
  # Remove trailing newline
  out[...out.length-1]

stripFile = (fromName, toName) ->
  if fromName?
    getFileAsLines fromName, (lines) ->
      saveFile toName, stripSolutions lines
  else
    show "Expected a file name " +
         "to strip for solutions"

copyFile = (fromName, toName) ->
  if fromName?
    ifFileExists fromName, ->
      fs.readFile fromName, "utf8",
        errorWrapper (content) ->
          saveFile toName, content,
  else
    show "Expected a file name to copy"

toDir = "../src-no-solutions"
fs.mkdir toDir, 0777, (err) ->
  if err
    throw err unless err.code is 'EEXIST'
    show "Reusing"
  else
    show "Created"

fromDir = process.argv[2]
if fromDir?
  fs.readdir fromDir, errorWrapper (files) ->
    for filename in files
      if filename.contains "\\w\\w-\\w+.coffee"
        stripFile filename, "#{toDir}/#{filename}"
      else
        copyFile filename, "#{toDir}/#{filename}"
else
  show "Expected a directory with " +
       "solutions to strip"

