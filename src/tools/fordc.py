
import argparse
import atexit
import os
import os.path
import platform
import signal
import subprocess
import sys
import tempfile
import termcolor


buildpath = os.path.dirname(os.path.abspath(__file__))
forkc1path = os.path.join(buildpath, 'forkc1')


def forkc1(fordfile, outdir, libfork):

    if not fordfile.endswith('.ford'):
        sys.exit((__file__ +
                 ': error: file {} does not end with .ford').format(fordfile))

    hname = "ford$${}.h".format(os.path.basename(fordfile).replace('.ford', '', 1))

    if outdir is None:
        outdir = os.path.dirname(fordfile)

    hfile = os.path.join(outdir, hname)

    newenv = os.environ.copy()
    if libfork:
        newenv['FORDPATHS'] = os.environ['FORKROOT'] + '/libfork/build/ford/'

    if 'FORDPATHS' in os.environ:
        newenv['FORDPATHS'] = newenv['FORDPATHS'] \
            + ':' + os.environ['FORDPATHS']

    proc = subprocess.Popen([forkc1path, fordfile],
                            env=newenv, stdout=subprocess.PIPE)
    out, err = proc.communicate()

    if proc.returncode != 0:
        if proc.returncode == -signal.SIGSEGV:
            sys.exit(termcolor.colored('FATAL COMPILER ERROR: ','red', attrs=['bold','blink'])
                    + termcolor.colored("forkc1 segfaulted :(", attrs=['bold']))
        sys.exit(proc.returncode)

    outfile = open(hfile, 'wb')
    outfile.write(out)
    outfile.close()

    return hname


def main():
    parser = argparse.ArgumentParser(
        description="forkd compiles .ford modules to C headers."
        " Use -I flag on forkc to include the directory that includes them."
        " Set FORDPATHS to specify where to find more modules.\n")
    parser.add_argument('files',
                        metavar='FILE',
                        type=str,
                        nargs='+',
                        help='.ford file to compile')
    parser.add_argument('-H',
                        '--includedir',
                        default=None,
                        type=str,
                        help='indicates the path in which the '
                             'header file should be saved. '
                             'Defaults to $PWD.')
    parser.add_argument('--no-libfork',
                        dest='libfork',
                        action='store_false',
                        help='prevents the inclusion of the standard libfork')
    parser.add_argument('--fordpath',
                        action='version',
                        version=os.environ['FORKROOT'] + '/libfork/build/ford/',
                        help='dumps the FORDPATH for default libfork fords')

    parser.set_defaults(libfork=True)
    args = parser.parse_args()

    for f in args.files:
        forkc1(f, outdir=args.includedir, libfork=args.libfork)

if __name__ == '__main__':
    main()
