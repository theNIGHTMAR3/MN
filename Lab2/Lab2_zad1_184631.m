function zad1()
    N = 7;
    d=0.85;
    Edges=[1,1,2,2,3,3,3,4,4,5,5,6,6,7;
           4,6,4,3,6,7,5,6,5,6,4,4,7,6,];
    I=speye(N);
    B = sparse(Edges(2, :), Edges(1, :),1);
    
    L=sum(B);
    A=speye(N)./L;
    
    M=sparse(I-d*B*A);
    
    b=((1-d)/N)*ones(N,1);
    
    r=M\b;
    
    bar(r)

end