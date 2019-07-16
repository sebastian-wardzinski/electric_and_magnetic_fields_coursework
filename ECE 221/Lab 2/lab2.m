function [Etot,Ex,Ey,Ez] = lab2(Q,R,theta,phi)

epsilon = 8.854e-12;

Etot = Q/(4*pi*epsilon*R^2);
Ex = Etot*sin(theta)*cos(phi);
Ey = Etot*sin(theta)*sin(phi);
Ez = Etot*cos(phi);
