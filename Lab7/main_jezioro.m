clc
clear all
close all

%Zadanie A
load P_ref

%5 years
density=@gestosc;
fMin=0;
fMax=density(10);

sError=[];
tError=[];
simError=[];
mcError=[];

a=0;
b=5;

%N drawn points
for N=5:50:10^4

    %square method
    dx=(b-a)/N;
    sm=0;
     
    for i =1:N
        x_i=a+(i-1)*dx;
        x_i_1=a+i*dx;
        sm=sm+density((x_i+x_i_1)/2)*dx;
    end
    sError=[sError,abs(sm-P_ref)];

    %trapezoidal method
    dx=(b-a)/N;
    tm=0;
     
    for i =1:N
        x_i=a+(i-1)*dx;
        x_i_1=a+i*dx;
        tm=tm+(density(x_i)+density(x_i_1))/2*dx;
    end
    tError=[tError,abs(tm-P_ref)];


    %Simpson method
    dx=(b-a)/N;
    Sm=0;
     
    for i =1:N
        x_i=a+(i-1)*dx;
        x_i_1=a+i*dx;
        Sm=Sm+density(x_i)+4*density((x_i_1+x_i)/2)+density(x_i_1);        
    end
    Sm=Sm*dx/6;
    simError=[simError,abs(Sm-P_ref)];


    %Monte Carlo method
    fDiff=fMax-fMin;
    iDiff=b-a;

    counter=0;
     
    for i = 1: N
        %randomize points
        x=rand()*iDiff+a;
        y=rand()*fDiff+fMin;
    
        %calculate function
        f=density(x);
    
        %if point is above seafloor
        if y<=f && y>=fMin
            counter=counter+1;
        end
    end

    mcm=(counter/N)*abs(a-b)*abs(fMin-fMax);
    mcError=[mcError,abs(mcm-P_ref)];
    
end

%figures
x = 5:50:10^4;

figure();
loglog(x, sError);
title('Błąd metody prostokątów');
xlabel('Liczba przedziałów');
ylabel('Wartość błędu');
saveas(gcf, 'blad_metody_prostokatow.png')

figure();
loglog(x, tError);
title('Błąd metody trapezów');
xlabel('Liczba przedziałów');
ylabel('Wartość błędu');
saveas(gcf, 'blad_metody_trapezow.png')

figure();
loglog(x, simError);
title('Błąd metody Simpsona');
xlabel('Liczba przedziałów');
ylabel('Wartość błędu');
saveas(gcf, 'blad_metody_simpsona.png')

figure();
loglog(x, mcError);
title('Błąd metody Monte Carlo');
xlabel('Liczba punktów');
ylabel('Wartość błędu');
saveas(gcf, 'blad_metody_monte_carlo.png')

N=10^7;


%square method
tic
dx=(b-a)/N;
sm=0;
 
for i =1:N
    x_i=a+(i-1)*dx;
    x_i_1=a+i*dx;
    sm=sm+density((x_i+x_i_1)/2)*dx;
end
sTime=toc;

%trapezoidal method
tic
dx=(b-a)/N;
tm=0;
 
for i =1:N
    x_i=a+(i-1)*dx;
    x_i_1=a+i*dx;
    tm=tm+(density(x_i)+density(x_i_1))/2*dx;
end
tTime=toc;


%Simpson method
tic
dx=(b-a)/N;
Sm=0;
 
for i =1:N
    x_i=a+(i-1)*dx;
    x_i_1=a+i*dx;
    Sm=Sm+density(x_i)+4*density((x_i_1+x_i)/2)+density(x_i_1);
end
Sm=Sm*dx/6;
simTime=toc;


%Monte Carlo method
tic
fDiff=fMax-fMin;
iDiff=b-a;

counter=0;
 
for i = 1: N
    %randomize points
    x=rand()*iDiff+a;
    y=rand()*fDiff+fMin;

    %calculate function
    f=density(x);

    %if point is above seafloor
    if y<=f && y>=fMin
        counter=counter+1;
    end
end

mcm=(counter/N)*abs(a-b)*abs(fMin-fMax);
mcTime=toc;

figure();
x = categorical({'prostokątów', 'trapezów', 'Simpsona', 'Monte Carlo'});
x = reordercats(x,{'prostokątów', 'trapezów', 'Simpsona', 'Monte Carlo'});
y = [sTime tTime simTime mcTime];
bar(x,y); 
title('Czas wykonania wszytskich metod dla N = 10^7');
xlabel('Metoda');
ylabel('Czas [s]');
saveas(gcf,'czas_wykonania.png')


clc
clear all
close all

%------------------------------------------
load dane_jezioro   % dane XX, YY, FF sa potrzebne jedynie do wizualizacji problemu. 
surf(XX,YY,FF)
shading interp
axis equal
%------------------------------------------


%------------------------------------------
% Implementacja Monte Carlo dla f(x,y) w celu obliczenia objetosci wody w zbiorniku wodnym. 
% Calka = ?
% Nalezy skorzystac z nastepujacej funkcji:
% z = glebokosc(x,y); % wyznaczanie glebokosci jeziora w punkcie (x,y),
% gdzie x i y sa losowane
%------------------------------------------

%Zadanie B

fMin=-44;
fMax=0;
N = 1e5;

%x
xMin=0;
xMax=100;
%y
yMin=0;
yMax=100;
%z
zMin=-50;
zMax=0;

%differences
xDiff=xMax-xMin;
yDiff=yMax-yMin;
zDiff=zMax-zMin;

counter=0;

%for all points
for i = 1: N
    %randomize points
    x=rand()*xDiff+xMin;
    y=rand()*yDiff+yMin;
    z=rand()*zDiff+zMin;

    %calculate function
    f=glebokosc(x,y);

    %if point is above seafloor
    if z<=fMax && z>=f
        counter=counter+1;
    end
end

V=(counter/N)*abs(xMin-xMax)*abs(yMin-yMax)*abs(zMin-zMax)





