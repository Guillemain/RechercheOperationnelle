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
% Nous avons remarqué que que stackelberg avec une petite part d'aléatoire
% était en moyenne plus rentable.
%
if (numpart == 1)
	x= 0;
else
	x = min(3,2*(3-ty(numpart-1))/3 + rand(1,1) * 0.2); % le facteur 0.2 est le fruit de quelque tests réalisé avec les stratégies dipsonible.
    if x ~= 3
        x = max(0,x);
    end
end
