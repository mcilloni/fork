Checks the parser integrity:

  $ $TESTDIR/../examples/ex sexample $TESTDIR/../examples/sexample.fork
  Root: (at 15:2-34:6)
  Imports: 
      ast (at 10:2-10)
      synt (at 11:12-11)
      base (at 12:13-11)
      utils (at 13:13-12)
  
      Entry: (at 15:2-34:6)
          _fork_entry :: func()
          Block: (at 16:3-33:21)
              Mut: (at 16:3-24)
                  argv :: <inferred>
                  Expression: (at 16:23-24): a function call
                      Expression: (at 16:14-22): :
                          Expression: (at 16:14-17): an id - "base"
                          Expression: (at 16:19-22): an id - "args"
              If: (at 17:3-20:5)
                  Expression: (at 17:6-18): !=
                      Expression: (at 17:6-13): '
                          Expression: (at 17:6-9): an id - "argv"
                          Expression: (at 17:11-13): an id - "len"
                      Expression: (at 17:18-18): 1
                  Block: (at 18:15-19:16)
                      Expression: (at 18:15-56): a function call
                          Expression: (at 18:5-14): :
                              Expression: (at 18:5-8): an id - "base"
                              Expression: (at 18:10-14): an id - "errln"
                          Expression: (at 18:16-55): a string - "Wrong number of arguments, required: 1"
                      Expression: (at 19:14-16): a function call
                          Expression: (at 19:5-13): :
                              Expression: (at 19:5-8): an id - "base"
                              Expression: (at 19:10-13): an id - "exit"
                          Expression: (at 19:15-15): 1
              Mut: (at 22:3-40)
                  prs :: <inferred>
                  Expression: (at 22:27-40): a function call
                      Expression: (at 22:13-26): :
                          Expression: (at 22:13-16): an id - "synt"
                          Expression: (at 22:18-26): an id - "parserNew"
                      Expression: (at 22:28-38): an array access
                          Expression: (at 22:28-36): '
                              Expression: (at 22:28-31): an id - "argv"
                              Expression: (at 22:33-36): an id - "args"
                          Expression: (at 22:38-38): 0
              Mut: (at 23:3-34)
                  root :: <inferred>
                  Expression: (at 23:30-34): a function call
                      Expression: (at 23:14-29): :
                          Expression: (at 23:14-17): an id - "synt"
                          Expression: (at 23:19-29): an id - "parserParse"
                      Expression: (at 23:31-33): an id - "prs"
              If: (at 25:3-28:5)
                  Expression: (at 25:6-20): !=
                      Expression: (at 25:6-12): '
                          Expression: (at 25:6-8): an id - "prs"
                          Expression: (at 25:10-12): an id - "err"
                      Expression: (at 25:17-20): null
                  Block: (at 26:24-27:16)
                      Expression: (at 26:24-46): a function call
                          Expression: (at 26:5-23): :
                              Expression: (at 26:5-9): an id - "utils"
                              Expression: (at 26:11-23): an id - "issueWriteOut"
                          Expression: (at 26:25-31): '
                              Expression: (at 26:25-27): an id - "prs"
                              Expression: (at 26:29-31): an id - "err"
                          Expression: (at 26:34-45): ptr
                              Expression: (at 26:38-45): :
                                  Expression: (at 26:38-41): an id - "base"
                                  Expression: (at 26:43-45): an id - "err"
                      Expression: (at 27:14-16): a function call
                          Expression: (at 27:5-13): :
                              Expression: (at 27:5-8): an id - "base"
                              Expression: (at 27:10-13): an id - "exit"
                          Expression: (at 27:15-15): 1
              Expression: (at 30:16-21): a function call
                  Expression: (at 30:3-15): :
                      Expression: (at 30:3-5): an id - "ast"
                      Expression: (at 30:7-15): an id - "pnodeDump"
                  Expression: (at 30:17-20): an id - "root"
              Expression: (at 32:18-22): a function call
                  Expression: (at 32:3-17): :
                      Expression: (at 32:3-6): an id - "synt"
                      Expression: (at 32:8-17): an id - "parserFree"
                  Expression: (at 32:19-21): an id - "prs"
              Expression: (at 33:16-21): a function call
                  Expression: (at 33:3-15): :
                      Expression: (at 33:3-5): an id - "ast"
                      Expression: (at 33:7-15): an id - "pnodeFree"
                  Expression: (at 33:17-20): an id - "root"

