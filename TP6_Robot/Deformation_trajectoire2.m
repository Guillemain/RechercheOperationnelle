%% Deformation de trajectoire
x_pts_controle_k = T(k).nurbs.coefs(1,:)./T(k).nurbs.coefs(4,:);%collision(1,2,1,1);
y_pts_controle_k = T(k).nurbs.coefs(2,:)./T(k).nurbs.coefs(4,:);%collision(1,2,2,1);
% on regarde s'il y a eu collision de l'objet 1 avec l'objet k
% il y a eu collision de l'objet 1 avec l'objet k
%
% on supposera par la suite qu'il n'y a eu qu'une seule collision de 1 avec k !!!
%
nocollision=1;
collision(k,:,:,:) = T(k).collision;
% Determination du nocollision-eme pt de collision de 1
% avec k
pt_collision_k = [collision(k,1,1,1) collision(k,1,2,1)] ;
%
nbre_pts_controle_k = T(k).nurbs.number;
% Calcul de la distance minimale du pt de collision aux
% segments [Pi , Pi+1]
% La fonction point_to_segment est a ecrire !!!!
dmin = inf;
for i = 1:nbre_pts_controle_k - 1
    d = point_to_segment(pt_collision_k(1),pt_collision_k(2), ...
        x_pts_controle_k(i),y_pts_controle_k(i),x_pts_controle_k(i+1),y_pts_controle_k(i+1));
    if d < dmin
        dmin = d;
        iref = i;
    end
end
% le nouveau pt de contrôle qui est construit à partir du pt de collision doit
% être inséré entre les pts de contrôle Piref et Piref+1
%
%
deplacement_k(1) = collision(k,1,1,nocollision) - collision(1,k,1,nocollision);
deplacement_k(2) = collision(k,1,2,nocollision) - collision(1,k,2,nocollision);
%
% Calcul de lambda
%
sumray = (T(1).diametre_robot + T(k).diametre_robot)/2 ; % somme des rayons de 1 et de k
marge = 1; % valeur de la marge en unites pixels  pour le calcul de lambda
lambda = (sumray + marge)/norm(deplacement_k);
%
nouveau_pt_controle_k(1) = pt_collision_k(1) + lambda * deplacement_k(1);
nouveau_pt_controle_k(2) = pt_collision_k(2) + lambda * deplacement_k(2);

mur_k = 1;
if (im(floor(nouveau_pt_controle_k(1)),floor(nouveau_pt_controle_k(2))) == 7 ||  im(floor(nouveau_pt_controle_k(1))+1,floor(nouveau_pt_controle_k(2))) == 7 ...
   || im(floor(nouveau_pt_controle_k(1)),floor(nouveau_pt_controle_k(2))+1) == 7 ||  im(floor(nouveau_pt_controle_k(1))+1,floor(nouveau_pt_controle_k(2)+1)) == 7)
     mur_k = 0.01;
     cprintf('red','Nouveau point de contrôle dans un mur');
     disp(' ');
end


poids_n_pt_c_k = (T(k).nurbs.coefs(4,iref)+T(k).nurbs.coefs(4,iref))/2 * 10*mur_k; % Il faut donner un poids fort au nouveau pt de controle issu de la collisuon
%
T(k).nurbs.coefs(1,iref+1:nbre_pts_controle_k + 1) = [nouveau_pt_controle_k(1)*poids_n_pt_c_k T(k).nurbs.coefs(1,iref+1:nbre_pts_controle_k)];
T(k).nurbs.coefs(2,iref+1:nbre_pts_controle_k + 1) = [nouveau_pt_controle_k(2)*poids_n_pt_c_k T(k).nurbs.coefs(2,iref+1:nbre_pts_controle_k)];
T(k).nurbs.coefs(3,:) = 0;
T(k).nurbs.coefs(4,iref+1:nbre_pts_controle_k + 1) = [poids_n_pt_c_k T(k).nurbs.coefs(4,iref+1:nbre_pts_controle_k)];
%
nbre_pts_controle_k = nbre_pts_controle_k + 1;
T(k).nurbs.number = nbre_pts_controle_k;
%
% Calcul du vecteur nodal
order = T(k).nurbs.order;
V_k = vecnod(order,nbre_pts_controle_k); % la fonction vecnod est a ecrire !!!
T(k).nurbs.knots = V_k;

