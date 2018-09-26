disp('Quelle stratégie voulez vous lancer ?');
strax=input('Stratégie du 1er joueur: ','s');
NBJ=input('Nombre de parties: ');

stray = {'strat_agressive','stackelberg','strat_keran2','noncooperatif','star2016','INOCENTstackelberg'};

figure
i = 1;
for stra = stray
    strat = stra{1}
    [tx, ty, gx, gy] = jeu(NBJ,strax,strat);
    %fig = afficher(tx,ty,gx,gy,strax,strat);  %<- à décomenter si vous
    %souhaitez avoir le détails contre toutes les tratégie
    sx = zeros(size(gx));
    sy = zeros(size(gy));
    for j = 1:(NBJ-1)

        sx(j+1) = sx(j) + gx(j+1) ; 
       sy(j+1) = sy(j) + gy(j+1) ; 

    end
    subplot(3,3,i)
    plot([1:NBJ],sx,[1:NBJ],sy) ;
    xlabel('Numero du jeu') ;
    ylabel('Total des gains') ;
    legend(strax,strat) ;
    i = i +1;
end