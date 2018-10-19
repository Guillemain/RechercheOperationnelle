
strax="pertafond";
NBJ=100;
stray = {'strat_agressive','stackelberg','strat_keran2','noncooperatif','star2016','INOCENTstackelberg','cooperatif','stochastique'};

i = 1;
perte =0;
for stra = stray
    strat = stra{1};
    [tx, ty, gx, gy] = jeu(NBJ,strax,strat);
    sx = zeros(size(gx));
    sy = zeros(size(gy));
    for j = 1:(NBJ-1)
        sx(j+1) = sx(j) + gx(j+1) ; 
       sy(j+1) = sy(j) + gy(j+1) ; 
    end
    i = i +1;
    perte = perte + sy(end);
end
disp(perte)