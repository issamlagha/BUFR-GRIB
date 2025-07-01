#!/bin/bash
#-------------------------------------------------------------------------------------------------------------------------------------
#    Objectif  :  Décodage des sorties du modèle ALADIN en utilisant l'utilitaire "EDF"
#    Version   :  PNT/01-Mai-2022
#    Input     :  Les sorties du modèle ALADIN (fullpos ou icmsh)
#    Output    :  Des fichiers en format txt pour chaque parametre et chaque échéance
#    Consignes :  C'est une version exportable, modifier uniquement le fichier de config "date.config" avant le lancement
#    Execution :  ./1-ALAD_EDF_JOB.sh
#-------------------------------------------------------------------------------------------------------------------------------------
source date.config
#-------------------------------------------------------------------------------------------------------------------------------------
RESTOR=$HOME/RESTOR/ALADIN
export TMPDIR=$RESTOR/tmp/ALADIN_EDF
mkdir -p $TMPDIR
cd $TMPDIR
rm -f *
#-------------------------------------------------------------------------------------------------------------------------------------
if [ $rr -eq 00 ] ; then
RES=r0
else
RES=r12
fi
#-------------------------------------------------------------------------------------------------------------------------------------
echo "--------------------------------------------------------------------------------------------------------------------------------"
echo "    >  Traitement 'EDF' pour ALADIN  :                                                                                         "
echo "                                                                                                                               "
echo "                  Situation  du  $JJ/$MM/$AA  ;  Réseau ${rr}h  ;  Echéance :  00h - ${ECH}h                                   "
echo "                                                                                                                               "
echo "--------------------------------------------------------------------------------------------------------------------------------"
#-------------------------------------------------------------------------------------------------------------------------------------
cp -f $RESTOR/bin/edf .
      if [ ! -f edf ] ; then exit 1;fi
cp -f $RESTOR/edf/namel_edf/* .

mkdir -p $RESTOR/output/${AA}${MM}${JJ}${rr}
#-------------------------------------------------------------------------------------------------------------------------------------
for i in $(seq -f "%02g" 0 3 ${ECH}) ; do
cp $RESTOR/data/$RES/FULLPOS_${AA}${MM}${JJ}${rr}_00${i} FULLPOS_${i}
#-------------------------------------------------------------------------------------------------------------------------------------
# Extraction des données de surface
# ---------------------------------
for param  in t2m     mslp     tmax     tmin     clsh  prec_con prec_gec neig_gec neig_con clsu  \
              clsv     neb_bas  neb_moy  neb_hau uraf    vraf     cape   t1000 t850  t700 t500   \
             h850 h700 h500 h1000 pss ; do

         ./edf namel_${param} FULLPOS_${i}
    mv   ASCII.FULLPOS_${i} $RESTOR/output/${AA}${MM}${JJ}${rr}/${param}_${i}
done
#-------------------------------------------------------------------------------------------------------------------------------------
# Extraction des données d'altitude
# ---------------------------------
for param in H T UU VV RH WW THETA; do
  echo "====> Extract ${param}${level}"
  ./edf namel_${param} FULLPOS_${i}
  mv   ASCII.FULLPOS_${i} $RESTOR/output/${AA}${MM}${JJ}${rr}/${param}_${i}
done
#-------------------------------------------------------------------------------------------------------------------------------------
rm -f FULLPOS_${i}
done
#-------------------------------------------------------------------------------------------------------------------------------------
echo '-------------------------------------------------------------------------------------------------------------------------------'
echo '       >>> Traitement terminé, vérifier la disponibilité des fichiers dans : '$RESTOR'/output/'${AA}${MM}${JJ}${rr}'/'
echo '-------------------------------------------------------------------------------------------------------------------------------'
exit 0
