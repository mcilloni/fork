Checks lex functionality.

  $ $TESTDIR/../examples/ex lexample $TESTDIR/../examples/sexample.fork
  import
  an identifier: ast
  a newline
  import
  an identifier: parser
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
  an identifier: res
  =
  an identifier: synt
  :
  an identifier: parse
  (
  an identifier: argv
  '
  an identifier: args
  [
  a number: 0
  ]
  )
  a newline
  if
  an identifier: res
  '
  an identifier: err
  ?
  a newline
  an identifier: parser
  :
  an identifier: issueWriteOut
  (
  an identifier: res
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
  an identifier: res
  '
  an identifier: file
  .
  an identifier: dump
  (
  )
  a newline
  an identifier: res
  '
  an identifier: file
  .
  an identifier: dump
  (
  )
  a newline
  /entry
