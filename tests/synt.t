Checks the parser integrity:

  $ $TESTDIR/../examples/ex sexample $TESTDIR/../examples/sexample.fork
  Root: (at 19:2-35:6)
  Imports: 
      ast (at 11:2-10)
      parser (at 12:12-13)
      proc (at 13:15-11)
      synt (at 14:13-11)
      tty (at 15:13-10)
      utils (at 16:12-12)
  
      Entry: (at 19:2-35:6)
          _fork_entry :: func()
          Block: (at 20:3-34:17)
              Mut: (at 20:3-24)
                  argv :: <inferred>
                  Expression: (at 20:23-24): a function call
                      Expression: (at 20:14-22): :
                          Expression: (at 20:14-17): an id - "proc"
                          Expression: (at 20:19-22): an id - "args"
              If: (at 21:3-24:5)
                  Expression: (at 21:6-18): !=
                      Expression: (at 21:6-13): '
                          Expression: (at 21:6-9): an id - "argv"
                          Expression: (at 21:11-13): an id - "len"
                      Expression: (at 21:18-18): 1
                  Block: (at 22:14-23:16)
                      Expression: (at 22:14-55): a function call
                          Expression: (at 22:5-13): :
                              Expression: (at 22:5-7): an id - "tty"
                              Expression: (at 22:9-13): an id - "errln"
                          Expression: (at 22:15-54): a string - "Wrong number of arguments, required: 1"
                      Expression: (at 23:14-16): a function call
                          Expression: (at 23:5-13): :
                              Expression: (at 23:5-8): an id - "proc"
                              Expression: (at 23:10-13): an id - "exit"
                          Expression: (at 23:15-15): 1
              Mut: (at 26:3-36)
                  res :: <inferred>
                  Expression: (at 26:23-36): a function call
                      Expression: (at 26:13-22): :
                          Expression: (at 26:13-16): an id - "synt"
                          Expression: (at 26:18-22): an id - "parse"
                      Expression: (at 26:24-34): an array access
                          Expression: (at 26:24-32): '
                              Expression: (at 26:24-27): an id - "argv"
                              Expression: (at 26:29-32): an id - "args"
                          Expression: (at 26:34-34): 0
              If: (at 28:3-31:5)
                  Expression: (at 28:6-13): ?
                      Expression: (at 28:6-12): '
                          Expression: (at 28:6-8): an id - "res"
                          Expression: (at 28:10-12): an id - "err"
                  Block: (at 29:25-30:16)
                      Expression: (at 29:25-46): a function call
                          Expression: (at 29:5-24): :
                              Expression: (at 29:5-10): an id - "parser"
                              Expression: (at 29:12-24): an id - "issueWriteOut"
                          Expression: (at 29:26-32): '
                              Expression: (at 29:26-28): an id - "res"
                              Expression: (at 29:30-32): an id - "err"
                          Expression: (at 29:35-45): ptr
                              Expression: (at 29:39-45): :
                                  Expression: (at 29:39-41): an id - "tty"
                                  Expression: (at 29:43-45): an id - "err"
                      Expression: (at 30:14-16): a function call
                          Expression: (at 30:5-13): :
                              Expression: (at 30:5-8): an id - "proc"
                              Expression: (at 30:10-13): an id - "exit"
                          Expression: (at 30:15-15): 1
              Expression: (at 33:16-17): a function call
                  Expression: (at 33:3-15): .
                      Expression: (at 33:3-10): '
                          Expression: (at 33:3-5): an id - "res"
                          Expression: (at 33:7-10): an id - "file"
                      Expression: (at 33:12-15): an id - "dump"
              Expression: (at 34:16-17): a function call
                  Expression: (at 34:3-15): .
                      Expression: (at 34:3-10): '
                          Expression: (at 34:3-5): an id - "res"
                          Expression: (at 34:7-10): an id - "file"
                      Expression: (at 34:12-15): an id - "dump"
  Root: (at 19:2-35:6)
  Imports: 
      ast (at 11:2-10)
      parser (at 12:12-13)
      proc (at 13:15-11)
      synt (at 14:13-11)
      tty (at 15:13-10)
      utils (at 16:12-12)
  
      Entry: (at 19:2-35:6)
          _fork_entry :: func()
          Block: (at 20:3-34:17)
              Mut: (at 20:3-24)
                  argv :: <inferred>
                  Expression: (at 20:23-24): a function call
                      Expression: (at 20:14-22): :
                          Expression: (at 20:14-17): an id - "proc"
                          Expression: (at 20:19-22): an id - "args"
              If: (at 21:3-24:5)
                  Expression: (at 21:6-18): !=
                      Expression: (at 21:6-13): '
                          Expression: (at 21:6-9): an id - "argv"
                          Expression: (at 21:11-13): an id - "len"
                      Expression: (at 21:18-18): 1
                  Block: (at 22:14-23:16)
                      Expression: (at 22:14-55): a function call
                          Expression: (at 22:5-13): :
                              Expression: (at 22:5-7): an id - "tty"
                              Expression: (at 22:9-13): an id - "errln"
                          Expression: (at 22:15-54): a string - "Wrong number of arguments, required: 1"
                      Expression: (at 23:14-16): a function call
                          Expression: (at 23:5-13): :
                              Expression: (at 23:5-8): an id - "proc"
                              Expression: (at 23:10-13): an id - "exit"
                          Expression: (at 23:15-15): 1
              Mut: (at 26:3-36)
                  res :: <inferred>
                  Expression: (at 26:23-36): a function call
                      Expression: (at 26:13-22): :
                          Expression: (at 26:13-16): an id - "synt"
                          Expression: (at 26:18-22): an id - "parse"
                      Expression: (at 26:24-34): an array access
                          Expression: (at 26:24-32): '
                              Expression: (at 26:24-27): an id - "argv"
                              Expression: (at 26:29-32): an id - "args"
                          Expression: (at 26:34-34): 0
              If: (at 28:3-31:5)
                  Expression: (at 28:6-13): ?
                      Expression: (at 28:6-12): '
                          Expression: (at 28:6-8): an id - "res"
                          Expression: (at 28:10-12): an id - "err"
                  Block: (at 29:25-30:16)
                      Expression: (at 29:25-46): a function call
                          Expression: (at 29:5-24): :
                              Expression: (at 29:5-10): an id - "parser"
                              Expression: (at 29:12-24): an id - "issueWriteOut"
                          Expression: (at 29:26-32): '
                              Expression: (at 29:26-28): an id - "res"
                              Expression: (at 29:30-32): an id - "err"
                          Expression: (at 29:35-45): ptr
                              Expression: (at 29:39-45): :
                                  Expression: (at 29:39-41): an id - "tty"
                                  Expression: (at 29:43-45): an id - "err"
                      Expression: (at 30:14-16): a function call
                          Expression: (at 30:5-13): :
                              Expression: (at 30:5-8): an id - "proc"
                              Expression: (at 30:10-13): an id - "exit"
                          Expression: (at 30:15-15): 1
              Expression: (at 33:16-17): a function call
                  Expression: (at 33:3-15): .
                      Expression: (at 33:3-10): '
                          Expression: (at 33:3-5): an id - "res"
                          Expression: (at 33:7-10): an id - "file"
                      Expression: (at 33:12-15): an id - "dump"
              Expression: (at 34:16-17): a function call
                  Expression: (at 34:3-15): .
                      Expression: (at 34:3-10): '
                          Expression: (at 34:3-5): an id - "res"
                          Expression: (at 34:7-10): an id - "file"
                      Expression: (at 34:12-15): an id - "dump"

