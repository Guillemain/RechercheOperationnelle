% Fonction qui permet d'obtenir le temps
% d'éxecution de la solution en fonction 
% de la taille de la matrice qui depend
% d'un coéfficient multiplicateur, ici i.

function tableau = courbesTps(n)

tab = zeros(1,n);
for i= 1:n
    [~,tps] = solutionEDT(5*i);
    tab(1,i) = tps;
end

tableau = 1000*tab;
end



