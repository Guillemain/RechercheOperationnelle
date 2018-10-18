% Creation du graphe pour le plus court chemin
% NSUC = uint16([3 1 3 2 2 3 2 1 1 1 0]);
% SUC = uint16([2 3 4 5 5 6 7 7 10 8 9 8 9 10 8 9 11 11 11]);
% LONG = [5 0 3 16 14 14 14 20 10 8 8 18 18 18 25 25 10 15 17];

NSUC = uint16([2 2 2 1 1 0]);
SUC = uint16([2 3 4 5 4 5 6 6]);
LONG = [4 2 3 3 2 2 5 10];

% Matrice de depart
mat_dep = vect2mat(NSUC, SUC, LONG);
csvwrite("./ordonnancement/mat_depart.csv", mat_dep)

% Resolution
[theta, longueur] = TensionOrdonnancement (NSUC, SUC, LONG, 1, 6);
% Met le bon format
resultat = vect2mat(NSUC, SUC, theta);
csvwrite("./ordonnancement/resultat.csv", resultat)

% Matrice des positions
% POS=[0 1 0; 3 0 4; 0 6 0; 5 0 8;0 7 0; 0 0 2]';
% csvwrite("./plus_court_chemin/pos_tension.csv", POS)

[~, rep_courant]=system('pwd');
%  status=unix(strcat(rep_courant,'/show_result.sh ordonnancement/mat_depart.csv ordonnancement/resultat.csv ./ordonnancement/Mat_position.csv ./ordonnancement/ordonnancement'));
