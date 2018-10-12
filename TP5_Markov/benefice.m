function benef = benefice(Dav,S,s,PI,v,C1,C2,C3,C4)


% D vecteur colonne de probabilité de demande  alpha(k) = D(k+1)
% prendre D =  [0.1 ;0.2 ;0.2 ;0.2 ;0.1 ;0.1 ;0.1]
% S stock maximal
% s seuil de commande optimal
% PI vecteur colonne distribution limite


% benif benefice pour le couple (S,s)


kmax = size(Dav,2); % Demande maximale = taille de D
D = [Dav zeros(1,S+1+kmax)];

% Calcul de somme2
somme2 = 0;
%if (kmax-S-1) > 0
    for k= 1:kmax %-S-1
        somme2 = somme2 + k*D(k+S+1);
    end
%end 

% Calcul somme3
somme3 = 0;
for k=1:kmax
   somme3 = somme3 + min(S,k)*D(k+1); 
end


% Calcul somme1
somme1 = 0;
if s>0
    for j = 0:s-1
        somme1 = somme1 + PI(j+1)*(-C1*S - C2*somme2 - C3 -C4*(S-j) + v*somme3);
    end
end 



% Calcul somme4
somme4 = 0;
for j= s+1:S+1
   somme5 = 0;
   somme6 = 0;
   
    % Calcul somme5
    for k=1:kmax
        somme5 = somme5 + k*D(k+j); 
    end
    
    % Calcul somme6
    for k = 1 : kmax
        somme6 = somme6 + min(j-1,k)*D(k+1); 
    end
   
   somme4 =somme4 + PI(j)*(-C1*(j-1) - C2*somme5 + v*somme6); 
   
end


% Calcul du benefice
if s<S
    benef = somme1 + somme4;
else
    benef = 0;
end 




end