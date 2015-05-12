Checks the parser integrity:

  $ $TESTDIR/../examples/ex sexample $TESTDIR/../examples/sexample.fork
  Root: (at 19:2-38:6)
  Imports: 
      ast (at 11:2-10)
      parser (at 12:12-13)
      proc (at 13:15-11)
      synt (at 14:13-11)
      tty (at 15:13-10)
      utils (at 16:12-12)
  
      Entry: (at 19:2-38:6)
          _fork_entry :: func()
          Block: (at 20:3-37:21)
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
              Mut: (at 26:3-40)
                  prs :: <inferred>
                  Expression: (at 26:27-40): a function call
                      Expression: (at 26:13-26): :
                          Expression: (at 26:13-16): an id - "synt"
                          Expression: (at 26:18-26): an id - "parserNew"
                      Expression: (at 26:28-38): an array access
                          Expression: (at 26:28-36): '
                              Expression: (at 26:28-31): an id - "argv"
                              Expression: (at 26:33-36): an id - "args"
                          Expression: (at 26:38-38): 0
              Mut: (at 27:3-34)
                  root :: <inferred>
                  Expression: (at 27:30-34): a function call
                      Expression: (at 27:14-29): :
                          Expression: (at 27:14-17): an id - "synt"
                          Expression: (at 27:19-29): an id - "parserParse"
                      Expression: (at 27:31-33): an id - "prs"
              If: (at 29:3-32:5)
                  Expression: (at 29:6-20): !=
                      Expression: (at 29:6-12): '
                          Expression: (at 29:6-8): an id - "prs"
                          Expression: (at 29:10-12): an id - "err"
                      Expression: (at 29:17-20): null
                  Block: (at 30:25-31:16)
                      Expression: (at 30:25-46): a function call
                          Expression: (at 30:5-24): :
                              Expression: (at 30:5-10): an id - "parser"
                              Expression: (at 30:12-24): an id - "issueWriteOut"
                          Expression: (at 30:26-32): '
                              Expression: (at 30:26-28): an id - "prs"
                              Expression: (at 30:30-32): an id - "err"
                          Expression: (at 30:35-45): ptr
                              Expression: (at 30:39-45): :
                                  Expression: (at 30:39-41): an id - "tty"
                                  Expression: (at 30:43-45): an id - "err"
                      Expression: (at 31:14-16): a function call
                          Expression: (at 31:5-13): :
                              Expression: (at 31:5-8): an id - "proc"
                              Expression: (at 31:10-13): an id - "exit"
                          Expression: (at 31:15-15): 1
              Expression: (at 34:16-21): a function call
                  Expression: (at 34:3-15): :
                      Expression: (at 34:3-5): an id - "ast"
                      Expression: (at 34:7-15): an id - "pnodeDump"
                  Expression: (at 34:17-20): an id - "root"
              Expression: (at 36:18-22): a function call
                  Expression: (at 36:3-17): :
                      Expression: (at 36:3-6): an id - "synt"
                      Expression: (at 36:8-17): an id - "parserFree"
                  Expression: (at 36:19-21): an id - "prs"
              Expression: (at 37:16-21): a function call
                  Expression: (at 37:3-15): :
                      Expression: (at 37:3-5): an id - "ast"
                      Expression: (at 37:7-15): an id - "pnodeFree"
                  Expression: (at 37:17-20): an id - "root"

