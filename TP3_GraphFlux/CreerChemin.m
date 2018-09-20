function Phi = CreerChemin(A,strat,depart,arrive)
switch strat
    otherwise
        iterationMax = 100; nbIt = 0;
        Phi = Zeros(size(A));
        pos = depart;
        beta = 0;
        while ((nbIt < iterationMax) && (pos ~= arrive))
           nbIt = nbIt +1;
           
        end
end
end