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

        iterationMax = 100; nbIt = 0;
        PointsInterdits = zeros(size(A));
        Phi = zeros(size(A));
        pos = depart;
        beta = 0; duper = true;
        pileChemin = [pos];
        while ((nbIt < iterationMax) && (pos ~= arrive) && duper)
           nbIt = nbIt +1;
           switch strat
           case 1
                [i,j,sens] = TouverSommetSuivant(A,Phi,pos,PointsInterdits);
           otherwise
                [i,j,sens] = TouverAdjacent(A,Phi,pos,PointsInterdits);
           end
           if (sens ~= 0)
               Phi(i,j) = 1; Phi(j,i) = -1;
               PointsInterdits(i,j) = 1;
               PointsInterdits(j,i) = 1;
               if (sens == 1)
                   pos = j;
               else
                   pos = i;
               end
               pileChemin = [pileChemin pos];
               beta = min(A(find(Phi == 1)));
           else
               if (size(pileChemin,2) > 1)
                   Phi(pos,pileChemin(end-1)) = 0; %
                   Phi(pileChemin(end-1),pos) = 0; %
                   pos = pileChemin(end-1);
                   pileChemin = pileChemin(1:end-1);
               else
                   duper = false;
                   Phi = zeros(size(A));
                   beta = 0;
               end
           end
        end

end