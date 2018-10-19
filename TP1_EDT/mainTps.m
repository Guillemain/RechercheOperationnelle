%Graphe des temps d'execution 
% selon la taille des données 
% avec le même nombre de données

valeursTps = courbesTps(100);

plot(valeursTps)
title("Temps d'exécution")
xlabel('Coefficient multiplicateur')
ylabel('Temps en ms')

