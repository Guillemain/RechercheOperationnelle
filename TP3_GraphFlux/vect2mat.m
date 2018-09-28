function [matrice] = vect2mat(NSUC, SUC, LONG)
    n = size(NSUC,2);
    m = sum(NSUC);
    matrice=zeros(n,n);
    pos=0;
    for i=1:n
        for j=1:NSUC(i)
            matrice(i,SUC(j+pos))=LONG(j+pos);
        end
        pos=pos+NSUC(i);
    end        
end