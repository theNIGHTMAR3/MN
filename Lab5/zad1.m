clc
clear all
close all

%wartości dla kolejnych K
K = [5, 15, 25, 35];

[XX,YY]=meshgrid(linspace(0,100,101),linspace(0,100,101));
counter=1;

%pętla po wartościach K
for i=K
    %funckja łazika
    [x,y,f,xp,yp]=lazik(i);

    %ruch lazika
    subplot(2,2,1);
    plot(xp,yp,'-o','linewidth',1)
    %plot(xp,yp,'-o','linewidth',3)
    title("Tor ruchu łazika dla K = "+i)
    xlabel("x [m]")
    ylabel("y [m]")

    %wartości zebranych próbek
    subplot(2,2,2);
    plot3(x,y,f,'o')
    title("Wartości zebranych próbek dla K = "+ i)
    xlabel("x [m]")
    ylabel("y [m]")  
    zlabel("wartość f(x,y)")
    grid()

    %obliczenia dla rozkładu wielomianowego
    %parametry do rozkładu
    [p] = polyfit2d( x,y,f ); %wektor jednokolumnowy zawierający wartości współczynników interpolacji wielomianowej
    %wizualizacja punków przez interpolacje wielomianową
    [FF] = polyval2d(XX,YY,p);

    subplot(2,2,3);
    surf(XX,YY,FF);
    shading flat;

    %rozkład promieniowania, interpolacja wielomianowa
    title("Interpolacja wielomianowa dla K = "+i);
    ylabel("y [m]");
    xlabel("x [m]");
    zlabel("wartość f(x,y)");
    
    %obliczenia dla rozkładu trygonometrycznego
    %parametry do rozkładu
    [p] = trygfit2d( x,y,f ); %wektor jednokolumnowy zawierający wartości współczynników interpolacji trygonometrycznej
    %wizualizacja punków przez interpolacje trygonometryczną
    [FF] = trygval2d(XX,YY,p);

    subplot(2,2,4);
    surf(XX,YY,FF);
    shading flat;

    %rozkład promieniowania, interpolacja trygonemtryczna
    title("Interpolacja trygonometryczna dla K = "+i);
    ylabel("y [m]");
    xlabel("x [m]");
    zlabel("wartość f(x,y)");

    %nazwa pliku
    name='Plot';
    name=name+string(counter);
    name=name+'_K=';
    name=name+string(i);
    name=name+'.png';
    saveas(gcf,name);
    

    counter=counter+1;

end
