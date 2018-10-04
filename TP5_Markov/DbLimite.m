%  DbLimite : Retourne la distribution limite associée à la matrice P.
%   Param   : P Matrice représentant la chaine Markov.
%   pre     : P Matrice stochastique carrée.
%   post    : P*Pi = Pi. 

function Pi = DbLimite(P)
    n = size(P,1);
    vecteurPresqueZeros = [zeros(n,1) ; 1];
    Systeme = [(eye(n) - P') ; ones(1,n)];
    Pi = (Systeme\vecteurPresqueZeros);
end
