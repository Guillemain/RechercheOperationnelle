function G = optiFlots (A,depart,arrive)
iterationMax = 10;
nbIte = 0;
beta = -1;
As = A; Phi = zeros(size(A)); PhiN = zeros(size(A));
while ((nbIte < iterationMax) && (beta(1) ~= 0))
    [Phi,beta] = CreerChemin(As,2,depart,arrive);
    As = As - beta(1)*Phi;
    PhiN = PhiN + beta(1) * Phi;
    nbIte = nbIte + 1;
    disp(PhiN);
end
efficacite = sum(sum(As))/sum(sum(A));
disp('Efficacite du bouzin :');
disp(efficacite);
disp("Nombre d'étapes :");
disp(nbIte);
G = PhiN;
end