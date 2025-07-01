#!/bin/bash
#-------------------------------------------------------------------------------------------------------------------------------------
#    Objectif  :  Execution de tous les scripts pour le post-traitement des données AROME. 
#    Version   :  PNT/01-Mai-2022
#    Consignes :  C'est une version exportable, modifier uniquement le fichier de config "date.config" avant le lancement
#    Execution :  ./RUN-RESTOR-AROME.sh
#-------------------------------------------------------------------------------------------------------------------------------------
if [ $# -ne 6 ]; then
    echo "Usage: $0 AA MM ECH rr JJ_start JJ_end"
    exit 1
fi

AA=$1
MM=$2
ECH=$3
rr=$4
JJ_start=$5
JJ_end=$6

case "$MM" in
    01) MONTH=Jan ;;
    02) MONTH=Feb ;;
    03) MONTH=Mar ;;
    04) MONTH=Apr ;;
    05) MONTH=May ;;
    06) MONTH=Jun ;;
    07) MONTH=Jul ;;
    08) MONTH=Aug ;;
    09) MONTH=Sep ;;
    10) MONTH=Oct ;;
    11) MONTH=Nov ;;
    12) MONTH=Dec ;;
    *)  MONTH="Invalid" ;;
esac

case "$ECH" in
    24) nECH=9 ;;
    48) nECH=17 ;;
    *)  nECH="Invalid" ;;
esac
for JJ in $(seq -w $JJ_start $JJ_end); do
    sed -i "s/AA=[0-9]*/AA=$AA/g" date.config
    sed -i "s/MM=[0-9]*/MM=$MM/g" date.config
    sed -i "s/MONTH=[A-Za-z]*/MONTH=$MONTH/g" date.config
    sed -i "s/JJ=[0-9]*/JJ=$JJ/g" date.config
    sed -i "s/ECH=[0-9]*/ECH=$ECH/g" date.config
    sed -i "s/nECH=[0-9]*/nECH=$nECH/g" date.config
    sed -i "s/rr=[0-9]*/rr=$rr/g" date.config
source date.config
#-------------------------------------------------------------------------------------------------------------------------------------
DATADIR=$HOME/RESTOR/AROME/data
RESTOR=$HOME/RESTOR/AROME
#-------------------------------------------------------------------------------------------------------------------------------------
if [ $rr -eq 00 ] ; then
RES=r0
else
RES=r12
fi
#-------------------------------------------------------------------------------------------------------------------------------------
echo "-------------------------------------------------------------------" > log.arome
echo "  Chaine de Post-traitement des sorties de modèle" >> log.arome
echo "-------------------------------------------------------------------" >> log.arome
echo "  Modèle     |     AROME" >> log.arome
echo "-------------------------------------------------------------------" >> log.arome
echo "  Situation  |     $JJ/$MM/$AA ;  R${rr}h ;  Ech 00h - ${ECH}h" >> log.arome
echo "-------------------------------------------------------------------" >> log.arome
echo "" >> log.arome
echo "" >> log.arome
#-------------------------------------------------------------------------------------------------------------------------------------
echo "Step -0- :" >> log.arome
echo "----------" >> log.arome
echo "  Téléchargement des données FULLPOS à partir du HPC ....." >> log.arome

./0-ARO_GET_DATA.sh 

echo "" >> log.arome
echo "  >>> Vérification de la disponibilité des données dans $DATADIR/$RES" >> log.arome

if [ -f $DATADIR/$RES/FULLPOS_${AA}${MM}${JJ}${rr}_0024 ] ; then
      echo " Les données ont été bien téléchargées, execution de l'étape suivante ... " >> log.arome
else
        echo " ******************************************************************************************************* " >> log.arome
  	echo " Les données n'ont pas été téléchargées, vérifier >>>>>>  Demander à la DIT de vous fournir ces données " >> log.arome
        echo " ******************************************************************************************************* " >> log.arome
	exit
fi
#-------------------------------------------------------------------------------------------------------------------------------------
echo "" >> log.arome
echo "" >> log.arome
echo "Step -1- :" >> log.arome
echo "----------" >> log.arome
echo "  Traitement des données FULLPOS par l'utilitaire EDF ....." >> log.arome

./1-ARO_EDF_JOB.sh

echo "" >> log.arome
echo '  >>> Traitement terminé, vérifier la disponibilité des fichiers TEXT dans : '$RESTOR'/output/'${AA}${MM}${JJ}${rr}'/' >> log.arome
#-------------------------------------------------------------------------------------------------------------------------------------
echo "" >> log.arome
echo "" >> log.arome
echo "Step -2- :" >> log.arome
echo "----------" >> log.arome
echo "  Traitement des output TEXT en format ASCII ....." >> log.arome

./2-ARO_EXE_JOB.sh

echo "" >> log.arome
echo '  >>> Traitement terminé, vérifier la disponibilité des fichiers ASCII dans : '$RESTOR'/SORTIE/'${AA}${MM}${JJ}${rr}'/' >> log.arome
#-------------------------------------------------------------------------------------------------------------------------------------
echo "" >> log.arome
echo "" >> log.arome
echo "Step -3- :" >> log.arome
echo "----------" >> log.arome
echo "  Traçage des cartes AROME ....." >> log.arome

./3-ARO_GRADS_JOB.sh

echo "" >> log.arome
echo '  >>> Traitement terminé, vérifier la disponibilité  des cartes dans : '$RESTOR'/gifs/'${AA}${MM}${JJ}${rr}'/' >> log.arome
echo '      Toutes les cartes ont été compressées dans le fichier '$RESTOR'/gifs/AROME_'${AA}${MM}${JJ}${rr}'.tar.gz' >> log.arome
#-------------------------------------------------------------------------------------------------------------------------------------
echo "" >> log.arome
echo "" >> log.arome
echo "                         -------------------------------------------------------------------" >> log.arome
echo "                                     Fin de la chaine de Post-traitement AROME              " >> log.arome
echo "                         -------------------------------------------------------------------" >> log.arome
#-------------------------------------------------------------------------------------------------------------------------------------
done
exit
