function [Promo1, Promo2] = reshapeEDT(x)
%x : vecteur solution optimale
%PromoX : matrice correspondant à l'emploi du temps de la promo X

%Constantes
d = 5; % nb de jours de cours
t = 4; % nb de crenaux par jours
c = 2; % nb de promo
p = 8; % nb de profs


%Initialisation
Promo1 = zeros(t,d);
Promo2 = zeros(t,d);

%Premier reshape (à la colonne i on trouve x(i,_,_))
matriceProfPromo = reshape(x,[d*t,c*p]);

%Décomposition par promo
matriceProfP1 = matriceProfPromo(:,[1:2:end]);
matriceProfP2 = matriceProfPromo(:,[2:2:end]);

%Remplissage de la matrice
for i = 1:p
    vecteurProfiP1 = matriceProfP1(:,i);
    indP1 = find(vecteurProfiP1 == 1);
    n1 = size(indP1,1);
    for j = 1:n1
        [jour,creneau] = pos2creneaux(indP1(j),t); %matrice de position de cours du prof i
        Promo1(creneau,jour) = i;
    end
    
    vecteurProfiP2 = matriceProfP2(:,i);
    indP2 = find(vecteurProfiP2 == 1);
    n2 = size(indP2,1);
    for k = 1:n2
        [jour,creneau] = pos2creneaux(indP2(k),t); %matrice de position de cours du prof i
        Promo2(creneau,jour) = i;
    end
end

end