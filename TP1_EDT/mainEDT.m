%Calcul de la solution optimale
[x,tps] = solutionEDT(5);
display("Temps d'exécution EDTsimple : " + tps*1000 + " ms");

%Mise en forme des matrices des deux promos
[Promo1, Promo2] = reshapeEDT(x);

%Affichage des 2 emplois du temps
affichage(Promo1,1);
affichage(Promo2,2);

