function [Etot,Ex,Ey,Ez] = ringofcharge(a,pl,x,y,z, n)
    epsilon = 8.854e-12;
    Etot = 0;
    Ex = 0;
    Ey = 0;
    Ez = 0;
    
    theta = linspace(0,2*pi-2*pi/n,n);
    %pl = 3*sin(theta);

    xo = x-a.*cos(theta);
    yo = y-a.*sin(theta);
    r = (xo.^2+yo.^2+z.^2).^0.5;
    E = 2*pi*a.*3*sin(theta)./(n*(4*pi*epsilon*r.^3));
    
    dx = xo;
    dy = yo;
    dz = z;
    
    Ex = sum(dx.*E);
    Ey = sum(dy.*E);
    Ez = sum(dz.*E);

	