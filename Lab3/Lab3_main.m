clc
clear all
close all

diary('log_184631_lab3');

% odpowiednie fragmenty kodu można wykonać poprzez znazaczenie i wciśnięcie F9
% komentowanie/ odkomentowywanie: ctrl+r / ctrl+t

% Zadanie A
%------------------
N = 10;
d = 0.85;
density = 3; % parametr decydujący o gestosci polaczen miedzy stronami
[Edges] = generate_network(N, density,184631);
%-----------------

% Zadanie B
%------------------
% generacja macierzy I, A, B i wektora b
% ...
I = speye(N);

B = sparse(Edges(2,:),Edges(1,:),1);

A = speye(N)./sum(B);  

%kolumnowa macież N wartości (1-d)/N
b=((1-d)/N)*ones(N,1);


% macierze A, B i I muszą być przechowywane w formacie sparse (rzadkim)
issparse(B)
issparse(A)
issparse(I)

save zadB_184631 A B I b
%-----------------

% Zadanie C
%------------------
M=sparse(I-d*B*A);
r=M\b;

save zadC_184631 r


% Zadanie D
%------------------
clc
clear all
close all

N = [500, 1000, 3000, 6000, 12000];
d=0.85;
density=10;


% for i = 1:5
%     [Edges] = generate_network(N(i),density);
%     B = sparse(Edges(2,:),Edges(1,:),1,N(i),N(i));
%     A = sparse(diag(1./sum(B)));  % macierze A, B i I muszą być przechowywane w formacie sparse (rzadkim)
%     I = speye(N(i));
%     b=zeros(N(i),1);
%     b(:,1) = (1-d)/N(i);
%     M=sparse(I-d*B*A);
% 
% 
% tic
% r=M\b;
% czas_Gauss(i) = toc;
% end
% 
% plot(N, czas_Gauss)
% title("Zadanie D")
% xlabel("rozmiar macierzy")
% ylabel("Czas [s]")
% saveas(gcf,"zadD_184631.png")

%------------------


% Zadanie E
%------------------
clc
clear all
close all
N = [500, 1000, 3000, 6000, 12000];
iterations=zeros(size(N));

max_residuum=10^(-14);
d=0.85;
density=10;

for i = 1:5
    [Edges] = generate_network(N(i),density);
    B = sparse(Edges(2,:),Edges(1,:),1,N(i),N(i));
    A = sparse(diag(1./sum(B)));  
    I = speye(N(i));
    b=zeros(N(i),1);
    b(:,1) = (1-d)/N(i);
    M=sparse(I-d*B*A);

    %kolumna N(i) jedynek
    x=ones(N(i),1);

    %trójkąty
    L=tril(M,-1);
    U=triu(M,1);

    %macierz zerowa, zawierająca wartości na diagonali
    D=diag(diag(M));

    %podzielone wyrażenia
    exp1=-D\(L+U);
    exp2=D\b;

    tic
    while(true)
       iterations(i) =iterations(i)+ 1;
       x=exp1*x+exp2;
       res=M*x-b;
       res_y(i,iterations(i))=norm(res);

       %break jeśli norma zbyt duża
       if(norm(res)<=max_residuum)
            break;
       end
    
    end
    czas_Jacobi(i) = toc;
end

%1 wykres
plot(N, czas_Jacobi)
title("Zadanie E - czas")
xlabel("rozmiar macierzy")
ylabel("Czas [s]")
saveas(gcf,"zadE_184631_1.png")

%2 wykres
plot(N, iterations)
title("Zadanie E - iteracje")
xlabel("rozmiar macierzy")
ylabel("liczba iteracji")
saveas(gcf,"zadE_184631_2.png")

%3 wykres
semilogy(res_y(2,1:iterations(2)))
title("Zadanie E - norma z residuum dla macierzy N=1000")
xlabel("iteracja")
ylabel("norma z residuum")
saveas(gcf,"zadE_184631_3.png")
 %------------------

