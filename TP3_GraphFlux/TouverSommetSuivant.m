%% Trouver Sommet Suivant
%   Paramètres :    As   = Matrices des arêtes
%                   Ch  = Chemin Actuellement suivit
%                   pos = (int) position actuelle
%                   sommetsInterdits = (explicite)
%   Post-Conditions :
%                   [i,j] = Arrête à suivre pour maximiser le transfère de 
%                   flux.
%                   Si [i,j] == [pos,pos] => il n'y a pas de chemin
%                   disponible. (Zuigwang tout ça tout ça)
%                   
%                   sens  = 1 si on parcourt dans le sens de la flèche. -1
%                   si dans l'autre sens. 0 en cas d'immobilisme.
%   testée.

function [i,j,sens] = TouverSommetSuivant (As,Ch,pos,sommetsInterdits)

A = As;
A(sommetsInterdits == 1) = 0;

[indice,~]=min(find (A(pos,:)>0));


if length(indice)==0
    i = pos ; j = pos; sens = 0;
else
   i = pos; j = indice;  sens = 1;
end