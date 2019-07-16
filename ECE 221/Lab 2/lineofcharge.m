function [Etot,Ex,Ey,Ez] = lineofcharge(h,rhol,x,y,z,N)

epsilon = 8.854e-12;

dz = 2*h/N;

zprime=linspace(-h,h,N);

integrand = dz./((x^2+y^2+(z-zprime).^2).^(3/2));
dEx = integrand;
dEy = integrand;
dEz = (z-zprime).*integrand;

Ex = ((rhol*x)/(4*pi*epsilon))*sum(dEx);
Ey = ((rhol*y)/(4*pi*epsilon))*sum(dEy);
Ez = ((rhol)/(4*pi*epsilon))*sum(dEz);
Etot = (Ex^2+Ey^2+Ez^2)^0.5;
