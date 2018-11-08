s%Variables 
contraintesInegalite = 8;
contraintesEgalite = 2;

n = 12;

A = zeros(contraintesInegalite,n);
Aeq = zeros(contraintesEgalite,n);

% Matrice des contraintes
A(1,[7,9,11]) = 1;
A(2,[1,3,5]) = 1;
A(3,[1,2]) = 1;
A(4,[3,4]) = 1;
A(5,[5,6]) = 1;
A(6,[7,8]) = 1;
A(7,[9,10]) = 1;
A(8,[11,12]) = 1;

Aeq(1,[2:2:n]) = 1;
Aeq(2,[1:2:n]) = 1;

b = ones(contraintesInegalite,1);
beq = 2*ones(contraintesEgalite,1);


% Calcul de f

f=[1 1 0 0 1 1 1 1 0 0 1 1];

t=cputime;
x = intlinprog(f,[1:12],A,b,Aeq,beq,0,1);
tps = cputime-t;
display("Temps d'exécution de EDTsimple : " + tps*1000 + " ms");

%Reshape
xTemp = reshape(reshape(x,2,6)',3,4);
xFinal = zeros(3,2,2);
xFinal(:,:,1) = xTemp(:,1:2); %maths
xFinal(:,:,2) = xTemp(:,3:4); %info

display("Creneaux math");
xFinal(:,:,1)
display("Creneaux info");
xFinal(:,:,2) 


