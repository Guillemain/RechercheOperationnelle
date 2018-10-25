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
amelie = false;
if (numpart == 1) %premier coup joue
    
	x= 1.501; %valeur pour se reconnaitre
        
else
    
    if (ty(1) == 1.501)
        
        x = 0.75;
    else try
        Mat = load('AmelieIsHere');
        amelie = true;
    catch ME
        amelie = false;
    end
    %si l'autre coopere je coopere
    elseif (ty(numpart-1) == 0.75)
        if (numpart == 100)
            x = 1.1250;
        else
           x = 0.75;
        end
    else
        x = antiA(numpart,tx,ty,gx,gy);
    end
end;