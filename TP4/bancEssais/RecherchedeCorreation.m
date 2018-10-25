%% Recherche de correllations sur y(x) :
%
%
%
%
k = 10;
A = [gy(k:end)' ones(1,size(gy(k:end)))];
Y = gx(k-1,end-1);
Coef = A\Y;
disp(Coef);