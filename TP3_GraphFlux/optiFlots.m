function Resultat = optiFlots (A,strat,depart,arrive)
iterationMax = 50;
nbIte = 0;
beta = -1;
As = A; Phi = zeros(size(A)); PhiN = zeros(size(A));

while ((nbIte < iterationMax) && (beta(1) ~= 0))
    [Phi,beta] = CreerChemin(As,strat,depart,arrive);
    As = As - beta(1)*Phi;
    PhiN = PhiN + beta(1) * Phi;
    nbIte = nbIte + 1;
end
efficacite = sum(sum(abs(PhiN)))/(2*sum(sum(A)));
disp('Efficacite du bouzin :');
disp(efficacite);
disp("Nombre d'étapes :");
disp(nbIte-1);
Resultat = PhiN;
end