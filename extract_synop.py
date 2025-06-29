#import eccodes as ecc
from eccodes import * 

import os

from datetime import datetime, timedelta

# CHECK THE COORDINATES
def readbufr( infile ):
# Définir les coordonnées du domaine géographique

    Lat1 = 15.689622261471236  # Latitude minimale

    Lat2 = 46.535017497758439  # Latitude maximale

    Lon1 = -12,620693691 # Longitude minimale

    Lon2 = 25.747464342519287  # Longitude maximale

    f = open(infile  , 'rb')
    outfile=open("station-6h.txt", "a")
     
    cn=0 
    while 1:
        bufr = codes_bufr_new_from_file(f)
        if bufr is None:
            break
        codes_set(bufr, 'unpack', 1)
#    BlockNum = codes_get_long(bufr, 'blockNumber')
        StatNum  = codes_get_array (bufr, 'stationOrSiteName')
    #try:
        lat = codes_get_array (bufr , 'latitude')
        lon = codes_get_array (bufr , 'longitude' )
        alt = codes_get_array (bufr , 'heightOfStationGroundAboveMeanSeaLevel' )
        time = codes_get (bufr , 'timePeriod' )
        day = codes_get(bufr , 'typicalDate' )
        hour = codes_get(bufr , 'typicalTime' )
        value = codes_get_array (bufr , 'airTemperature')
    #print( lat )  
    #print(lon)
#     print(BlockNum)
    #print(StatNum)
        
        for i in range(lat.shape[0]):
            if  lat[i] > Lat1 and lat[i] < Lat2 and lon[i] > Lon1 and lon[i] < Lon2:
                #print ( StatNum[i], lat[i]  , lon[i], alt[i], time, 0.0, 0.0, 0.0)
               # Nom du fichier dans lequel vous voulez écrire la liste de stations

               # Ouvrir le fichier en mode écriture
                #line=str(StatNum[i])+"  "+ str(lat[i])+"  "+ str(lon[i])+"  "+ str(alt[i])+"  "+str(time)+ "0.0  0.0  0.0"+'\n'
                #outfile.write(line)
                line=str(StatNum[i])+"  "+ str(lat[i])+"  "+ str(lon[i])+"  "+ str(alt[i])+"  "+str(time)+"  "+str(day)+"  "+str(hour)+"  "+str(value[i])+'\n'

                outfile.write(line)
               #break 
#           else:
#               continue 
#    except:
    #    Exception 
#        print( "Invalide Bufr file structure")
#       return 1
        cn=cn+1 
        codes_release(bufr)
    f.close ()



# Répertoire contenant les fichiers BUFR

repertoire = '/home/lagha/data/bufr/synop'



# Date de début (premier du mois à 00:00:00)

date_debut = datetime(2024, 5, 29, 6, 0)



# Date de fin (quinze du mois à 23:00:00)

date_fin = datetime(2024, 5, 29, 6, 0)



# Pas de temps (1 heures)

pas_temps = timedelta(hours=6)



# Boucler sur les dates et heures spécifiées

date_actuelle = date_debut

while date_actuelle <= date_fin:

    # Nom du fichier BUFR pour la date et l'heure actuelles
#gpssol_202305010000.bufr
#    datefile = date_actuelle.strftime('gpssol_%Y%m%d00.bufr')
#    nom_fichier = date_actuelle.strftime('%Y%m%d%H.bufr')
    nom_fichier = date_actuelle.strftime('synop_%Y%m%d%H00.bufr')
    sous_chemin = date_actuelle.strftime('%d/%H')
    chemin_fichier = os.path.join(repertoire, sous_chemin, nom_fichier)
#    print(nom_fichier)
 #   print(sous_chemin)
    print(chemin_fichier)


    # Vérifier si le fichier existe

    if os.path.exists(chemin_fichier):
       readbufr(chemin_fichier)
        # Ouvrir le fichier BUFR en mode lecture

#        with ecc.File(chemin_fichier) as bufr_file:
      
            # Créer un fichier de sortie pour la date et l'heure actuelles

#            nom_fichier_sortie = date_actuelle.strftime('%Y%m%d%H_stations.bufr')

#            chemin_fichier_sortie = os.path.join(repertoire, nom_fichier_sortie)






    # Passer à la prochaine date et heure

    date_actuelle += pas_temps
