% Variables

D =  [0.1 0.2 0.2 0.2 0.1 0.1 0.1];
v = 20;
C1 = 5;
C2 = 10;
C3 = 10;
C4 = 5;

% Test de la fonction beneifice pour une valeur precise de S et s
 
%  S = 5;
%  s = 4;
%  
%  P = Transition(D, S, s);
%  Pi = DbLimite(P);
%  benefice(D,S,s,Pi,v,C1,C2,C3,C4)


% test d'OptimisationV2

[sOptimal,SOptimal,matriceBenefice,M] = Optimisation(D,v,C1,C2,C3,C4);
matriceBenefice
display("Le gain maximal est : " + M + " pour s = " + sOptimal + " et S = " + SOptimal);

