clc
clear all
close all

%inicjalizacja tablic
poly_div=[];
try_div=[];


[XX,YY]=meshgrid(linspace(0,100,101),linspace(0,100,101));

%główna pętla
for i = 5:45

     %lazik
    [x,y,f]=lazik(i);

    %parametry do rozkładu
    [p] = polyfit2d( x,y,f );

    %wizualizacja punków przez interpolacje wielomianową
    [FF_poly] = polyval2d(XX,YY,p);

    %parametry do rozkładu
    [p] = trygfit2d( x,y,f );

    %wizualizacja punków przez interpolacje trygonometryczną
    [FF_try] = trygval2d(XX,YY,p);

    %pierwsze wywołanie, brak wartości poprzedniej
    if i==5
        %ustawienie pierwszych wartości na poprzednie
        prev_FF_poly=FF_poly;
        prev_FF_try=FF_try;
    %kolejne wywołania pętli
    else
        %obliczanie różnicy wartości macierzy
        poly_div=[ poly_div, max(max(abs(FF_poly-prev_FF_poly)))];
        try_div=[ try_div, max(max(abs(FF_try-prev_FF_try)))];

        %ustawienie aktualnych wartości na poprzednie
        prev_FF_poly=FF_poly;
        prev_FF_try=FF_try;
    end
end

%wykres zbieżności interpolacji wielomianowej
%omijamy pierwszą wartość, poniważ dla niej nie ma poprzedniej
plot(6:45,poly_div)
title("Zbieżność metody interpolacji wielomianowej")
xlabel("Punkty pomiarowe - K")
ylabel("Max wartość różnicy funkcji")
saveas(gcf,"Zbieżność interpolacji wielomianowej.png")

%wykres zbieżności interpolacji trygonometrycznej
%omijamy pierwszą wartość, poniważ dla niej nie ma poprzedniej
plot(6:45,try_div)
title("Zbieżność metody interpolacji trygonometrycznej")
xlabel("Punkty pomiarowe - K")
ylabel("Max wartość różnicy funkcji")
saveas(gcf,"Zbieżność interpolacji trygonometrycznej.png")



