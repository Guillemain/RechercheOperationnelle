%% Deformation de trajectoire
%
% Il faut compléter ce code pour effectuer une déformation géométrique du
% chemin emprunté par le robot 1 afin qu'il évte les collisions avec les
% autres robots !!
%
% Existe-t-il une trajectoire dans la scene ?
if ~exist('T','var')
    cprintf('red', 'Il n''y a pas de trajectoire dans cette scene !');
    disp(' ')
    return
end
%%
if isfield(T,'nbrecollision')
    nbrecollision = T(1).nbrecollision;
    if all(nbrecollision == zeros(nbremaxobj,1))
        cprintf('blue',['L''objet 1 ne rentre pas en collision dans la scene ',NOMSCENE]);
        disp(' ')
        return
    else
%%       Il y a au moins une collision entre l'objet 1 et un autre objet
        %
        % On applique un algorithme de deformation du chemin emprunté par
        % le robot 1 pour qu'il evite les collisions
        %
        collision(1,:,:,:) = T(1).collision;
        cprintf('[1,0.5,0]','Il y a au moins une collision entre l''objet 1 et un autre objet');
        disp(' ');
        cprintf([1,0,1],'On change la trajectoire de l''objet 1');
        disp(' ');
%% ---------------------------------------------------------------------
        x_pts_controle = T(1).nurbs.coefs(1,:)./T(1).nurbs.coefs(4,:);%On récupère les points de controle du robot 1
        y_pts_controle = T(1).nurbs.coefs(2,:)./T(1).nurbs.coefs(4,:);
        for k=2:nombre_objets
            % on regarde s'il y a eu collision de l'objet 1 avec l'objet k
            if nbrecollision(k) > 0
                cprintf('[1,0.5,0]','Il y a une collision entre l''objet 1 et un l''objet %d',k);
                disp(' ');
%                 Deformation_trajectoire2;
                % il y a eu collision de l'objet 1 avec l'objet k
                nocollision = 1;
                %
                % on supposera par la suite qu'il n'y a eu qu'une seule collision de 1 avec k !!!
                %
                collision(k,:,:,:) = T(k).collision;
                % Determination du nocollision-eme pt de collision de 1
                % avec k
                pt_collision = [collision(1,k,1,nocollision) collision(1,k,2,nocollision)] ;
                %
                nbre_pts_controle = T(1).nurbs.number;
                % Calcul de la distance minimale du pt de collision aux
                % segments [Pi , Pi+1]
                % La fonction point_to_segment est a ecrire !!!!
                dmin = inf;
                for i = 1:nbre_pts_controle - 1
                    d = point_to_segment(pt_collision(1),pt_collision(2), ...
                        x_pts_controle(i),y_pts_controle(i),x_pts_controle(i+1),y_pts_controle(i+1));
                    if d < dmin
                        dmin = d;
                        iref = i;
                    end
                end
                % le nouveau pt de contrôle qui est construit à partir du pt de collision doit
                % être inséré entre les pts de contrôle Piref et Piref+1
                deplacement(1) = collision(1,k,1,nocollision) - collision(k,1,1,nocollision);
                deplacement(2) = collision(1,k,2,nocollision) - collision(k,1,2,nocollision);
                %
                % Calcul de lambda
                %
                sumray = (T(1).diametre_robot + T(k).diametre_robot)/2 ; % somme des rayons de 1 et de k
                marge = 1; % valeur de la marge en unites pixels  pour le calcul de lambda
                lambda = (sumray + marge)/norm(deplacement);
                %
                nouveau_pt_controle(1) = pt_collision(1) + lambda * deplacement(1); %Coordonnées du nouveau point de contrôle
                nouveau_pt_controle(2) = pt_collision(2) + lambda * deplacement(2);
               
                %On regarde si le nouveau point de controle est dans un mur
                %Si il y est on réduit son poids
                mur = 1;
                if (im(floor(nouveau_pt_controle(1)),floor(nouveau_pt_controle(2))) == 7 ||  im(floor(nouveau_pt_controle(1))+1,floor(nouveau_pt_controle(2))) == 7 ...
                   || im(floor(nouveau_pt_controle(1)),floor(nouveau_pt_controle(2))+1) == 7 ||  im(floor(nouveau_pt_controle(1))+1,floor(nouveau_pt_controle(2)+1)) == 7)
                     mur = 0.1;
                     cprintf('red','Nouveau point de contrôle dans un mur');
                end
               
               
               poids_n_pt_c = (T(1).nurbs.coefs(4,iref)+T(1).nurbs.coefs(4,iref))/2 * 10 * mur; % Il faut donner un poids fort au nouveau pt de controle issu de la collisuon
                
               %On rajoute le nouveau points de contrôle entre les deux
               %points de contrôle encadrant le point de collision
                T(1).nurbs.coefs(1,iref+1:nbre_pts_controle + 1) = [nouveau_pt_controle(1)*poids_n_pt_c T(1).nurbs.coefs(1,iref+1:nbre_pts_controle)]; 
                T(1).nurbs.coefs(2,iref+1:nbre_pts_controle + 1) = [nouveau_pt_controle(2)*poids_n_pt_c T(1).nurbs.coefs(2,iref+1:nbre_pts_controle)];
                T(1).nurbs.coefs(3,:) = 0;
                T(1).nurbs.coefs(4,iref+1:nbre_pts_controle + 1) = [poids_n_pt_c T(1).nurbs.coefs(4,iref+1:nbre_pts_controle)];
                
                nbre_pts_controle = nbre_pts_controle + 1;
                T(1).nurbs.number = nbre_pts_controle;
             
                % Calcul du vecteur nodal
                order = T(1).nurbs.order;
                V = vecnod(order,nbre_pts_controle); % la fonction vecnod est a ecrire !!!
                T(1).nurbs.knots = V;
                
                break;
            end
        end
%---------------------------------------------------------------------
%%
    end
    else
        cprintf('[1,0.5,0]',['On ignore si l''objet 1 rentre en collision dans la scene ',NOMSCENE]);
        disp(' ');
        cprintf('[1,0.5,0]','Pour le savoir lancer la simulation'); 
        disp(' ');
end