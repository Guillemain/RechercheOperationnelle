function [jour,creneau] = pos2creneaux(position,t)
%t = nombre de créneau dans une journée

q = fix(position/t);
r = mod(position,t);
    
if r == 0 
   jour = q;
   creneau = t;
else
   jour = q+1;
   creneau = r;
end

end