% Zadanie F
%------------------
 clc
 clear all
 close all

 N = [500, 1000, 3000, 6000,12000];
 iterations=zeros(size(N));
 max_residuum=10^(-14);
 d=0.85;
 density=10;


for i = 1:5
    [Edges] = generate_network(N(i),density);
    B = sparse(Edges(2,:),Edges(1,:),1,N(i),N(i));
    A = sparse(diag(1./sum(B)));  
    I = speye(N(i));
    b=zeros(N(i),1);
    b(:,1) = (1-d)/N(i);
    M=sparse(I-d*B*A);

    %kolumna N(i) jedynek
    x=ones(N(i),1);

    %trójkąty
    L=tril(M,-1);
    U=triu(M,1);

    %macierz zerowa, zawierająca wartości na diagonali
    D=diag(diag(M));

    %podzielone wyrażenia
    exp1=-(D+L);
    exp2=(D+L)\b;

    tic
    while(true)
       iterations(i) = iterations(i)+ 1;
       x=exp1\(U*x)+exp2;
       res=M*x-b;
       res_y(i,iterations(i))=norm(res);

       %break jeśli norma zbyt duża
       nanCheck=isnan(norm(res));
       if(norm(res)<=max_residuum || nanCheck==true)
            break;
       end
    
    end
    czas_Gauss_Seidl(i) = toc;
end

%1 wykres
plot(N, czas_Gauss_Seidl)
title("Zadanie F - czas")
xlabel("rozmiar macierzy")
ylabel("Czas [s]")
saveas(gcf,"zadF_184631_1.png")

%2 wykres
plot(N, iterations)
title("Zadanie F - iteracje")
xlabel("rozmiar macierzy")
ylabel("liczba iteracji")
saveas(gcf,"zadF_184631_2.png")

%3 wykres tylko dla N=1000
semilogy(res_y(2,1:iterations(2)))
title("Zadanie F - norma z residuum dla macierzy N=1000")
xlabel("iteracja")
ylabel("norma z residuum")
saveas(gcf,"zadF_184631_3.png")
%------------------


% Zadanie G
%------------------
 clc
 clear all
 close all

 N = [500, 1000, 3000, 6000,12000];
 iterations(1)=0;
 iterations(2)=0;
 max_residuum=10^(-14);
 d=0.85;
 density=10;

 load("Dane_Filtr_Dielektryczny_lab3_MN.mat")

 tic 
 r=M\b;
 time_counter(1)=toc;

 disp("czas dla metody bezpośredniej: "+time_counter(1))

%Jacobiego
x=ones(20000,1);
L=tril(M,-1);
U=triu(M,1);
D=diag(diag(M));

exp1=-D\(L+U);
exp2=D\b;

tic

while (true)
    x=exp1*x+exp2;
    res=M*x-b;
    nanCheck=isnan(norm(res));
    if(norm(res)<=max_residuum || nanCheck==true)
        break;
    end
end

time_counter(2)=toc;

disp("czas dla metody Jacobiego: "+time_counter(2))

if (isnan(norm(res)))
    disp("metoda Jacobiego jest rozbieżna")
end

if(D\(L+U)<1)
    disp("metoda Jacobiego jest zbieżna")
end


%Gaussa-Seidlera
x=ones(20000,1);
L=tril(M,-1);
U=triu(M,1);
D=diag(diag(M));


tic

while (true)
    x=-(D+L)\(U*x)+(D+L)\b; %przybliżenie
    res=M*x-b; % residuum, maksymalny błąd, o który możemy się pomylić
    if(norm(res)<=max_residuum || isnan(norm(res)))
        break;
    end
end

time_counter(3)=toc;
disp("czas dla metody Gaussa-Seidla")

if (isnan(norm(res)))
    disp("metoda Gaussa-Seidla jest rozbieżna")
else 
    disp("-")
end










