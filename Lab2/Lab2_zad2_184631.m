

function zad2()

function collides = circle_collision(x1, y1, r1, x2, y2, r2)
  collides = sqrt((x2 - x1)^2 + (y2 - y1)^2) < (r1 + r2);
end

function plot_circle(X, Y, R)
    theta = linspace(0,2*pi);
    x = R*cos(theta) + X;
    y = R*sin(theta) + Y;
    plot(x,y)
    hold on
end
    clf
    a=1;
    r_max=0.1;
    n_max=50;
    X=[];
    Y=[];
    area=0;

    losn=zeros(n_max,1);
    arean=[];
    r=r_max.*rand(n_max,1);
    n=1;
    while n<=n_max
        flag=true;

        while flag==true
            flag=false;

            losn(n)=losn(n)+1;

            X(n)=(a-r_max).*rand(1,1);
            Y(n)=(a-r_max).*rand(1,1);

            if(X(n)+r(n)>a && X(n)-r(n)<0 && Y(n)+r(n)>a && Y(n)+r(n)<0)
                flag=true;
            else
                for j=1:n-1
                    collision=circle_collision(X(n),Y(n),r(n),X(j),Y(j),r(j));
                    if(collision==true)
                        flag=true;
                        break;
                    end
                end
            end
                                       
        end

        temp=pi*r(n)^2;
        area=area+temp;
        arean(n)=area;
        axis equal
        plot_circle(X(n),Y(n),r(n))
        n=n+1;
    end
    hold off
    
    fprintf(1, ' %s%5d%s%.3g\r ', 'n =',  n, ' S = ', area)
    pause(0.01);
    
    figure 
    semilogx(1:length(losn),losn)
    saveas(gcf,"wykres2.png")
    figure 
    loglog(1:length(arean),arean)
    saveas(gcf,"wykres1.png")

end