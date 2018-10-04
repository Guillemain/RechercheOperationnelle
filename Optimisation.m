function [sOptimal,SOptimal] = Optimisation((D,PI,v,C1,C2,C3,C4)


Smax = size(D,1);
smax = size(D,1);

matriceBenefice = zeros(smax,Smax);

for i = 1:Smax
    for j = 1:smax+1
        matriceBenefice(i,j) = benefice(D,i,j,PI,v,C1,C2,C3,C4)    
    end
end

[M,I] = max(matriceBenefice(:));
[ligneOptimale,colonneOptimale]= ind2sub(size(matriceBenefice),I);

sOptimal = ligneOptimale - 1;
SOptimal = colonneOptimale;


end