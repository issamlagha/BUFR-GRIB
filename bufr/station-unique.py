# Ouvrir le fichier en mode lecture
with open('station-SYNOP.txt', 'r') as fichier:
    # Créer un ensemble pour stocker les stations uniques
    stations = set()
    
    # Boucler sur chaque ligne du fichier
    for ligne in fichier:
        # Supprimer les espaces blancs et les caractères indésirables
        station = ligne.strip()
        
        # Ajouter la station à l'ensemble
        stations.add(station)

# Écrire les stations uniques dans un nouveau fichier
with open('stations_SYNOP_uniques.txt', 'w') as fichier_sortie:
    for station in stations:
        fichier_sortie.write(station + '\n')
