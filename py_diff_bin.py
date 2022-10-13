from glob import glob
import sys
import os.path
import os

DEBU = False
#DEBU = True

TAB = '\t'
ORGADR = 24576
CHECKFROM = 24576
CHECKTO   = 65535

if len(sys.argv) < 3:
    files = ("original/mask_3_6000-FFFF.mem",
             "recompile/mask_3_loaded.bin", )
else:
    files = (sys.argv[1], sys.argv[2], )

#-------------------------------------------------------------------------------

fname1 = files[0].replace('\\', '\\\\')
fname2 = files[1].replace('\\', '\\\\')


print('\n')
print('Orig: "%s"' % fname1)
print('New: "%s"' % fname2)
print('\n')

dump = []

for f in files:
    #print f
    dump.append(open(f, "rb").read())

fsize = len(dump[0])
fcount = len(files)


if DEBU == True:
    for f in range(0, fcount):
        print("file " + str(f+1) + " size: " + str(len(dump[f])))

found = 0

info = "no info set"

for i in range(0, fsize):
    if (ORGADR + i >= CHECKFROM) and (ORGADR + i <= CHECKTO):

        info = "%4X " % (ORGADR + i)

        for f in range(1, fcount):

            for x in range(0, len(files)):
                if sys.version_info[0] < 3:
                    info = "%s%s%0.2X" % (info, TAB, ord(dump[x][i]))
                else:
                    info = "%s%s%0.2X" % (info, TAB, dump[x][i])

            s10 = "%5d" % (ORGADR + i)
            s16 = "%4X" % (ORGADR + i)

            for x in range(0, len(files)):
                if sys.version_info[0] < 3:
                    s10 = "%s%s%3d" % (s10, TAB, ord(dump[x][i]))
                    s16 = "%s%s%0.2X" % (s16, TAB, ord(dump[x][i]))
                else:
                    s10 = "%s%s%3d" % (s10, TAB, dump[x][i])
                    s16 = "%s%s%0.2X" % (s16, TAB, dump[x][i])

            if dump[f-1][i] != dump[f][i]:
                if DEBU:
                    info = "%s: difference" % info
                    print(info)

                #print s16 + TAB + TAB + s10
                print(s16)

                found = found + 1
                break
            else:
                if DEBU:
                    info = "%s: ok" % info
                    print(info)


if found == 0:
    print("\nNO vital diffs found")
else:
    print("\nFound %d diffs" % found)