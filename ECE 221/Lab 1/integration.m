function [y] = integration(x1,x2)

y = 0;
N = 1E6;
steplength = ((x2-x1)/N);

for a = x1 : steplength : x2
    y = y + (cos(a))*steplength;
end

disp(y)