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

#Ecriture de l'entete

entete = "\\documentclass {article}\n\\usepackage {tikz}\n\\usetikzlibrary {positioning}\n\\definecolor {processblue}{cmyk}{0.96,0,0,0}\n\\begin {document}\n\\begin {center}\n\\begin {tikzpicture}[-latex ,auto ,node distance =4 cm and 5cm ,on grid ,\nsemithick ,\nstate/.style ={ circle ,top color =white , bottom color = white!20 ,\ndraw,black , text=black , minimum width =1 cm}]\n"
Out.write(entete)

## Placement des Etats sur le graphique.
#variables :
ancienStateDeGauche = 0; # Autre que CCCP... c'est le numero du dernier point 
# Boucles :  On balaye chaque colonne (transposée = ligne) pour repérer les points.
for ligne in Pos:
    ancienState = 0; # Dernier point retenu.
    for state in ligne:
        if(state > 0):
            if(ancienState != 0): # Bon là c'est du LaTex,
                Out.write("\\node[state] (" + str(state) + ") [below =of " + str(ancienState) + "] {$" + str(state) + "$}; \n")
                ancienState = state
            elif (ancienStateDeGauche != 0):
                Out.write("\\node[state] (" + str(state) + ") [right =of " + str(ancienStateDeGauche) + "] {$" + str(state) + "$}; \n")
                ancienStateDeGauche = state
                ancienState = state
            else:
                ancienStateDeGauche = state
                ancienState = state
                Out.write("\\node[state] (" + str(state) + ") {$" + str(state) + "$}; \n")


## Placement des arrêtes.
# On balaye sur à la recherche de liason.
for i in range(len(Graph)):
    for j in range(len(Graph[i])):
        if(Graph[i][j] > 0): # i.e. une liason est rencontrée.
            Out.write("\\path ("+ str(i + 1) +") edge [bend right = -25] node[below =0.15 cm] {$"+ str(Result[i][j])  + '/'+str(Graph[i][j]) +"$} ("+ str(j + 1) +"); \n")
            
#Ecriture de la fin
fin = "\\end{tikzpicture}\n\\end{center}\n\\end{document}"
Out.write(fin)

