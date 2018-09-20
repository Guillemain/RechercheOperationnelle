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
%   testée.

function [i,j] = TouverAdjacent (A,Ch,pos,sommetsInterdits)
% 
% TO DO : Faire en sorte que les pointInterdits ne soient pas disponibles
% attention toutes fois à ce que les indices soient bien en correspondance
% avec ceux de A (d'où la difficultée de pas 'juste' enlever les
% pointsInterdits comme ça à la va vite.

[MaxCol,JMax] = max(A(pos,:));
[MaxLig,IMax] = max(-A(:,pos));

if (MaxCol > MaxLig)
   i = pos;  j = JMax;
else
   i = IMax; j = pos;
end
if (max(MaxCol,MaxLig) <= 0) % Problème aucun chemin de disponible
    i = pos ; j = pos;
end