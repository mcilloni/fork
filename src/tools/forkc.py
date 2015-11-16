
import argparse
import atexit
import os
import os.path
import platform
import signal
import subprocess
import sys
import tempfile

todelete = []


def clean():
    for f in todelete:
        os.remove(f)

atexit.register(clean)

buildpath = os.path.dirname(os.path.abspath(__file__))
forkc1path = os.path.join(buildpath, 'forkc1')


def forkc1(forkfile, libfork = True):

    if not forkfile.endswith('.fork'):
        sys.exit((__file__ +
                 ': error: file {} does not end with .fork or .ford').format(forkfile))

    cname = forkfile.replace('.fork', '.c', 1)

    tmpfile = os.path.join(tempfile.gettempdir(), cname)

    newenv = os.environ.copy()

    newenv['FORDPATHS'] = os.path.dirname(os.path.abspath(forkfile))

    if libfork:
        newenv['FORDPATHS'] += ':' + buildpath + '/libfork/ford/'

    if 'FORDPATHS' in os.environ:
        newenv['FORDPATHS'] += ':' + os.environ['FORDPATHS']

    proc = subprocess.Popen([forkc1path, forkfile],
                            env=newenv, stdout=subprocess.PIPE)
    out, err = proc.communicate()

    if proc.returncode != 0:
        if proc.returncode == -signal.SIGSEGV:
            sys.exit('FATAL COMPILER ERROR: forkc1 segfaulted :(')
        sys.exit(proc.returncode)

    outfile = open(cname, 'wb')
    outfile.write(out)
    outfile.close()

    tfile = open(tmpfile, 'wb')
    tfile.write(out)
    tfile.close()

    return cname


def cc(ccCommand, cfile, ofile=None, libfork=True, includes=[]):

    if not cfile.endswith('.c'):
        sys.exit((__file__
                 + ': error: file {} does not end with .c').format(cfile))

    if ofile is None:
        ofile = cfile.replace('.c', '.o', 1)

    fpic = []
    if platform.machine() in ['x86_64', 'amd64']:
        fpic = ['-fPIC']

    cfiledir = os.path.dirname(os.path.abspath(cfile))
    params = [cfile, '-w', '-g3', '-c', '-std=c99', '-I' + cfiledir, '-o', ofile]

    for include in includes:
        params += ['-I' + include[0]]

    if libfork:
        params += ['-I' + os.path.join(buildpath, 'libfork', 'include')]

    retval = subprocess.call(ccCommand.split()
                             + params
                             + fpic)
    if (retval != 0):
        sys.exit(retval)


def main():
    parser = argparse.ArgumentParser(
        description="forkc compiles .fork files to objects."
        " Use forkl to link them."
        " Set FORDPATHS to specify where to find more modules.\n")
    parser.add_argument('files',
                        metavar='FILE',
                        type=str,
                        nargs='+',
                        help='.fork file to compile')
    parser.add_argument('-C',
                        '--emit-c',
                        action='store_true',
                        help='emits C code into .c files instead of compiling')
    parser.add_argument('-X',
                        '--cc',
                        default='cc',
                        type=str,
                        help='specifies the C compiler to use. '
                             'Defaults to "cc"')
    parser.add_argument('-I',
                        '--include',
                        dest="includes",
                        default=[['/tmp']],
                        type=str,
                        nargs='*',
                        action="append",
                        help='specifies the include directories for C headers. '
                             'Defaults to /tmp and system defaults')
    parser.add_argument('-o',
                        '--objname',
                        type=str,
                        help='indicates the alternative name '
                             'for the object file. '
                             'Defaults to <forkfile>.o')
    parser.add_argument('--no-spring',
                        action='store_false',
                        help='legacy, noop')
    parser.add_argument('--no-libfork',
                        dest='libfork',
                        action='store_false',
                        help='prevents the inclusion of the standard libfork')
    parser.add_argument('--fordpath',
                        action='version',
                        version=buildpath + '/libfork/ford/',
                        help='dumps the FORDPATH for default libfork fords')

    parser.set_defaults(libfork=True)
    args = parser.parse_args()

    if len(args.files) > 1 and args.objname:
        sys.exit(__file__ +
                 ': error: cannot specify -o'
                 ' when generating multiple output files')

    if args.cc == 'cc':
        if 'CC' in os.environ:
            args.cc = os.environ['CC']

    if args.objname:
        cfile = forkc1(args.files[0], args.libfork)
        if not args.emit_c:
            todelete.append(cfile)
            cc(args.cc, cfile, args.objname, args.libfork, args.includes)

    else:
        for f in args.files:
            cfile = forkc1(f, libfork=args.libfork)
            if not args.emit_c:
                todelete.append(cfile)
                cc(args.cc, cfile, libfork=args.libfork, includes=args.includes)

if __name__ == '__main__':
    main()
