from eccodes import *
import sys

INPUT = sys.argv[1]
mydict = {}

# GTS loop (Check if GTS messages exist)
cnt = 0
with open(INPUT, 'rb') as fin:
    while 1:
        gts = codes_gts_new_from_file(fin)
        if gts is None:
            break
        cnt += 1
        tt = codes_get(gts, 'TT')
        aa = codes_get(gts, 'AA')
        ii = codes_get(gts, 'II')
        mydict[cnt] = {'TT': tt, 'AA': aa, 'II': ii}
        codes_release(gts)

# If mydict is empty, print a warning
if not mydict:
    print("Warning: No GTS messages found in", INPUT)

# BUFR/GRIB loop (Handle missing GTS messages)
cnt = 0
with open(INPUT, 'rb') as fin:
    while 1:
        msgid = codes_grib_new_from_file(fin)
        if msgid is None:
            break
        cnt += 1
        sn = codes_get(msgid, 'shortName')

        # Use GTS values if available, otherwise set to "NA"
        if cnt in mydict:
            idict = mydict[cnt]
            tt = idict['TT']
            aa = idict['AA']
            ii = idict['II']
        else:
            tt, aa, ii = "NA", "NA", "NA"

        print(tt, aa, ii, sn)
        codes_release(msgid)

