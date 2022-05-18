
%Zadanie 2
clc
clear all
close all
warning('off','all')

load trajektoria1

%Real
plot3(x,y,z,'o')
grid on
axis equal
title("Real trajectory");
xlabel("x");
ylabel("y");
zlabel("z");

saveas(gcf, '184631_Kuprianowicz_zad2.png')

%Zadanie 4

clc
clear all
close all
warning('off','all')

load trajektoria1

%Real
plot3(x,y,z,'o')
grid on
axis equal
hold on

%setting polynomial approximation
N = 50;
% x approximation
[ wsp, xa ] = aproksymacjaWiel(n,x,N); 
% y approximation.
[ wsp, ya ] = aproksymacjaWiel(n,y,N); 
% z approximation
[ wsp, za ] = aproksymacjaWiel(n,z,N); 

%Approx
plot3(xa, ya, za, 'lineWidth', 4);
title("Real and approximated trajectory for N=50");
xlabel("x");
ylabel("y");
zlabel("z");
legend("Real","Polynomial approximation");
hold off
saveas(gcf, '184631_Kuprianowicz_zad4.png')


%Zadanie 5

clc
clear all
close all
warning('off','all')

load trajektoria2

%Real
figure;
plot3(x,y,z,'o')
grid on
axis equal
hold on

N = 60;
% x approximation
[ wsp, xa ] = aproksymacjaWiel(n,x,N); 
% y approximation.
[ wsp, ya ] = aproksymacjaWiel(n,y,N); 
% z approximation
[ wsp, za ] = aproksymacjaWiel(n,z,N); 

%Approx
plot3(xa, ya, za, 'lineWidth', 4);
title("Real and approximated trajectory for N=60");
xlabel("x");
ylabel("y");
zlabel("z");
legend("Real","Polynomial approximation");
hold off

saveas(gcf, '184631_Kuprianowicz_zad5.png')

err=[];
M = length(n);

%N=(1,71)
for N = 1:71
    % x approximation
    [ wsp, xa ] = aproksymacjaWiel(n,x,N); 
    % y approximation.
    [ wsp, ya ] = aproksymacjaWiel(n,y,N); 
    % z approximation
    [ wsp, za ] = aproksymacjaWiel(n,z,N);

    x_error=(sqrt(sum((x - xa).^2)) / M);
    y_error=(sqrt(sum((y - ya).^2)) / M);
    z_error=(sqrt(sum((z - za).^2)) / M);

    err(N)=x_error+y_error+z_error;
end

%Error plot
figure;
semilogy(err);
grid on;
title("Polynomial approximation error");
xlabel("N");
ylabel("Error value");
saveas(gcf, '184631_Kuprianowicz_zad5_b.png')

%Zadanie 7

clc
clear all
close all
warning('off','all')

load trajektoria2

%Real
figure;
plot3(x,y,z,'o')
grid on
axis equal
hold on

N = 60;
xa = aprox_tryg(n, x, N);
ya = aprox_tryg(n, y, N);
za = aprox_tryg(n, z, N);

%Approx
plot3(xa, ya, za, 'lineWidth', 4);
grid on
axis equal
title("Real and trygonometric approximation trajectory for N=60");
xlabel("x");
ylabel("y");
zlabel("z");
set(gcf, 'Units', 'Inches', 'Position', [0, 0, 7.25, 9.125], 'PaperUnits', 'Inches', 'PaperSize', [7.25, 9.125]);
legend("Real","Trygonometric approximation");
saveas(gcf, '184631_Kuprianowicz_zad7.png')
hold off

M = length(n);
for N = 1:71
    xa= aprox_tryg(n, x, N);
    ya = aprox_tryg(n, y, N);
    za = aprox_tryg(n, z, N);
    
    x_error=(sqrt(sum((x - xa).^2)) / M);
    y_error=(sqrt(sum((y - ya).^2)) / M);
    z_error=(sqrt(sum((z - za).^2)) / M);
    
    err(N)=x_error+y_error+z_error;
end

%Error
figure;
semilogy(err);
grid on;
title("Trygonometric approximation error");
xlabel("N");
ylabel("Error value");
saveas(gcf, '184631_Kuprianowicz_zad7_b.png')

%Real
plot3(x,y,z,'o')
grid on
axis equal
hold on


epsilon = 10^-2;
N = 0;

%find best N for approximation
while true
    N = N + 1;
    xa = aprox_tryg(n, x, N);
    ya = aprox_tryg(n, y, N);
    za = aprox_tryg(n, z, N);
    
    x_error=(sqrt(sum((x - xa).^2)) / M);
    y_error=(sqrt(sum((y - ya).^2)) / M);
    z_error=(sqrt(sum((z - za).^2)) / M);
    
    err=x_error+y_error+z_error;

    %break if error is small enough
    if err <= epsilon
        break
    end
end

%calculate approx with best N
xa = aprox_tryg(n, x, N);
ya = aprox_tryg(n, y, N);
za = aprox_tryg(n, z, N);

%Approx
plot3(xa, ya, za, 'lineWidth', 4);
title("Real and trygonometric approximation trajectory for best N = "+N)
xlabel("x");
ylabel("y");
zlabel("z");
set(gcf, 'Units', 'Inches', 'Position', [0, 0, 7.25, 9.125], 'PaperUnits', 'Inches', 'PaperSize', [7.25, 9.125]);
legend("Real","Trygonometric approximation");
hold off

saveas(gcf, '184631_Kuprianowicz_zad7_c.png')






