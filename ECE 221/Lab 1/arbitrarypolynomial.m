function [y] = arbitrarypolynomial(x,C)
   y = 0;
   Y = 0;
   figure;
   hold;
   xlabel('x');
   ylabel('y');
   title(strcat('Plot of Polynomial of Order ', num2str(length(C)-1)));
   grid on;
   
for i = 1:length(C)
    Y = C(i).*x.^(i-1);
    plot(x, Y);
    y = y + Y;
end

plot(x,y);
