#!/bin/bash
#---------------------------------------------------------------------------------------------------------------------
#    Objectif  :  Téléchargement des données du SYNOP (BUFR) à partir de la machine 122. 
#    Version   :  PNT/17-Mar-2024
#    Auteur    :  Issam LAGHA DEM/PNT (ONM)
#---------------------------------------------------------------------------------------------------------------------
mkdir -p  synop/alg synop/fra synop/lyb synop/mar synop/tun synop/por synop/spa

DD=01
MM=01
YY=2024


for i in $(seq -f "%02g" 0 7) ; do
for j in $(seq -f "%02g" 0 24 3) ; do
sshpass -p "pnt$2024" scp -r pnt@192.168.0.122:/home/cnpm/BDO/out/SYNOP/CONV-BUFR/$YY/$MM/$DD/$j/alg/$i  alg/
sshpass -p "pnt$2024" scp -r pnt@192.168.0.122:/home/cnpm/BDO/out/SYNOP/CONV-BUFR/$YY/$MM/$DD/$j/fra/$i  fra/
sshpass -p "pnt$2024" scp -r pnt@192.168.0.122:/home/cnpm/BDO/out/SYNOP/CONV-BUFR/$YY/$MM/$DD/$j/lyb/$i  lyb/
sshpass -p "pnt$2024" scp -r pnt@192.168.0.122:/home/cnpm/BDO/out/SYNOP/CONV-BUFR/$YY/$MM/$DD/$j/mar/$i  mar/
sshpass -p "pnt$2024" scp -r pnt@192.168.0.122:/home/cnpm/BDO/out/SYNOP/CONV-BUFR/$YY/$MM/$DD/$j/tun/$i  tun/
sshpass -p "pnt$2024" scp -r pnt@192.168.0.122:/home/cnpm/BDO/out/SYNOP/CONV-BUFR/$YY/$MM/$DD/$j/por/$i  por/
sshpass -p "pnt$2024" scp -r pnt@192.168.0.122:/home/cnpm/BDO/out/SYNOP/CONV-BUFR/$YY/$MM/$DD/$j/spa/$i  spa/
done
done
exit
