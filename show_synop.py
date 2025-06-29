import pandas as pd
import pdbufr
import glob

file_path="/bufr/synop_*.bufr"
#folder_paths = ["alg", "fra", "lyb","mar","tun","por","spa"]  
file_list = glob.glob(file_path)

dfs = []

for file in file_list:

    df = pdbufr.read_bufr(file, columns=("stationOrSiteName","stationNumber",
                                              "year", "month", "day", "hour",
                                              "latitude", "longitude","heightOfStationGroundAboveMeanSeaLevel",
                                              "airTemperature"))
    df.rename(columns={"stationOrSiteName":"station", "stationNumber":"indicatif OMM",
                       "latitude":"lat", "longitude":"lon",
                       "heightOfStationGroundAboveMeanSeaLevel":"altitude (m)",
                       "airTemperature":"T2m"}, inplace=True)
    
    #df.sort_values("station")
    #df.dropna(subset=["altitude (m)"])
    dfs.append(df)

result = pd.concat(dfs, axis=0)
result.to_csv('output.csv', index=True)

