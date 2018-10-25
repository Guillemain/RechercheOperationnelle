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

if (numpart == 1) %premier coup joue
    
	x= 2.9998; %valeur pour se reconnaitre
        
else
    %si c'est moi je coopere
    if (ty(2) == 2.9998)
        x = 0;
    elseif (ty(1) == 0.74998)
        x = 0;
    %si l'autre coopere je coope
    elseif ( mod(numpart,2) == 1)
        x = 0;
    else
        x = 3;
    end
end