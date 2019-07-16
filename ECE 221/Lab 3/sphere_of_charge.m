function [E, V, Ex, Ey, Ez] = sphere_of_charge(x,y,z)
    
    epsilon0 = 8.854e-12;
    
    a = 0.01;
    N = 500;
    ps = -5e-9;
    
    dtheta = pi/N;
    dphi = 2*pi/N;
    
    phi = linspace(dphi, 2*pi, N);
    theta = linspace(0, pi, N+1);
    
    Ex = 0;
    Ey = 0;
    Ez = 0;
    V = 0;
    
    for e = 1:length(phi)
        dE1x = 0;
        dE1y = 0;
        dE1z = 0;
        dV1 = 0;
        
        for m = 1:length(theta)
            x0 = a*sin(theta(m))*cos(phi(e));
            y0 = a*sin(theta(m))*sin(phi(e));
            z0 = a*cos(theta(m));
            
            deltax = x-x0;
            deltay = y-y0;
            deltaz = z-z0;
            
            r = ((deltax)^2+(deltay)^2+(deltaz)^2)^0.5;
            
            dE1x = dE1x + (a^2)*sin(theta(m))*dtheta*dphi*ps*deltax / (4*pi*epsilon0*r^3);  %non-uniform charge density so I need to include it in the lowest level of integration
            dE1y = dE1y + (a^2)*sin(theta(m))*dtheta*dphi*ps*deltay / (4*pi*epsilon0*r^3);  
            dE1z = dE1z + (a^2)*sin(theta(m))*dtheta*dphi*ps*deltaz / (4*pi*epsilon0*r^3);
            dV1 = dV1 + (a^2)*sin(theta(m))*dtheta*dphi*ps / (4*pi*epsilon0*r);
        end
        
        Ex = Ex + dE1x;
        Ey = Ey + dE1y; 
        Ez = Ez + dE1z; 
        V = V + dV1;
    end
    
    E = (Ex.^2+Ey.^2+Ez.^2).^0.5;