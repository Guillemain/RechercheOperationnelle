function G = optiFlots (A,depart,arrive)
iterationMax = 10;
nbIte = 0;
beta = -1;
As = A; Phi = zeros(size(A));
while ((nbIte < iterationMax) && (beta(1) ~= 0))
    As = As - beta(1)*Phi;
    [Phi,beta] = CreerChemin(As,0,depart,arrive);
    nbIte = nbIte + 1;
end
efficacite = sum(sum(As))/sum(sum(A));
disp('Efficacite du bouzin :');
disp(efficacite);
disp("Nombre d'étapes :");
disp(nbIte);
G = As;
end