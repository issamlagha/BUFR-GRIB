#!/bin/bash
#-------------------------------------------------------------------------------------------------------------------------------------
#    Objectif  :  Décodage des sorties du modèle AROME en utilisant l'utilitaire "EDF"
#    Version   :  PNT/01-Mai-2022
#    Input     :  Les sorties du modèle AROME (fullpos ou icmsh)
#    Output    :  Des fichiers en format txt pour chaque parametre et chaque échéance
#    Consignes :  C'est une version exportable, modifier uniquement le fichier de config "date.config" avant le lancement
#    Execution :  ./1-ARO_EDF_JOB.sh
#-------------------------------------------------------------------------------------------------------------------------------------
source date.config
#-------------------------------------------------------------------------------------------------------------------------------------
RESTOR=/home/lagha/data/restor/arome
export TMPDIR=$RESTOR/tmp/AROME_EDF
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
echo "    >  Traitement 'EDF' pour AROME  :                                                                                          "
echo "                                                                                                                               "
echo "                  Situation  du  $JJ/$MM/$AA  ;  Réseau ${rr}h  ;  Echéance :  00h - ${ECH}h                                   "
echo "                                                                                                                               "
echo "--------------------------------------------------------------------------------------------------------------------------------"
#-------------------------------------------------------------------------------------------------------------------------------------
cp -f $RESTOR/edf/edf .
      if [ ! -f edf ] ; then exit 1;fi
cp -f $RESTOR/edf/namel_edf/* .
mkdir -p $RESTOR/output/${AA}${MM}${JJ}${rr}
#-------------------------------------------------------------------------------------------------------------------------------------
for i in $(seq -f "%02g" 0 3 ${ECH}) ; do
cp $RESTOR/data/$RES/FULLPOS_${AA}${MM}${JJ}${rr}_00${i} FULLPOS_${i}
#-------------------------------------------------------------------------------------------------------------------------------------
for param  in t2m mslp tmin tmax clsh acpluie acneige acgraupel clsu clsv uraf vraf        \
              neb_bas neb_moy neb_hau neb_tot neb_conv wat_vap cape uzonal100 vmerid100    \
              cldwat  cld_wat cld_fra ice_cry snow rain graupel tke temp_pot               \
              theta_prim vert_vel pot_vort vvert abs_vort div temp t1000 t850  t700 t500   \
              h850 h700 h500 h1000 H T UU VV RH WW THETA SIM_REF PRES ISOT_ALT THETA_VIRT ;  do
    ./edf namel_${param} FULLPOS_${i}
    mv   ASCII.FULLPOS_${i} $RESTOR/output/${AA}${MM}${JJ}${rr}/${param}_${i}
done
#-------------------------------------------------------------------------------------------------------------------------------------
rm -f FULLPOS_${i}
done
#-------------------------------------------------------------------------------------------------------------------------------------
echo '---------------------------------------------------------------------------------------------------------------'
echo '>>> Traitement terminé, vérifier la disponibilité des fichiers dans : '$RESTOR'/output/'${AA}${MM}${JJ}${rr}'/'
echo '---------------------------------------------------------------------------------------------------------------'
exit 0
