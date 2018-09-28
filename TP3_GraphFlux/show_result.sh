#!/bin/bash

# Verification du bon nombre de parametre
if [ $# != 4 ]
then
	echo "exemple d'utilisation : ./show_result.sh Depart.csv Result.csv Mat_P nom_fichier_sortie"
	exit
fi
tex="$4.tex"
pdf="$4.pdf"
dvi="$4.dvi"
log="$4.log"
aux="$4.aux"

if [ -f $tex ]
then
	echo "le fichier $tex existe deja"
	exit
fi

python3 Csv2Graph.py $1 $2 $3 $tex		# Execution du script python
latex $tex > /dev/null					# Compilation du fichier latex
dvipdf $dvi								# Conversion du latex en pdf
rm $log $aux $dvi						# Suppression des fichiers inutiles
evince $pdf 2> /dev/null &				# ouverture du pdf

