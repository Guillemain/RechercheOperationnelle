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

if numpart < 5 || isequal((ty(numpart-3:numpart-1) == ty(numpart-1)), ones(1,3))
    % S'il manque des informations ou si l'advresaire joue tout le temps la
    % même chose, on joue INOCENT
    s = INOCENTstackelberg(numpart,tx,ty,gx,gy);
    
else
    % si on detecte une stratégie affine, on joue antiaffine sinon INOCENT
    tableauDonnees = [ty(numpart-3: numpart-1);tx(numpart-4: numpart-2)];
    tableauDonnees = unique(tableauDonnees','rows')';
    coef = tableauDonnees(1,1)/(3-tableauDonnees(2,1));
    % Choix d'un epsilon élevé pour évantuellement détecter une affine avec
    % une part random
    eps = 0.2;
    utiliseAntiAffine = norm(tableauDonnees(1,:)-coef*(3-tableauDonnees(2,:))) < eps && length(tableauDonnees(1,:))>1 && coef<1 && coef>0;
    
    if utiliseAntiAffine
        s = (3-ty(numpart-1))/(2-coef);
    else
        s = INOCENTstackelberg(numpart,tx,ty,gx,gy);
    end
end

% On vérifie bien qu'on joue entre 0 et 3
if (s<0||s>=3)
    x = 0;
else
    x = s;
end