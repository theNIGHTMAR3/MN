function [xvect,xdif,fx,iterations]=secand(a,b,eps,fun)

    xvect=[];   % vetor containing next values of result approximation
    xdif=[];    % vetor containing differences beetwen next aprox. values of result
    fx=[];      % vector containing values of function for elements in xvect
    iterations=0;
    
    %interval borders
    x0=a;   %x_k-1
    x1=b;   %x_k
    
    
    for i = 1:1000
    
        %f(x_k)
        feval_x1=feval(fun,x1);
    
        %x_k+1 - next x
        x1_diff=x1-(feval_x1*(x1-x0)/(feval_x1-feval(fun,x0)));
        
        %save values
        xvect(i)=x1_diff;
        xdif(i)=abs(x1_diff-x1);
        fx(i)=feval(fun,x1_diff);
    
        % outside epsilon, save iterations and return
        if(abs(fx(i))<eps)
            iterations=i;
            return;
        end
    
        x0=x1;
        x1=x1_diff;        
    end
end

