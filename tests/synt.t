Checks the parser integrity:

  $ $TESTDIR/../examples/ex sexample $TESTDIR/../examples/sexample.fork
  Root: (at 16:2-35:6)
  Imports: 
      ast (at 10:2-10)
      base (at 11:12-11)
      synt (at 12:13-11)
      tty (at 13:13-10)
      utils (at 14:12-12)
  
      Entry: (at 16:2-35:6)
          _fork_entry :: func()
          Block: (at 17:3-34:21)
              Mut: (at 17:3-24)
                  argv :: <inferred>
                  Expression: (at 17:23-24): a function call
                      Expression: (at 17:14-22): :
                          Expression: (at 17:14-17): an id - "base"
                          Expression: (at 17:19-22): an id - "args"
              If: (at 18:3-21:5)
                  Expression: (at 18:6-18): !=
                      Expression: (at 18:6-13): '
                          Expression: (at 18:6-9): an id - "argv"
                          Expression: (at 18:11-13): an id - "len"
                      Expression: (at 18:18-18): 1
                  Block: (at 19:14-20:16)
                      Expression: (at 19:14-55): a function call
                          Expression: (at 19:5-13): :
                              Expression: (at 19:5-7): an id - "tty"
                              Expression: (at 19:9-13): an id - "errln"
                          Expression: (at 19:15-54): a string - "Wrong number of arguments, required: 1"
                      Expression: (at 20:14-16): a function call
                          Expression: (at 20:5-13): :
                              Expression: (at 20:5-8): an id - "base"
                              Expression: (at 20:10-13): an id - "exit"
                          Expression: (at 20:15-15): 1
              Mut: (at 23:3-40)
                  prs :: <inferred>
                  Expression: (at 23:27-40): a function call
                      Expression: (at 23:13-26): :
                          Expression: (at 23:13-16): an id - "synt"
                          Expression: (at 23:18-26): an id - "parserNew"
                      Expression: (at 23:28-38): an array access
                          Expression: (at 23:28-36): '
                              Expression: (at 23:28-31): an id - "argv"
                              Expression: (at 23:33-36): an id - "args"
                          Expression: (at 23:38-38): 0
              Mut: (at 24:3-34)
                  root :: <inferred>
                  Expression: (at 24:30-34): a function call
                      Expression: (at 24:14-29): :
                          Expression: (at 24:14-17): an id - "synt"
                          Expression: (at 24:19-29): an id - "parserParse"
                      Expression: (at 24:31-33): an id - "prs"
              If: (at 26:3-29:5)
                  Expression: (at 26:6-20): !=
                      Expression: (at 26:6-12): '
                          Expression: (at 26:6-8): an id - "prs"
                          Expression: (at 26:10-12): an id - "err"
                      Expression: (at 26:17-20): null
                  Block: (at 27:24-28:16)
                      Expression: (at 27:24-45): a function call
                          Expression: (at 27:5-23): :
                              Expression: (at 27:5-9): an id - "utils"
                              Expression: (at 27:11-23): an id - "issueWriteOut"
                          Expression: (at 27:25-31): '
                              Expression: (at 27:25-27): an id - "prs"
                              Expression: (at 27:29-31): an id - "err"
                          Expression: (at 27:34-44): ptr
                              Expression: (at 27:38-44): :
                                  Expression: (at 27:38-40): an id - "tty"
                                  Expression: (at 27:42-44): an id - "err"
                      Expression: (at 28:14-16): a function call
                          Expression: (at 28:5-13): :
                              Expression: (at 28:5-8): an id - "base"
                              Expression: (at 28:10-13): an id - "exit"
                          Expression: (at 28:15-15): 1
              Expression: (at 31:16-21): a function call
                  Expression: (at 31:3-15): :
                      Expression: (at 31:3-5): an id - "ast"
                      Expression: (at 31:7-15): an id - "pnodeDump"
                  Expression: (at 31:17-20): an id - "root"
              Expression: (at 33:18-22): a function call
                  Expression: (at 33:3-17): :
                      Expression: (at 33:3-6): an id - "synt"
                      Expression: (at 33:8-17): an id - "parserFree"
                  Expression: (at 33:19-21): an id - "prs"
              Expression: (at 34:16-21): a function call
                  Expression: (at 34:3-15): :
                      Expression: (at 34:3-5): an id - "ast"
                      Expression: (at 34:7-15): an id - "pnodeFree"
                  Expression: (at 34:17-20): an id - "root"

