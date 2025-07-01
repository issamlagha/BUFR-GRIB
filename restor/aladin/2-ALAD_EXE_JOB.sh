#!/bin/bash
#------------------------------------------------------------------------------------------------------------------------
#    Objectif  :  Ecriture des sorties du modèle ALADIN en format binaire, exploitable par GRADS
#    Version   :  PNT/01-Mai-2022
#    Input     :  Les fichiers .txt issus du traitement effectué par l'utilitaire "EDF"
#    Output    :  Cinqs fichiers en format binaire (surface, altitude et trois fichiers pour les champs dérivés)
#    Consignes :  C'est une version exportable, modifier uniquement le fichier de config "date.config" avant le lancement
#    Execution :  ./2-ALA_EXE_JOB.sh
#------------------------------------------------------------------------------------------------------------------------
source date.config
#-------------------------------------------------------------------------------------------------------------------------------------
RESTOR=$HOME/RESTOR/ALADIN
export TMPDIR=$RESTOR/tmp/work
mkdir -p $TMPDIR
cd $TMPDIR
rm -f *
#------------------------------------------------------------------------------------------------------------------------
echo "*******************************************************************************************************************************"
echo "*  >  Extraction des champs ALADIN  :                                                                                         *"
echo "*                                                                                                                             *"
echo "*                 Situation  du  $JJ/$MM/$AA  ;  Réseau ${rr}h  ;  Echéance :  00h - ${ECH}h                                         *"
echo "*                                                                                                                             *"
echo "*******************************************************************************************************************************"
#------------------------------------------------------------------------------------------------------------------------
cp -f $RESTOR/src/aladin*${ECH}* .

gfortran  aladin_champs_alt_v4_${ECH}.f  -o   aladin_champs_alt_v4_${ECH}.exe
gfortran  aladin_pv2_v4_${ECH}.f    -o   aladin_pv2_v4_${ECH}.exe
gfortran  aladin_lapot_v4_${ECH}.f  -o   aladin_lapot_v4_${ECH}.exe
gfortran  aladin_champs_surf_v4_${ECH}.f -o aladin_champs_surf_v4_${ECH}.exe
gfortran  aladin_tetae_v4_${ECH}.f -o aladin_tetae_v4_${ECH}.exe

mkdir -p $RESTOR/SORTIE/${AA}${MM}${JJ}${rr}
cp -f $RESTOR/output/${AA}${MM}${JJ}${rr}/* .
#------------------------------------------------------------------------------------------------------------------------
echo 'Extraction des champs de surface pour ALADIN...  en cours'
./aladin_champs_surf_v4_$ECH.exe
echo '                                                   OK'
echo 'Extraction des champs d altitude pour ALADIN...  en cours'
./aladin_champs_alt_v4_$ECH.exe
echo '                                                   OK'
echo 'Extraction des champs dévirés ALADIN...  en cours'
./aladin_lapot_v4_$ECH.exe
./aladin_pv2_v4_$ECH.exe
./aladin_tetae_v4_$ECH.exe
echo '                                           OK'
#-----------------------------------------------------------------------------------------------------------------------
mv $RESTOR/SORTIE/*.dat $RESTOR/SORTIE/${AA}${MM}${JJ}${rr}/.
#-------------------------------------------------------------------------------------------------------------------------------------
echo '------------------------------------------------------------------------------------------------------------------------------'
echo ' >>>    Traitement terminé, vérifier la disponibilité des fichiers dans : '$RESTOR'/SORTIE/'${AA}${MM}${JJ}${rr}'/'
echo '------------------------------------------------------------------------------------------------------------------------------'
exit
