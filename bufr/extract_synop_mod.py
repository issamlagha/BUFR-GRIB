from eccodes import *
import os
from datetime import datetime, timedelta
import numpy as np

# CHECK THE COORDINATES
def readbufr(infile):
    # Define geographic domain coordinates
    Lat1 = 15.689622261471236  # Minimum latitude
    Lat2 = 46.535017497758439  # Maximum latitude
    Lon1 = -12.620693691  # Minimum longitude
    Lon2 = 25.747464342519287  # Maximum longitude

    with open(infile, 'rb') as f, open("station-6h.txt", "a") as outfile:
        while True:
            bufr = codes_bufr_new_from_file(f)
            if bufr is None:
                break
            codes_set(bufr, 'unpack', 1)
            try:
                # Use codes_get or codes_get_array based on the data type
                StatNum = codes_get(bufr, 'stationOrSiteName')
                lat = codes_get_array(bufr, 'latitude')
                lon = codes_get_array(bufr, 'longitude')
                alt = codes_get_array(bufr, 'heightOfStationGroundAboveMeanSeaLevel')
                time = codes_get(bufr, 'timePeriod')
                day = codes_get(bufr, 'typicalDate')
                hour = codes_get(bufr, 'typicalTime')
                value = codes_get_array(bufr, 'airTemperature')

                for i in range(lat.shape[0]):
                    if (lat[i] > Lat1) and (lat[i] < Lat2) and (lon[i] > Lon1) and (lon[i] < Lon2):
                        line = f"{StatNum}  {lat[i]}  {lon[i]}  {alt[i]}  {time}  {day}  {hour}  {value[i]}\n"
                        outfile.write(line)
            except KeyError as e:
                print(f"Invalid Bufr file structure Key/value not found: {e}")
            except Exception as e:
                print(f"Invalid Bufr file structure: {e}")
            finally:
                codes_release(bufr)

# Directory containing BUFR files
repertoire = '/home/lagha/data/bufr/synop'

# Start date (first of the month at 00:00:00)
date_debut = datetime(2024, 5, 29, 6, 0)

# End date (fifteen of the month at 23:00:00)
date_fin = datetime(2024, 5, 29, 6, 0)

# Time step (6 hours)
pas_temps = timedelta(hours=6)

# Loop over the specified dates and times
date_actuelle = date_debut

while date_actuelle <= date_fin:
    # BUFR file name for the current date and time
    nom_fichier = date_actuelle.strftime('synop_%Y%m%d%H00.bufr')
    sous_chemin = date_actuelle.strftime('%d/%H')
    chemin_fichier = os.path.join(repertoire, sous_chemin, nom_fichier)
    print(chemin_fichier)

    # Check if the file exists
    if os.path.exists(chemin_fichier):
        readbufr(chemin_fichier)

    # Move to the next date and time
    date_actuelle += pas_temps

