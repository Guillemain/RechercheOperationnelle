function x = strategie(numpart,tx,ty,gx,gy)
% strategie -- Strategie d'un joueur
%
%  Usage
%    x = strategie(numpart,tx,ty,gx,gy)
%
%  Inputs
%    tx     tableau des strategies jouees par le joueur x
%    ty     tableau des strategies jouees par le joueur y (l'adversaire)
%    gx     tableau des gains du joueur x
%    gy     tableau des gains du joueur y (l'adversaire)
%
%  Outputs
%    x      strategie elaboree par le joueur x
%
%
if (numpart == 1) %premier coup joue
    
    x= 0.74998; %valeur pour se reconnaitre
    
else
    if (ty(1) == 0.74998) %Si nous-même
        x = 0.75;
    elseif (ty(1) == 2.9998) %Si perteafond
        x = 1.5;
    elseif (ty(numpart-1) == 0.75) %Si coopératif alors coopératif
        if (numpart == 100)
            x = 1.1250;
        else
            x = 0.75;
        end
    else
        x = aux_antiA(numpart,tx,ty,gx,gy);
    end
end
end


%Fonction auxiliaire pour détecter une stratégie affine
function x = aux_antiA(numpart,tx,ty,gx,gy) 
if numpart < 5 || isequal((ty(numpart-3:numpart-1) == ty(numpart-1)), ones(1,3))
    % si on manque de données ou si y joue toujours la meme chose, alors on
    % joue sur antiaffine + random
    s = min(3,2*(3-ty(numpart-1))/3 +  (rand(1,1) -0.0) * 0.1);
else
    % si on detecte une stratégie affine, antiaffine sinon antiaffine + random
    tableauDonnees = [ty(numpart-3: numpart-1);tx(numpart-4: numpart-2)];
    tableauDonnees = unique(tableauDonnees','rows')';
    %Calcul du potentiel coefficient de la stratégie affine
    coef = tableauDonnees(1,1)/(3-tableauDonnees(2,1));
    eps = 1e-10;
    utiliseAntiAffine = norm(tableauDonnees(1,:)-coef*(3-tableauDonnees(2,:))) < eps && length(tableauDonnees(1,:))>1 && coef<1 && coef>0;
    if utiliseAntiAffine
        s = (3-ty(numpart-1))/(2-coef); %jeu anti-affine
    else
        s = min(3,2*(3-ty(numpart-1))/3 + (rand(1,1) -0.0) * 0.1);
    end
end

%Verification de la solution entre 0 et d
if (s<0||s>=3)
    x = 0;
else
    x = s;
end

end
