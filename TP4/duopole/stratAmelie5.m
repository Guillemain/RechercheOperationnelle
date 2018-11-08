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
    
	x= 0.75; %valeur pour se reconnaitre
        
else
    if (ty(1) == 2.9998) % C'est les copains !
        x = 1.500001;
    elseif (ty(numpart-1) == 0.75)
        if (numpart == 100)
            x = 1.1250;
        else
           x = 0.75;
        end
    else
        x = antiA(numpart,tx,ty,gx,gy);
    end
end