Checks lex functionality.

  $ $TESTDIR/../examples/ex lexample $TESTDIR/../examples/sexample.fork
  import
  an identifier: ast
  a newline
  import
  an identifier: proc
  a newline
  import
  an identifier: synt
  a newline
  import
  an identifier: tty
  a newline
  import
  an identifier: utils
  a newline
  entry
  a newline
  mut
  an identifier: argv
  =
  an identifier: proc
  :
  an identifier: args
  (
  )
  a newline
  if
  an identifier: argv
  '
  an identifier: len
  !=
  a number: 1
  a newline
  an identifier: tty
  :
  an identifier: errln
  (
  a string: Wrong number of arguments, required: 1
  )
  a newline
  an identifier: proc
  :
  an identifier: exit
  (
  a number: 1
  )
  a newline
  /if
  a newline
  mut
  an identifier: prs
  =
  an identifier: synt
  :
  an identifier: parserNew
  (
  an identifier: argv
  '
  an identifier: args
  [
  a number: 0
  ]
  )
  a newline
  mut
  an identifier: root
  =
  an identifier: synt
  :
  an identifier: parserParse
  (
  an identifier: prs
  )
  a newline
  if
  an identifier: prs
  '
  an identifier: err
  !=
  null
  a newline
  an identifier: utils
  :
  an identifier: issueWriteOut
  (
  an identifier: prs
  '
  an identifier: err
  ,
  ptr
  an identifier: tty
  :
  an identifier: err
  )
  a newline
  an identifier: proc
  :
  an identifier: exit
  (
  a number: 1
  )
  a newline
  /if
  a newline
  an identifier: ast
  :
  an identifier: pnodeDump
  (
  an identifier: root
  )
  a newline
  an identifier: synt
  :
  an identifier: parserFree
  (
  an identifier: prs
  )
  a newline
  an identifier: ast
  :
  an identifier: pnodeFree
  (
  an identifier: root
  )
  a newline
  /entry
