#!/bin/bash

#Date
YY=$(date +%Y)
MM=$(date +%m)
DD=$(date +%d)
rr=00

#Domain
phi_N=50
phi_S=15
lamda_W=-40
lamda_E=20

#iech
first=0
end=24
iech=3

echo "date is $YY$MM$DD"
rm -fr /home/lagha/data/gfs/*
dataDir="/home/lagha/data/gfs/$YY$MM$DD"
mkdir -p $dataDir
for i in $(seq -f "%03g" ${first} ${iech} ${end}); do
wget "https://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25_1hr.pl?dir=%2Fgfs.${YY}${MM}${DD}%2F${rr}%2Fatmos&file=gfs.t${rr}z.pgrb2.0p25.f${i}&all_var=on&all_lev=on&subregion=&toplat=${phi_N}&leftlon=${lamda_W}&rightlon=${lamda_E}&bottomlat=${phi_S}" -O $dataDir/gfs.t${rr}z.pgrb2.0p25.f${i}
done

echo "************ Vérification de la disponibilité des données dans $dataDir ************"
for i in $(seq -f "%03g" ${first} ${iech} ${end}); do
if [ -f ${dataDir}/gfs.t${rr}z.pgrb2.0p25.f${i} ] ; then
      echo "Fichier gfs.t${rr}z.pgrb2.0p25.f${i} disponible"
else
      echo "Fichier gfs.t${rr}z.pgrb2.0p25.f${i} non disponible"
fi
done
