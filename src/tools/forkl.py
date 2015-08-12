
import argparse, atexit, os, subprocess, sys

buildpath = os.path.dirname(os.path.abspath(__file__))
forkrtpath = os.path.join(buildpath,'libfork', 'rt.o')

def ld(ccCommand, ofiles, ofile=None):

    if ofile == None:
        if len(ofiles) == 1 and ofiles[0].endswith('.o'):
            ofile = ofiles[0].replace('.o', '', 1)
        else:
            ofile = 'a.out'

    retval = subprocess.call(ccCommand.split() + ofiles + [forkrtpath, '-g', '-L' + os.path.join(buildpath,'libfork'), '-lfork', '-w', '-o', ofile])
    if (retval != 0):
        sys.exit(retval)

def main():
    parser = argparse.ArgumentParser(description="forkl links object files to executables.\n")
    parser.add_argument('files', metavar='FILE', type=str, nargs='+', help='object files to link')
    parser.add_argument('-X', '--cc', default='cc', type=str, help='specifies the C compiler to use. Defaults to "cc"')
    parser.add_argument('-o', '--objname', type=str, help='indicates the alternative name for the executable. Defaults to <file> if only one file is given, a.out otherwise.')
    args = parser.parse_args()

    if args.cc == 'cc':
        if 'CC' in os.environ:
            args.cc = os.environ['CC']

    ld(args.cc, args.files, args.objname)

if __name__ == '__main__':
    main()
