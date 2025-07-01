#!/bin/bash
#-------------------------------------------------------------------------------------------------------------------------------------
#    Objectif  :  Execution de tous les scripts pour le post-traitement des données ALADIN. 
#    Version   :  PNT/01-Mai-2022
#    Consignes :  C'est une version exportable, modifier uniquement le fichier de config "date.config" avant le lancement
#    Execution :  ./RUN-RESTOR-ALADIN.sh
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
DATADIR=$HOME/RESTOR/ALADIN/data
RESTOR=$HOME/RESTOR/ALADIN
#-------------------------------------------------------------------------------------------------------------------------------------
if [ $rr -eq 00 ] ; then
RES=r0
else
RES=r12
fi
#-------------------------------------------------------------------------------------------------------------------------------------
echo "-------------------------------------------------------------------" > log.aladin
echo "  Chaine de Post-traitement des sorties de modèle" >> log.aladin
echo "-------------------------------------------------------------------" >> log.aladin
echo "  Modèle     |     ALADIN" >> log.aladin
echo "-------------------------------------------------------------------" >> log.aladin
echo "  Situation  |     $JJ/$MM/$AA ;  R${rr}h ;  Ech 00h - ${ECH}h" >> log.aladin
echo "-------------------------------------------------------------------" >> log.aladin
echo "" >> log.aladin
echo "" >> log.aladin
#-------------------------------------------------------------------------------------------------------------------------------------
echo "Step -0- :" >> log.aladin
echo "----------" >> log.aladin
echo "  Téléchargement des données FULLPOS à partir du HPC ....." >> log.aladin

./0-ALAD_GET_DATA.sh 

echo "" >> log.aladin
echo "  >>> Vérification de la disponibilité des données dans $DATADIR/$RES" >> log.aladin

if [ -f $DATADIR/$RES/FULLPOS_${AA}${MM}${JJ}${rr}_0024 ] ; then
      echo " Les données ont été bien téléchargées, execution de l'étape suivante ... " >> log.aladin
else
        echo " ******************************************************************************************************* " >> log.aladin
  	echo " Les données n'ont pas été téléchargées, vérifier >>>>>>  Demander à la DIT de vous fournir ces données " >> log.aladin
        echo " ******************************************************************************************************* " >> log.aladin
	exit
fi
#-------------------------------------------------------------------------------------------------------------------------------------
echo "" >> log.aladin
echo "" >> log.aladin
echo "Step -1- :" >> log.aladin
echo "----------" >> log.aladin
echo "  Traitement des données FULLPOS par l'utilitaire EDF ....." >> log.aladin

./1-ALAD_EDF_JOB.sh

echo "" >> log.aladin
echo '  >>> Traitement terminé, vérifier la disponibilité des fichiers TEXT dans : '$RESTOR'/output/'${AA}${MM}${JJ}${rr}'/' >> log.aladin
#-------------------------------------------------------------------------------------------------------------------------------------
echo "" >> log.aladin
echo "" >> log.aladin
echo "Step -2- :" >> log.aladin
echo "----------" >> log.aladin
echo "  Traitement des output TEXT en format ASCII ....." >> log.aladin

./2-ALAD_EXE_JOB.sh

echo "" >> log.aladin
echo '  >>> Traitement terminé, vérifier la disponibilité des fichiers ASCII dans : '$RESTOR'/SORTIE/'${AA}${MM}${JJ}${rr}'/' >> log.aladin
#-------------------------------------------------------------------------------------------------------------------------------------
echo "" >> log.aladin
echo "" >> log.aladin
echo "Step -3- :" >> log.aladin
echo "----------" >> log.aladin
echo "  Traçage des cartes ALADIN ....." >> log.aladin

./3-ALAD_GRADS_JOB.sh

echo "" >> log.aladin
echo '  >>> Traitement terminé, vérifier la disponibilité  des cartes dans : '$RESTOR'/gifs/'${AA}${MM}${JJ}${rr}'/' >> log.aladin
echo '      Toutes les cartes ont été compressées dans le fichier '$RESTOR'/gifs/ALADIN_'${AA}${MM}${JJ}${rr}'.tar.gz' >> log.aladin
#-------------------------------------------------------------------------------------------------------------------------------------
echo "" >> log.aladin
echo "" >> log.aladin
echo "                         -------------------------------------------------------------------" >> log.aladin
echo "                                     Fin de la chaine de Post-traitement ALADIN              " >> log.aladin
echo "                         -------------------------------------------------------------------" >> log.aladin
#-------------------------------------------------------------------------------------------------------------------------------------
done
exit
