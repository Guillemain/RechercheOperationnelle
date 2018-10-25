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
    
	x= 1.504; %valeur pour se reconnaitre
        
else
    %si c'est moi je coopere
    if (ty(1) == 1.504)
        x = 0.75;
    
    elseif numpart < 4 
        x = INOCENTstackelberg(numpart,tx,ty,gx,gy);
    %si l'autre coopere je coopere
    elseif (isequal((ty(numpart-3:numpart-1) == 0.75), ones(1,3)))
        x = 0.75;
    
    else
        x = antiA2(numpart,tx,ty,gx,gy);
    end
end