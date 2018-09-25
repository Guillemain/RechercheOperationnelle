%% Trouver Adjacent
%   Paramètres :    A   = Matrices des arêtes
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

function [i,j,sens] = TouverAdjacent (As,Ch,pos,sommetsInterdits)

A = As;
A(sommetsInterdits == 1) = 0;

[MaxCol,JMax] = max(A(pos,:));
[MaxLig,IMax] = max(-A(:,pos));

if (MaxCol > MaxLig)
   i = pos;  j = JMax; sens = 1;
else
   i = IMax; j = pos;  sens = -1;
end
if (max(MaxCol,MaxLig) <= 0) % Problème aucun chemin de disponible
    i = pos ; j = pos; sens = 0;
end