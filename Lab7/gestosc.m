%calculates value of probability density
function value = gestosc (t)
    mi=10;
    sigma=3;
    value=(1/(sigma * sqrt(2 * pi))) * exp(-(t - mi)^2 /(2 * sigma^2));
end