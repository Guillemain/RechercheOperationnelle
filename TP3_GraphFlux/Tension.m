%% Algorithme de *Ford-Fulkerson* pour les tensions
%
% Application à la recherche du plus court chemin du sommet depart au
% sommet arrive
% dans un graphe (X,U) modélisé comme un problème de tension maximale
%
% Representation du graphe
% Vecteur du nombre de successeurs de chaque sommet :       NSUC
% Vecteur des indices des successeurs de chaque sommet :    SUC
% Vecteur des longueurs des arcs :                          LONG
% Point de depart :                                         depart
% Point d'arrive :                                          arrive
% Rajout automatique de la liaison infinie entre depart et arrive

function [theta, Chemin, longueur] = Tension (NSUC, SUC, LONG, depart, arrive)

    %% Initialisations
    % On ajoute la liaison de depart a arrive
    NSUC(depart)=NSUC(depart)+1;
    offset=NSUC(depart);
    start=sum(NSUC(1:depart-1))+1;
    % On ajoute l'arrive de la liaison
    SUC=[SUC(1:start-1) arrive SUC(start:end)];
    % On rajoute la longueur infinie
    LONG=[LONG(1:start-1) inf LONG(start:end)];
    
    n = size(NSUC,2);
    X = uint16(1:n); % X contient la liste des sommets de G
    m = sum(NSUC);
    % Vecteur de la tension courante theta
    theta = zeros(1,m);
    %
    MARQUE = false(1,n); % MARQUE est un vecteur logique
    MARQUE(arrive) = true; % on marque le sommet arrive
    %
    NONMARQUES = X(~MARQUE); % NONMARQUES contient la liste des sommets non marqués
    %
    PLUSCOURTCHEMIN = uint16(zeros(1,n)); % Vecteur du plus court chemin de depart à arrive
    PLUSCOURTCHEMIN(1) = depart;
    %
    %% Algorithme de FF
    while ismember(depart,NONMARQUES) % Tant que depart non marqué
        CANDIDATS = false(1,n); % CANDIDATS est un vecteur logique contenant les candidats à
        % être marqués
        %
        %% 1.   MAJ tension courante theta
        beta = inf;
        vcocycle = zeros(1,m); % vecteur cocycle des sommets non marqués
        for l=1:size(NONMARQUES,2)
            i = NONMARQUES(l); % i est non marqué
            if NSUC(i) ~= 0 % le nombre de successeurs de i est non nul
                prsuc = sum(NSUC(1:i-1)) + 1; % prsuc contient l'indice du 1er successeur de i dans SUC
                for k = prsuc:prsuc+NSUC(i)-1
                    j = SUC(k); % (i,j) est un arc
                    if MARQUE(j)
                        % j est un sommet marqué (et i est nonmarqué donc (i,j)
                        % appartient au cocycle
                        % donc i est candidat à être marqué
                        CANDIDATS(i) = true;
                        beta = min(beta,LONG(k)-theta(k)); % beta > 0
                        vcocycle(k) = 1;
                    end
                end
            end
        end
        
        %Successeurs des Sommets marqués
       MARQUES=find(MARQUE==1);
       for l=1:size(MARQUES,2)
            i = MARQUES(l); % i est marqué
            if NSUC(i) ~= 0 % le nombre de successeurs de i est non nul
                prsuc = sum(NSUC(1:i-1)) + 1; % prsuc contient l'indice du 1er successeur de i dans SUC
                for k = prsuc:prsuc+NSUC(i)-1
                    j = SUC(k); % (i,j) est un arc
                    if MARQUE(j) == 0
                        % j est un sommet nonmarqué (et i est marqué donc (i,j)
                        % appartient au cocycle
                        vcocycle(k) = -1;
                    end
                end
            end
        end
                
        
        theta = theta + beta*vcocycle; %MAJ theta
        
        
        
        %
        %% 2.   Marquer sommets
        liste_candidats_marquage = X(CANDIDATS);
        for l=1:size(liste_candidats_marquage,2)
            i = liste_candidats_marquage(l); % i est non marqué et candidat à être marqué
            if NSUC(i) ~= 0
                % le nombre de successeurs de i est non nul
                prsuc = sum(NSUC(1:i-1)) + 1; % prsuc contient l'indice du 1er successeur de i dans SUC
                for k = prsuc:prsuc+NSUC(i)-1
                    j = SUC(k); % j est successeur du sommet i candidat au marquage
                    if MARQUE(j) && theta(k) == LONG(k)
                        % i est non marqué , j est marqué, (i,j) est un arc (de numéro k) , et la
                        % valeur de la tension sur cet arc est égale à la longueur
                        % de l'arc (i,j)
                        % donc on marque i
                        MARQUE(i) = true; % on marque le sommet i
                        NONMARQUES = setdiff(NONMARQUES,i); % on enlève i des sommets non marqués
                    end
                end
            end
        end
    end
    %% 3. Post-traitement : extraction du plus court chemin
    i = depart;
    prsuc = sum(NSUC(1:depart-1))+1;
    nsom = 1;
    while i ~= arrive
        for k = prsuc:prsuc+NSUC(i)-1
            j = SUC(k);
            if theta(k) == LONG(k)
                nsom = nsom + 1;
                PLUSCOURTCHEMIN(nsom) = j;
                break;
            end
        end
        i=j;
        prsuc = sum(NSUC(1:i-1)) + 1;
    end
    %
    
    % Recuperation de la longueur du plus court chemin
    indice=start -1 + find(SUC(start:start+offset)==arrive);
    longueur=theta(indice);
    Chemin=PLUSCOURTCHEMIN(1:nsom);
    disp (['Plus court chemin : ',num2str(PLUSCOURTCHEMIN(1:nsom))]);
    disp (['Longueur du plus court chemin : ', num2str(theta(indice))]);
    theta=[theta(1:start-1) theta(start+1:end)];
    
end
