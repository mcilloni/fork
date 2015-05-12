Checks the parser integrity:

  $ $TESTDIR/../examples/ex sexample $TESTDIR/../examples/sexample.fork
  Root: (at 18:2-37:6)
  Imports: 
      ast (at 11:2-10)
      proc (at 12:12-11)
      synt (at 13:13-11)
      tty (at 14:13-10)
      utils (at 15:12-12)
  
      Entry: (at 18:2-37:6)
          _fork_entry :: func()
          Block: (at 19:3-36:21)
              Mut: (at 19:3-24)
                  argv :: <inferred>
                  Expression: (at 19:23-24): a function call
                      Expression: (at 19:14-22): :
                          Expression: (at 19:14-17): an id - "proc"
                          Expression: (at 19:19-22): an id - "args"
              If: (at 20:3-23:5)
                  Expression: (at 20:6-18): !=
                      Expression: (at 20:6-13): '
                          Expression: (at 20:6-9): an id - "argv"
                          Expression: (at 20:11-13): an id - "len"
                      Expression: (at 20:18-18): 1
                  Block: (at 21:14-22:16)
                      Expression: (at 21:14-55): a function call
                          Expression: (at 21:5-13): :
                              Expression: (at 21:5-7): an id - "tty"
                              Expression: (at 21:9-13): an id - "errln"
                          Expression: (at 21:15-54): a string - "Wrong number of arguments, required: 1"
                      Expression: (at 22:14-16): a function call
                          Expression: (at 22:5-13): :
                              Expression: (at 22:5-8): an id - "proc"
                              Expression: (at 22:10-13): an id - "exit"
                          Expression: (at 22:15-15): 1
              Mut: (at 25:3-40)
                  prs :: <inferred>
                  Expression: (at 25:27-40): a function call
                      Expression: (at 25:13-26): :
                          Expression: (at 25:13-16): an id - "synt"
                          Expression: (at 25:18-26): an id - "parserNew"
                      Expression: (at 25:28-38): an array access
                          Expression: (at 25:28-36): '
                              Expression: (at 25:28-31): an id - "argv"
                              Expression: (at 25:33-36): an id - "args"
                          Expression: (at 25:38-38): 0
              Mut: (at 26:3-34)
                  root :: <inferred>
                  Expression: (at 26:30-34): a function call
                      Expression: (at 26:14-29): :
                          Expression: (at 26:14-17): an id - "synt"
                          Expression: (at 26:19-29): an id - "parserParse"
                      Expression: (at 26:31-33): an id - "prs"
              If: (at 28:3-31:5)
                  Expression: (at 28:6-20): !=
                      Expression: (at 28:6-12): '
                          Expression: (at 28:6-8): an id - "prs"
                          Expression: (at 28:10-12): an id - "err"
                      Expression: (at 28:17-20): null
                  Block: (at 29:24-30:16)
                      Expression: (at 29:24-45): a function call
                          Expression: (at 29:5-23): :
                              Expression: (at 29:5-9): an id - "utils"
                              Expression: (at 29:11-23): an id - "issueWriteOut"
                          Expression: (at 29:25-31): '
                              Expression: (at 29:25-27): an id - "prs"
                              Expression: (at 29:29-31): an id - "err"
                          Expression: (at 29:34-44): ptr
                              Expression: (at 29:38-44): :
                                  Expression: (at 29:38-40): an id - "tty"
                                  Expression: (at 29:42-44): an id - "err"
                      Expression: (at 30:14-16): a function call
                          Expression: (at 30:5-13): :
                              Expression: (at 30:5-8): an id - "proc"
                              Expression: (at 30:10-13): an id - "exit"
                          Expression: (at 30:15-15): 1
              Expression: (at 33:16-21): a function call
                  Expression: (at 33:3-15): :
                      Expression: (at 33:3-5): an id - "ast"
                      Expression: (at 33:7-15): an id - "pnodeDump"
                  Expression: (at 33:17-20): an id - "root"
              Expression: (at 35:18-22): a function call
                  Expression: (at 35:3-17): :
                      Expression: (at 35:3-6): an id - "synt"
                      Expression: (at 35:8-17): an id - "parserFree"
                  Expression: (at 35:19-21): an id - "prs"
              Expression: (at 36:16-21): a function call
                  Expression: (at 36:3-15): :
                      Expression: (at 36:3-5): an id - "ast"
                      Expression: (at 36:7-15): an id - "pnodeFree"
                  Expression: (at 36:17-20): an id - "root"

