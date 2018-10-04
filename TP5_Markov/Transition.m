function P = Transition(D, S, s)
    V=fliplr(D);
    V(1)=sum(D(S:end));
    
    P=zeros(S+1,S+1);
    P([[1:s],S+1],:)=V;
    
    for i = s+1 : S 
        P(i,[2:i])=fliplr(D(1:i-1));
        P(i,1)=sum(D(i:end));  
end