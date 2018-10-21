disp('Quelle stratégie voulez vous lancer ?');
strax=input('Stratégie du 1er joueur: ','s');
NBJ=input('Nombre de parties: ');

stray = {'strat_agressive','stackelberg','strat_keran2','noncooperatif','star2016','INOCENTstackelberg','pertafond','stochastique'};
totalgain = 0;
figure(1);
figure(2);
i = 1;
for stra = stray
    strat = stra{1};
    [tx, ty, gx, gy] = jeu(NBJ,strax,strat);
    %fig = afficher(tx,ty,gx,gy,strax,strat);  %<- à décomenter si vous
    %souhaitez avoir le détails contre toutes les tratégie
    sx = zeros(size(gx));
    sy = zeros(size(gy));
    for j = 1:(NBJ-1)

        sx(j+1) = sx(j) + gx(j+1) ; 
       sy(j+1) = sy(j) + gy(j+1) ; 

    end
    totalgain = totalgain + sx(end);
    figure(1)
    subplot(2,4,i)
    plot([1:NBJ],sx,[1:NBJ],sy) ;
    xlabel('Numero du jeu') ;
    ylabel('Total des gains') ;
    legend(strax,strat) ;
    figure(2)
    subplot(2,4,i)
    %% WTF ?
    indi = find((tx > 1).*(tx < 3));
    indi = indi(2:end-1);
    %indi = 2:99;
    A = [tx(indi - 1)' ones(size(indi,2),1)];
    Y = ty(indi)';
    Coef = A\Y;
    hold on
    %plot([tx(5) tx(8)],[ [tx(5),1] *Coef , [tx(8),1] *Coef  ],'-');
    plot([0,3],[Coef(2),Coef(1)*3+Coef(2)],'--r');
    plot(tx(indi),ty(indi+1),'.') ;
    
    % Calcul du coef de corr carre.
    
    xlabel('nosJeux') ;
    ylabel('LeLeur') ;
    legend(strat,'predictions') ;
    i = i +1;
end

disp(totalgain);