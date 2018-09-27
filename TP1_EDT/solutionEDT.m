function x = solutionEDT()

%---------------------- Déclaration des variables ------------------------- 
d = 5; % nb de jours de cours
t = 4; % nb de crenaux par jours
c = 2; % nb de promo
p = 8; % nb de profs 

contraintesInegalite = c*d*t + p*d*t + p*c*d;
contraintesEgalite = 2 + p*c + 2 + 2*4 + p*c;

n = p*c*d*t;

A = zeros(contraintesInegalite,n); 
Aeq = zeros(contraintesEgalite,n);

%% Matrice des contraintes A

% les c*d*t premières lignes, contraintes (3)
for j = 1:d*t*c
    A(j,[j:c*d*t:end]) = 1;
end

%% les p*d*t lignes d'après, contraintes (4)
for l = 1:p*t*d/2
    A(l + d*t*c,[l,d*t+l]) = 1;
end

for l = p*t*d/2+1 : p*t*d
    A(l + d*t*c,[l+t*d,d*t+l+d*t]) = 1;
end

%% les p*d*c lignes d'après, contraintes (5)
for j = 1:p*c*d
    A(j + c*d*t + p*d*t,[(j-1)*t+1:j*t]) = 1;
end

%% Matrice des contraintes Aeq

% Contrainte 2
for i = 0:p*c-1
    Aeq(1+i,[i*d*t+1:(i+1)*d*t]) = 1;   
end

%% Contrainte 6
Aeq(p*c+1,12*d*t+15) = 1;
 
%% Contrainte 7
Aeq(p*c+2,15*d*t+15) = 1;

%% Conrainte 8
for i = 1:p*c
     Aeq(p*c+2+i,(i-1)*d*t+1) = 1;
end

%% Contrainte 9
Aeq(2*p*c+3,7*d*t+1) = 1;
Aeq(2*p*c+4,7*d*t+2) = 1;

%% Contrainte 10
Aeq(2*p*c+5,2*d*t+9) = 1;
Aeq(2*p*c+6,2*d*t+10) = 1;
Aeq(2*p*c+7,2*d*t+11) = 1;
Aeq(2*p*c+8,2*d*t+12) = 1;
Aeq(2*p*c+9,3*d*t+9) = 1;
Aeq(2*p*c+10,3*d*t+10) = 1;
Aeq(2*p*c+11,3*d*t+11) = 1;
Aeq(2*p*c+12,3*d*t+12) = 1;

%%
b = ones(contraintesInegalite,1);

% Il peut y avoir 2 cours d'info dans une même journée
b([4*c*d + 1 + c*d*t + p*d*t : 6*c*d + c*d*t + p*d*t]) = 2;

%%
beq = zeros(contraintesEgalite,1);

beq([1:4]) = 3;
beq(5) = 5;
beq(8) = 4;
beq(9) = 6;
beq(12) = 6;
beq(13) = 1;
beq(16) = 1;

beq(p*c+1) = 1;  %(6)
beq(p*c+2) = 1;   %(7)

%%
f = zeros(1,n);
f([1:t:n]) = 1;
f([t:t:n]) = 1;

%%
ub = ones(1,p*d*c*t);
lb = zeros(1,p*d*c*t);

x = intlinprog(f,[1:n],A,b,Aeq,beq,lb,ub);

end


