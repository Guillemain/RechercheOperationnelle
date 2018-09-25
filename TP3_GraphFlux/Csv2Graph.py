## Script Python permettant de cnvertir une matric de graphe du TP3 en un réel graph en LaTex
"""
@autour : Guillemain
    pour le lancer : $ python3 Csv2Graph.py matrice_de_liaison.cvs matrice_de_resultat matrice_de_position.csv out.tex

"""

import sys
import numpy as np

Graph   = np.array(np.genfromtxt(sys.argv[1],delimiter = ','),np.int) # Matrice représentant les liaisons.
Pos     = np.array(np.genfromtxt(sys.argv[3],delimiter = ','),np.int) # Matrice représentant les positions des points.
Result  = np.array(np.genfromtxt(sys.argv[2],delimiter = ','),np.int) # Matrice du résultat.
Pos     = np.transpose(Pos) # parcequ'après j'ai fait une boulette de prog, je dois transposer ici.
Out     = open(sys.argv[4],'w') # fichier de sortie.

## Placement des Etats sur le graphique.
#variables :
ancienStateDeGauche = 0; # Autre que CCCP... c'est le numero du dernier point 
# Boucles :  On balaye chaque colonne (transposée = ligne) pour repérer les points.
for ligne in Pos:
    ancienState = 0; # Dernier point retenu.
    for state in ligne:
        if(state > 0):
            if(ancienState != 0): # Bon là c'est du LaTex,
                Out.write("\\node[state] (" + chr(state + ord('0')) + ") [below =of " + chr(ancienState + ord('0')) + "] {$" + chr(state + ord('0')) + "$}; \n")
                ancienState = state
            elif (ancienStateDeGauche != 0):
                Out.write("\\node[state] (" + chr(state + ord('0')) + ") [right =of " + chr(ancienStateDeGauche + ord('0')) + "] {$" + chr(state + ord('0')) + "$}; \n")
                ancienStateDeGauche = state
                ancienState = state
            else:
                ancienStateDeGauche = state
                ancienState = state
                Out.write("\\node[state] (" + chr(state + ord('0')) + ") {$" + chr(state + ord('0')) + "$}; \n")


## Placement des arrêtes.
# On balaye sur à la recherche de liason.
for i in range(len(Graph)):
    for j in range(len(Graph[i])):
        if(Graph[i][j] > 0): # i.e. une liason est rencontrée.
            Out.write("\\path ("+ chr(i + 1 + ord('0')) +") edge [bend right = -25] node[below =0.15 cm] {$"+ chr(Result[i][j] + ord('0'))  + '/'+chr(Graph[i][j] + ord('0')) +"$} ("+ chr(j + 1 +ord('0')) +"); \n")

