#!/bin/bash

# Verification du bon nombre de parametre
if [ $# != 3 ]
then
	echo "exemple d'utilisation : ./show_result.sh Depart.csv Result.csv Mat_P"
	exit
fi

if [ -f out.tex ]
then
	echo "le fichier out.tex existe deja"
	exit
fi

python3 Csv2Graph.py $1 $2 $3 "out.tex"		# Execution du script python
latex out.tex > /dev/null					# Compilation du fichier latex
dvipdf out.dvi								# Conversion du latex en pdf
evince out.pdf 2> /dev/null					# ouverture du pdf

