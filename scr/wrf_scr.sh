#!/bin/bash

#Date
YY=$(date +%y)
MM=$(date +%m)
DD=$(date +%d)
rr=00

dataDir="/home/lagha/data/wrf/$YY$MM$DD"
mkdir -p $dataDir

#Alger
wget "https://openskiron.org/gribs_wrf_12km/France_12km_WRF_WAM_${YY}${MM}${DD}-${rr}.grb.bz2" -O $dataDir/wrf.t${rr}z_France_12km.grb.bz2
#Palos
wget "https://openskiron.org/gribs_wrf_12km/Spain_12km_WRF_WAM_${YY}${MM}${DD}-06.grb.bz2" -O $dataDir/wrf.t06z_Spain_12km.grb.bz2
#Oasis
wget "https://openskiron.org/gribs_wrf_12km/Italy_12km_WRF_WAM_${YY}${MM}${DD}-${rr}.grb.bz2" -O $dataDir/wrf.t${rr}z_Italy_12km.grb.bz2
#Tindouf
