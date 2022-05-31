clc
clear all
close all


% first problem

a = 1;   
b = 60000;
eps=10^-3;

%time - bisect
[xvect, xdif, fx, iterations] = bisect(a,b,eps,@compute_time);

%approximation
plot(1:iterations, xvect)
title("Problem 1 - przybliżenie - metoda bisekcji");
ylabel("Ilość parametrów wejściowych [N]");
xlabel("Iteracja");
saveas(gcf, 'problem1_przyblizenie_bisekcja.png');

%differences
semilogy(1:iterations, xdif)
title("Problem 1 - różnice - metoda bisekcji");
ylabel("Różnica między poprzednią i aktualną wartością N");
xlabel("Iteracja");
saveas(gcf, 'problem1_roznice_bisekcja.png');


%time - secand
[xvect,xdif,fx,iterations] = secand(a, b, eps, @compute_time);

%approximation
plot(1:iterations, xvect)
title("Problem 1 - przybliżenie - metoda siecznych");
ylabel("Ilość parametrów wejściowych [N]");
xlabel("Iteracja");
saveas(gcf, 'problem1_przyblizenie_sieczne.png');

%differences
semilogy(1:iterations, xdif)
title("Problem 1 - różnice - metoda siecznych");
ylabel("Różnica między poprzednią i aktualną wartością N");
xlabel("Iteracja");
saveas(gcf, 'problem1_roznice_sieczne.png');


% second problem

a = 0;   
b = 50;
eps=10^-12;

%impedance - bisect
[xvect,xdif,fx,iterations] = bisect(a,b, eps, @compute_impedance);

%approximation
plot(1:iterations, xvect)
title("Problem 2 - przybliżenie - metoda bisekcji");
ylabel("Przybliżona wartość prędkości kątowej omega[rad/s]");
xlabel("Iteracja");
saveas(gcf, 'problem2_przyblizenie_bisekcja.png');

%differences
semilogy(1:iterations, xdif)
title("Problem 2 - różnice - metoda bisekcji");
ylabel("Różnica między poprzednią i aktualną wartością prędkości kątowej omega[rad/s]");
xlabel("Iteracja");
saveas(gcf, 'problem2_roznice_bisekcja.png');


%impedance - secand
[xvect,xdif,fx,iterations] = secand(a,b, eps, @compute_impedance);

%approximation
plot(1:iterations, xvect)
title("Problem 2 - przybliżenie - metoda siecznych");
ylabel("Przybliżona wartość prędkości kątowej omega[rad/s]");
xlabel("Iteracja");
saveas(gcf, 'problem2_przyblizenie_sieczne.png');

%differences
semilogy(1:iterations, xdif)
title("Problem 2 - różnice - metoda siecznych");
ylabel("Różnica między poprzednią i aktualną wartością prędkości kątowej omega[rad/s]");
xlabel("Iteracja");
saveas(gcf, 'problem2_roznice_sieczne.png');


% third problem

a = 0;   
b = 50;
eps=10^-12;

%speed - bisect
[xvect,xdif,fx,iterations] = bisect(a,b, eps, @compute_speed);

%approximation
plot(1:iterations, xvect)
title("Problem 3 - przybliżenie - metoda bisekcji");
ylabel("Przybliżona wartość czasu t[s]");
xlabel("Iteracja");
saveas(gcf, 'problem3_przyblizenie_bisekcja.png');

%differences
semilogy(1:iterations, xdif)
title("Problem 3 - różnice - metoda bisekcji");
ylabel("Różnica między poprzednią i aktualną wartością czasu t[s]");
xlabel("Iteracja");
saveas(gcf, 'problem3_roznice_bisekcja.png');

%speed - secand
[xvect,xdif,fx,iterations] = secand(a,b, eps, @compute_speed);

%approximation
plot(1:iterations, xvect)
title("Problem 3 - przybliżenie - metoda siecznych");
ylabel("Przybliżona wartość czasu t[s]");
xlabel("Iteracja");
saveas(gcf, 'problem3_przyblizenie_sieczne.png');

%differences
semilogy(1:iterations, xdif)
title("Problem 3 - różnice - metoda siecznych");
ylabel("Różnica między poprzednią i aktualną wartością czasu t[s]");
xlabel("Iteracja");
saveas(gcf, 'problem3_roznice_sieczne.png');


%zad 3
options = optimset('Display','iter');
fzero(@tan,6, options)
fzero(@tan,4.5, options)


