% Graphe des temps d'execution 
% selon la taille des données 
% avec le même nombre de contraintes
coeff = 20;
valeursTps = courbesTps(coeff);

plot(valeursTps,'bo-')
title("Temps d'exécution")
xlabel('Coefficient multiplicateur')
ylabel('Temps en ms')

