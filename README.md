libfork
=======

A simple implementation of basic routines, data structures and a full parser for the Fork
Language.

This is incredibly alpha, so it may crash in unpredictable ways.

Everything is available under the MPL v2 license.

# Building
libfork's main usage is (by now) in [ctrans](http://github.com/forklang/ctrans), a transpiler from Fork to C that uses libfork's parser module to parse and then transpile Fork sources.

Libfork needs ctrans to compile, and they are generally developed in sync.
Use a current build of ctrans to build libfork, or otherwise get it from an official build (see ctrans releases for more informations).
