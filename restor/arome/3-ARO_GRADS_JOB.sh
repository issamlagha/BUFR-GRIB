#!/bin/bash
#------------------------------------------------------------------------------------------------------------------------
#    Objectif  :  Traçage des cartes pour les sorties du modèle AROME en utilisant l'utilitaire GRADS
#    Version   :  PNT/01-Mai-2022
#    Input     :  Les fichiers binaires issus de l'étape précédente
#    Output    :  Des cartes pour tous les paramètres (.gif ou .png)
#    Consignes :  C'est une version exportable, modifier uniquement le fichier de config "date.config" avant le lancement
#    Execution :  ./3-ARO_GRADS_JOB.sh
#------------------------------------------------------------------------------------------------------------------------
source date.config
#-------------------------------------------------------------------------------------------------------------------------------------
RESTOR=$HOME/RESTOR/AROME
GRADS=$HOME/RESTOR/grads
export TMPDIR=$RESTOR/tmp/work
mkdir -p $TMPDIR
cd $TMPDIR
rm -f *
#------------------------------------------------------------------------------------------------------------------------
echo "*******************************************************************************************************************************"
echo "*  >  Traçage  des  champs  AROME  :                                                                                          *"
echo "*                                                                                                                             *"
echo "*                 Situation  du  $JJ/$MM/$AA  ;  Réseau ${rr}h                                                                 *"
echo "*                                                                                                                             *"
echo "*******************************************************************************************************************************"
#------------------------------------------------------------------------------------------------------------------------
mkdir -p $TMPDIR/surface
mkdir -p $TMPDIR/altitude
mkdir -p $TMPDIR/derive
mkdir -p $RESTOR/gifs/${AA}${MM}${JJ}${rr}

rm -f $TMPDIR/surface/*
rm -f $TMPDIR/altitude/*
rm -f $TMPDIR/derive/*

cp -f $RESTOR/SORTIE/${AA}${MM}${JJ}${rr}/*.dat .
#------------------------------------------------------------------------------------------------------------------------
cd $GRADS
if [ $rr -eq 12 ] ; then
sed "s/JOUR/$JJ/g" $GRADS/mask/aromeS_plot_12.ctl >aromeS1.ctl
sed "s/YEAR/$AA/g" aromeS1.ctl >aromeS2.ctl
sed "s/MOIS/$MONTH/g" aromeS2.ctl >aromeS3.ctl
sed "s/ECHS/$nECH/g" aromeS3.ctl >aromeS.ctl

sed "s/JOUR/$JJ/g" $GRADS/mask/aromeP_plot_12.ctl >aromeP1.ctl
sed "s/YEAR/$AA/g" aromeP1.ctl >aromeP2.ctl
sed "s/MOIS/$MONTH/g" aromeP2.ctl >aromeP3.ctl
sed "s/ECHS/$nECH/g" aromeP3.ctl >aromeP.ctl

else
sed "s/JOUR/$JJ/g" $GRADS/mask/aromeS_plot.ctl >aromeS1.ctl
sed "s/YEAR/$AA/g" aromeS1.ctl >aromeS2.ctl
sed "s/MOIS/$MONTH/g" aromeS2.ctl >aromeS3.ctl
sed "s/ECHS/$nECH/g" aromeS3.ctl >aromeS.ctl

sed "s/JOUR/$JJ/g" $GRADS/mask/aromeP_plot.ctl >aromeP1.ctl
sed "s/YEAR/$AA/g" aromeP1.ctl >aromeP2.ctl
sed "s/MOIS/$MONTH/g" aromeP2.ctl >aromeP3.ctl
sed "s/ECHS/$nECH/g" aromeP3.ctl >aromeP.ctl

fi
#----------------------------------------------------------------------------------------------------------------------
echo 'Traçage des champs de surface pour AROME'
grads -lpbc "run arome_plot_surf_update_$nECH.gs"

echo 'Traçage des cumuls de pluies pour AROME'
grads -lpbc "run arome_plot_cumul_update_$nECH.gs"

echo 'Traçage des champs d altitude'
grads -lpbc "run arome_plot_alt_$nECH.gs"
#----------------------------------------------------------------------------------------------------------------------
rm -f aromeS1.ctl aromeS2.ctl aromeP1.ctl aromeP2.ctl
cd $TMPDIR
cp -r surface   $RESTOR/gifs/${AA}${MM}${JJ}${rr}/.
cp -r altitude  $RESTOR/gifs/${AA}${MM}${JJ}${rr}/.
cp -r derive    $RESTOR/gifs/${AA}${MM}${JJ}${rr}/.
rm -f *.dat
#------------------------------------------------------------------------------------------------------------------------
echo '---------------------------------------------------------------------------------------------------------------'
echo '>>> Vérifier la disponibilité des cartes de surface dans : '$RESTOR'/gifs/'${AA}${MM}${JJ}${rr}'/surface/'
echo '---------------------------------------------------------------------------------------------------------------'
echo '>>> Vérifier la disponibilité des cartes d altitude dans : '$RESTOR'/gifs/'${AA}${MM}${JJ}${rr}'/altitude/'
echo '---------------------------------------------------------------------------------------------------------------'
echo '>>> Vérifier la disponibilité des cartes des champs dérivés dans : '$RESTOR'/gifs/'${AA}${MM}${JJ}${rr}'/derive/'
echo '---------------------------------------------------------------------------------------------------------------'
#--------------------------------------------------------------------------------------------------------------------------
echo ''
echo '      >>> Compression des données AROME ...........'
cd $RESTOR/gifs
tar -zcvf AROME_${AA}${MM}${JJ}${rr}.tar.gz  ${AA}${MM}${JJ}${rr}
echo ''
echo '*******************************************************************************************************************'
echo '>>> Toutes les Sorties AROME sont compresser dans le fichier  '$RESTOR'/gifs/AROME_'${AA}${MM}${JJ}${rr}'.tar.gz'
echo '*******************************************************************************************************************'

exit 0
