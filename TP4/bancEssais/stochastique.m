function x = strategie(numpart,tx,ty,gx,gy)
% strategie -- Strategie d'un joueur 
%
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
% PLUS DE BLABLA
%+ rand(1,1) * ((100 - numpart)/100 + 0.2)
if (numpart == 1)
	x= 0;
else
	x = min(3,2*(3-ty(numpart-1))/3 );
    if x ~= 3
        x = max(0,x);
    end
end
