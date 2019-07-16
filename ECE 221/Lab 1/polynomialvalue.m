function [y]= polynomialvalue(x,plotflag)
y = 6*x.^3 + 8*x.^2 - 3*x + 12;

if plotflag == 1
    figure;
    plot(x,y,'b--');
end
keyboard
