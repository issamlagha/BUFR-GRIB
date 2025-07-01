#!/bin/bash
#------------------------------------------------------------------------------------------------------------------------
#    Objectif  :  Traçage des cartes pour les sorties du modèle ALADIN en utilisant l'utilitaire GRADS
#    Version   :  PNT/01-Mai-2022
#    Input     :  Les fichiers binaires issus de l'étape précédente
#    Output    :  Des cartes pour tous les paramètres (.gif ou .png)
#    Consignes :  C'est une version exportable, modifier uniquement le fichier de config "date.config" avant le lancement
#    Execution :  ./3-ALAD_GRADS_JOB.sh
#------------------------------------------------------------------------------------------------------------------------
source date.config
#-------------------------------------------------------------------------------------------------------------------------------------
RESTOR=$HOME/RESTOR/ALADIN
GRADS=$HOME/RESTOR/grads
export TMPDIR=$RESTOR/tmp/work
mkdir -p $TMPDIR
cd $TMPDIR
rm -f *
#------------------------------------------------------------------------------------------------------------------------
echo "*******************************************************************************************************************************"
echo "*  >  Traçage  des  champs  ALADIN  :                                                                                         *"
echo "*                                                                                                                             *"
echo "*                 Situation  du  $JJ/$MM/$AA  ;  Réseau ${rr}h                                                                 *"
echo "*                                                                                                                             *"
echo "*******************************************************************************************************************************"
#-----------------------------------------------------------------------------------------------------------------------
mkdir -p $TMPDIR/surface
mkdir -p $TMPDIR/altitude
mkdir -p $TMPDIR/derive

mkdir -p $RESTOR/gifs/${AA}${MM}${JJ}${rr}

echo $rr

