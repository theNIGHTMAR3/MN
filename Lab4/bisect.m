function [xvect,xdif,fx,iterations]=bisect(a,b,eps,fun)

    xvect=[];   % vetor containing next values of result approximation
    xdif=[];    % vetor containing differences beetwen next aprox. values of result
    fx=[];      % vector containing values of function for elements in xvect
    iterations=0;
    temp=1;
    
    for i = 1:1000

        %center point
        center=(a+b)/2;
    
        % use feval to obtain the value of the function in center
        feval_value=feval(fun,center);

        %save values
        fx(i)=feval_value;
        xvect(i)=center;
        xdif(i)=abs(temp-center);

        temp=center;

        if(abs(feval_value)<eps || abs(b-a)<eps)
            % outside epsilon, save iterations and return
            iterations=i;
            return;
        %left interval
        elseif(feval(fun,a)*feval_value<0)
            b=center;
        %right interval
        else
            a=center;
        end
    end
end

