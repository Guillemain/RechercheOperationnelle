function [sOptimal,SOptimal,matriceBenefice,M] = OptimisationV2(D,v,C1,C2,C3,C4)


Smax = size(D,2)-1;   % Smax = 6
smax = size(D,2)-2;   % smax = 5

ligne = zeros(1,Smax);
matriceBenefice = zeros(smax+1,Smax);

for s = 0:smax
    ligne = zeros(1,Smax);
    for S = s+1:Smax
        P = Transition(D, S, s);
        Pi = DbLimite(P);
        ligne(S) = benefice(D,S,s,Pi,v,C1,C2,C3,C4);
    end
 
    matriceBenefice(s+1,:) = ligne;
    
end

[M,I] = max(matriceBenefice(:));
[ligneOptimale,colonneOptimale]= ind2sub(size(matriceBenefice),I);

M
sOptimal = ligneOptimale -1;
SOptimal = colonneOptimale;


end
