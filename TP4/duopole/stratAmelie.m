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

if (numpart == 2) %premier coup joue
    
	x= 1.501; %valeur pour se reconnaitre
        
else
    %si c'est moi je coopere
    if (ty(2) == 1.501)
        x = 0.75;
     
    %si l'autre coopere je coopere
    elseif (ty(numpart-1) == 0.75)
        x = 0.75;
    
    else
        x = antiA(numpart,tx,ty,gx,gy);
    end
end;