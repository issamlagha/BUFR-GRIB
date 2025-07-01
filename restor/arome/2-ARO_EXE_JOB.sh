#!/bin/bash
#------------------------------------------------------------------------------------------------------------------------
#    Objectif  :  Ecriture des sorties du modèle AROME en format binaire, exploitable par GRADS
#    Version   :  PNT/01-Mai-2022
#    Input     :  Les fichiers .txt issus du traitement effectué par l'utilitaire "EDF"
#    Output    :  Trois fichiers en format binaire (surface, altitude et températures extrêmes)
#    Consignes :  C'est une version exportable, modifier uniquement le fichier de config "date.config" avant le lancement
#    Execution :  ./2-ARO_EXE_JOB.sh
#------------------------------------------------------------------------------------------------------------------------
source date.config
#-------------------------------------------------------------------------------------------------------------------------------------
RESTOR=$HOME/RESTOR/AROME
export TMPDIR=$RESTOR/tmp/work
mkdir -p $TMPDIR
cd $TMPDIR
rm -f *
#------------------------------------------------------------------------------------------------------------------------
echo "*******************************************************************************************************************************"
echo "*  >  Extraction des champs AROME  :                                                                                          *"
echo "*                                                                                                                             *"
echo "*                 Situation  du  $JJ/$MM/$AA  ;  Réseau ${rr}h  ;  Echéance :  00h - ${ECH}h                                         *"
echo "*                                                                                                                             *"
echo "*******************************************************************************************************************************"
#------------------------------------------------------------------------------------------------------------------------
cp -f $RESTOR/src/arome*12* .
gfortran  arome_champs_surf_12_v4.f -o arome_champs_surf_12_v4.exe
gfortran  arome_champs_alt_12_v4.f  -o arome_champs_alt_12_v4.exe
gfortran  arome_textreme_12_v4.f    -o arome_textreme_12_v4.exe

cp -f $RESTOR/src/arome*${ECH}* .

gfortran  arome_champs_surf_v4_${ECH}.f -o arome_champs_surf_v4_${ECH}.exe
gfortran  arome_champs_alt_v4_${ECH}.f  -o arome_champs_alt_v4_${ECH}.exe
gfortran  arome_textreme_v4_${ECH}.f    -o arome_textreme_v4_${ECH}.exe


mkdir -p $RESTOR/SORTIE/${AA}${MM}${JJ}${rr}
cp -f $RESTOR/output/${AA}${MM}${JJ}${rr}/* .
#------------------------------------------------------------------------------------------------------------------------
echo 'Extraction des champs de surface pour AROME...  en cours'
./arome_champs_surf_v4_$ECH.exe
echo '                                                  OK'
echo 'Extraction des champs d altitude pour AROME... en cours'
./arome_champs_alt_v4_$ECH.exe
echo '                                                 OK'
echo 'Extraction des températures extrêmes pour AROME... en cours'
./arome_textreme_v4_$ECH.exe
echo '                                                     OK'
#------------------------------------------------------------------------------------------------------------------------
mv $RESTOR/SORTIE/*.dat $RESTOR/SORTIE/${AA}${MM}${JJ}${rr}/.
#------------------------------------------------------------------------------------------------------------------------
echo '---------------------------------------------------------------------------------------------------------------'
echo '>>> Traitement terminé, vérifier la disponibilité des fichiers dans : '$RESTOR'/SORTIE/'${AA}${MM}${JJ}${rr}'/'
echo '---------------------------------------------------------------------------------------------------------------'
exit 0
