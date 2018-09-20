%% Creer un Chemin 
%   Paramètres :    A       = La matrice d'arrêtes
%                   strat   = Stratégie à adopter cf. code.
%                   depart  = Point de départ du graphe.
%                   arrive  = Point d'arrive du graphe.
%   Post-Condition :
%                   Phi = zeros(size(A)) && beta = 0 si chemin introuvable.
%                   Chemin renvoyé est sous la forme Phi(i,j) > 0 => on
%                   suit le trajet du sommet i vers j.
%                   Beta = Flot émis sur le chemin.
% 


function [Phi,beta] = CreerChemin(A,strat,depart,arrive)
switch strat
    case 1
        % TO DO : implémentée la commande non implémentée.
        disp('commande non-implémentée');
    otherwise
        iterationMax = 100; nbIt = 0;
        Phi = zeros(size(A));
        pos = depart;
        beta = 0;
        while ((nbIt < iterationMax) && (pos ~= arrive))
           nbIt = nbIt +1;
           [i,j,sens] = TouverAdjacent(A,Phi,pos,0);
           if (sens ~= 0)
               Phi(i,j) = 1; Phi(j,i) = -1;
               if (sens == 1)
                   pos = j;
               else
                   pos = i;
               end
           else
               Phi = zeros(size(A));
               beta = 0;
           end
        end
end
beta = min(A(find(Phi == 1)));
end