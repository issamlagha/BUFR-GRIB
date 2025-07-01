#!/usr/bin/env python3
 
# (C) Copyright 1996- ECMWF.
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.
#
# In applying this licence, ECMWF does not waive the privileges and immunities
# granted to it by virtue of its status as an intergovernmental organisation
# nor does it submit to any jurisdiction.
 
from eccodes import *
import csv, argparse
 
# read command line to get input filename
def read_cmdline():
    p = argparse.ArgumentParser()
    p.add_argument("--i",help=" input Ascii filename")
    args = p.parse_args()
    return args
 
# read data from CSV file into a list
def csv_read(filename):
    data = []
    try:
        with open(filename) as csvfile:
            reader = csv.reader(csvfile, delimiter='|')
            for row in reader:
                data.append(row)
    except IOError as error:
        print(error)
        sys.exit(1)
    else:
        csvfile.close()
        return data[1:] 
 
# Encode the data from CSV into BUFR
def message_encoding(FileName, fout):
    # reads the CSV file into a python list
    dataIn = csv_read(FileName)
 
    # loops over the rows of the csv file (one BUFR message for each row)
    for row in dataIn:
        bid = codes_bufr_new_from_samples('BUFR4')
        for ele in range(len(row)):
            row[ele] = row[ele].strip()
        try:
            bufr_encode(bid, row)
            codes_write(bid, fout)
        except CodesInternalError as ec:
            print(ec)
        codes_release(bid)
 
def bufr_encode(ibufr, row):
    # set header keys and values
    codes_set(ibufr, 'edition', 4)
    codes_set(ibufr, 'masterTableNumber', 0)
    codes_set(ibufr, 'bufrHeaderCentre', 98)               # 98: centre is ecmf
    codes_set(ibufr, 'bufrHeaderSubCentre', 0)
    codes_set(ibufr, 'updateSequenceNumber', 0)
    codes_set(ibufr, 'dataCategory', 0)                    # 0: Surface data - land
    codes_set(ibufr, 'internationalDataSubCategory', 7)    # 7: n-min obs from AWS stations
    codes_set(ibufr, 'dataSubCategory', 7)
    codes_set(ibufr, 'masterTablesVersionNumber', 31)
    codes_set(ibufr, 'localTablesVersionNumber', 0)
    codes_set(ibufr, 'observedData', 1)
    codes_set(ibufr, 'compressedData', 0)
    codes_set(ibufr, 'typicalYear', int(row[0]))
    codes_set(ibufr, 'typicalMonth', int(row[1]))
    codes_set(ibufr, 'typicalDay', int(row[2]))
    codes_set(ibufr, 'typicalHour', int(row[3]))
    codes_set(ibufr, 'typicalMinute', int(row[4]))
    codes_set(ibufr, 'typicalSecond', 0)
  
    ivalues=(307092)
    codes_set(ibufr, 'unexpandedDescriptors', ivalues)
  
    # set data keys and values
    codes_set(ibufr, 'year', int(row[0]))
    codes_set(ibufr, 'month', int(row[1]))
    codes_set(ibufr, 'day', int(row[2]))
    codes_set(ibufr, 'hour', int(row[3]))
    codes_set(ibufr, 'minute', int(row[4]))
    codes_set(ibufr, 'blockNumber', int(row[5]))
    codes_set(ibufr, 'stationNumber', int(row[6]))
    codes_set(ibufr, 'longStationName',row[7].strip())
    codes_set(ibufr, 'latitude', float(row[8]))
    codes_set(ibufr, 'longitude', float(row[9]))
    codes_set(ibufr, 'heightOfStationGroundAboveMeanSeaLevel', float(row[10]))
    codes_set(ibufr, 'pressure', float(row[11]))
    codes_set(ibufr, 'pressureReducedToMeanSeaLevel', float(row[12]))
    codes_set(ibufr, 'airTemperature', float(row[13]))
    codes_set(ibufr, '#1#relativeHumidity', float(row[14]))
    codes_set(ibufr, '#2#timePeriod', -10)                                           # -10: Period of precipitation observation is 10 minutes
    codes_set(ibufr, 'totalPrecipitationOrTotalWaterEquivalent', float(row[15]))
    codes_set(ibufr, '#1#timeSignificance', 2)                                       # 2: Time averaged
    codes_set(ibufr, '#3#timePeriod', -10)                                           # -10: Period of wind observations is 10 minutes
    codes_set(ibufr, 'windDirection', float(row[16]))
    codes_set(ibufr, 'windSpeed', float(row[17]))
 
    codes_set(ibufr, 'pack', 1)  # Required to encode the keys back in the data section
 
def main():
    cmdLine = read_cmdline()
    inputFilename = cmdLine.i
    print(inputFilename)
    outFilename = str(inputFilename.split('.')[0]+'.bufr')
    fout = open(outFilename, "wb")
    message_encoding(inputFilename, fout)
    fout.close()
    print(" output file {0}".format(outFilename))
      
if __name__ == '__main__':
    main()
