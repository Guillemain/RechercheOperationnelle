NSUC = uint16([2 0 3 1 2 3 2 2]);
SUC = uint16([3 4 4 5 6 8 6 7 4 7 8 5 2 7 2]);
LONG = [1 2 5 3 3 2 0 3 1 3 7 2 1 2 4];
[theta,PLUSCOURTCHEMIN, longueur] = Tension (NSUC, SUC, LONG, 1, 2);


POS=[0 1 0; 3 0 4; 0 6 0; 5 0 8;0 7 0; 0 0 2]';
csvwrite("./4test/pos_tension.csv", POS)

[~, rep_courant]=system('pwd')
status=unix(strcat(rep_courant,'/show_result.sh 3test/Depart.csv 3test/Result.csv 3test/Mat_P flot4'));