rm -f $TMPDIR/surface/*
rm -f $TMPDIR/altitude/*
rm -f $TMPDIR/derive/*

cp -f $RESTOR/SORTIE/${AA}${MM}${JJ}${rr}/*.dat .
#-----------------------------------------------------------------------------------------------------------------------
cd $GRADS
if [ $rr -eq 12 ] ; then
sed "s/JOUR/$JJ/g" $GRADS/mask/aladinS_12.ctl >aladinS1.ctl
sed "s/YEAR/$AA/g" aladinS1.ctl >aladinS2.ctl
sed "s/MOIS/$MONTH/g" aladinS2.ctl >aladinS3.ctl
sed "s/ECHS/$nECH/g" aladinS3.ctl >aladinS.ctl

sed "s/JOUR/$JJ/g" $GRADS/mask/aladinP_12.ctl >aladinP1.ctl
sed "s/YEAR/$AA/g" aladinP1.ctl >aladinP2.ctl
sed "s/MOIS/$MONTH/g" aladinP2.ctl >aladinP3.ctl
sed "s/ECHS/$nECH/g" aladinP3.ctl >aladinP.ctl

sed "s/JOUR/$JJ/g" $GRADS/mask/pvA_12.ctl >pvA1.ctl
sed "s/YEAR/$AA/g" pvA1.ctl >pvA2.ctl
sed "s/MOIS/$MONTH/g" pvA2.ctl >pvA3.ctl
sed "s/ECHS/$nECH/g" pvA3.ctl >pvA.ctl

sed "s/JOUR/$JJ/g" $GRADS/mask/lapotA_12.ctl >lapotA1.ctl
sed "s/YEAR/$AA/g" lapotA1.ctl >lapotA2.ctl
sed "s/MOIS/$MONTH/g" lapotA2.ctl >lapotA3.ctl
sed "s/ECHS/$nECH/g" lapotA3.ctl >lapotA.ctl

else
sed "s/JOUR/$JJ/g" $GRADS/mask/aladinS.ctl >aladinS1.ctl
sed "s/YEAR/$AA/g" aladinS1.ctl >aladinS2.ctl
sed "s/MOIS/$MONTH/g" aladinS2.ctl >aladinS3.ctl
sed "s/ECHS/$nECH/g" aladinS3.ctl >aladinS.ctl

sed "s/JOUR/$JJ/g" $GRADS/mask/aladinP.ctl >aladinP1.ctl
sed "s/YEAR/$AA/g" aladinP1.ctl >aladinP2.ctl
sed "s/MOIS/$MONTH/g" aladinP2.ctl >aladinP3.ctl
sed "s/ECHS/$nECH/g" aladinP3.ctl >aladinP.ctl

sed "s/JOUR/$JJ/g" $GRADS/mask/pvA.ctl >pvA1.ctl
sed "s/YEAR/$AA/g" pvA1.ctl >pvA2.ctl
sed "s/MOIS/$MONTH/g" pvA2.ctl >pvA3.ctl
sed "s/ECHS/$nECH/g" pvA3.ctl >pvA.ctl

sed "s/JOUR/$JJ/g" $GRADS/mask/lapotA.ctl >lapotA1.ctl
sed "s/YEAR/$AA/g" lapotA1.ctl >lapotA2.ctl
sed "s/MOIS/$MONTH/g" lapotA2.ctl >lapotA3.ctl
sed "s/ECHS/$nECH/g" lapotA3.ctl >lapotA.ctl
fi
#---------------------------------------------------------------------------------------------------------------------------
echo 'Traçage des champs de surface pour ALADIN'
grads -lpbc "run parm_surf_$nECH.gs"
grads -lpbc "run parm_surf2_update_$nECH.gs"

echo 'Traçage des champs d altitude pour ALADIN'
grads -lpbc "run parm_alt_$nECH.gs"
grads -lpbc "run parm_alt1_$nECH.gs"

echo 'Traçage des champs dérivés pour ALADIN'
grads -lpbc "run parm_deriv_new_$nECH.gs"
#---------------------------------------------------------------------------------------------------------------------------
rm -f pvA1.ctl aladinP1.ctl lapotA1.ctl aladinS1.ctl pvA2.ctl aladinP2.ctl lapotA2.ctl aladinS2.ctl
cd $TMPDIR
cp -r surface   $RESTOR/gifs/${AA}${MM}${JJ}${rr}/.
cp -r altitude  $RESTOR/gifs/${AA}${MM}${JJ}${rr}/.
cp -r derive    $RESTOR/gifs/${AA}${MM}${JJ}${rr}/.
rm -f *.dat
#---------------------------------------------------------------------------------------------------------------------------
echo '---------------------------------------------------------------------------------------------------------------'
echo '>>> Vérifier la disponibilité des cartes de surface dans : '$RESTOR'/gifs/'${AA}${MM}${JJ}${rr}'/surface/'
echo '---------------------------------------------------------------------------------------------------------------'
echo '>>> Vérifier la disponibilité des cartes d altitude dans : '$RESTOR'/gifs/'${AA}${MM}${JJ}${rr}'/altitude/'
echo '---------------------------------------------------------------------------------------------------------------'
echo '>>> Vérifier la disponibilité des cartes des champs dérivés dans : '$RESTOR'/gifs/'${AA}${MM}${JJ}${rr}'/derive/'
echo '---------------------------------------------------------------------------------------------------------------'
#---------------------------------------------------------------------------------------------------------------------------
echo ''
echo '      >>> Compression des données ALADIN ...........'
cd $RESTOR/gifs
tar -zcvf ALADIN_${AA}${MM}${JJ}${rr}.tar.gz  ${AA}${MM}${JJ}${rr} 
echo ''
echo '*********************************************************************************************************************************'
echo '>>> Toutes les Sorties ALADIN sont compresser dans le fichier  '$RESTOR'/gifs/ALADIN_'${AA}${MM}${JJ}${rr}'.tar.gz'
echo '*********************************************************************************************************************************'

exit
