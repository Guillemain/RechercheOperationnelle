## Script Python permettant de cnvertir une matric de graphe du TP3 en un réel graph en LaTex
#
#s

import sys
import numpy as np

Graph   = np.array(np.genfromtxt(sys.argv[1],delimiter = ','),np.int)
Pos     = np.array(np.genfromtxt(sys.argv[2],delimiter = ','),np.int)
Pos = np.transpose(Pos)
Out     = open(sys.argv[3],'w')

## Placement des Etats sur le graphique.
ancienStateDeGauche = 0; # Autre que CCCP...

for ligne in Pos:
    ancienState = 0;
    for state in ligne:
        if(state > 0):
            if(ancienState != 0):
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

for i in range(len(Graph)):
    for j in range(len(Graph[i])):
        if(Graph[i][j] > 0):
            Out.write("\\path ("+ chr(i + 1 + ord('0')) +") edge [bend right = -25] node[below =0.15 cm] {$"+ chr(Graph[i][j] + ord('0')) +"$} ("+ chr(j + 1 +ord('0')) +"); \n")

