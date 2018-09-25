function [ tx, ty, gx, gy ] = jeu(NBJ,strax,stray)
%
% jeu -- Jeu itere entre deux individus
%
%  Usage
%    [ tx, ty, gx, gy ] = jeu(NBJ,strax,stray)
%
%  Inputs
%    NBJ    nombre de jeux a iterer 
%    strax  nom de la strategie du joueur A
%    stray  nom de la strategie du joueur B
%
%  Outputs
%    tx     strategies du joueur A
%    ty     strategies du joueur B
%    gx     gains du joueur A
%    gy     gains du joueur B
 %
%  Description
%    NBJ jeux sont joues, en jouant sequentiellement
%    strategies determinees par strax et 
%    stray pour les joeurs A et B respectivement. Les strate-
%    gies et les gains sont stockes dans tx, ty, gx et gy. 
%
%  See also
%    strategie
%
% Initialisations
%
tx=zeros(1,NBJ);
ty=zeros(1,NBJ);
gx=zeros(1,NBJ);
gy=zeros(1,NBJ);
%
for i = 2:NBJ
    tx_aux = feval(strax,i,tx,ty,gx,gy) ;
    ty_aux = feval(stray,i,ty,tx,gy,gx) ;
    tx(i) = tx_aux; ty(i) = ty_aux;			% comme ça, le joueur y n'a pas d'info sur ce que le joueur x a joué, et on respecte l'aspect synchrone du jeu
    [gx(i),gy(i)] = gain(tx(i),ty(i)) ;
end ;

