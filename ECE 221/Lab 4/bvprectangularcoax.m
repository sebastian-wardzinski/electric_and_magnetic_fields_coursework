function [V,Ex,Ey,C,gridpointsx,gridpointsy,innerx,innery]=bvprectangularcoax(a,b,c,d,xo,yo,er,Vo)
%
% This function used the finite difference method to solve the
% two-dimensional electrostatic boundary value problem related to a square
% coaxial cable.
% a = width of outer conductor
% b = height of outer conductor
% c = width of inner conductor
% d = height of inner conductor
% xo = the x-coordinate of the location of the bottom left corner of the inner conductor
% yo = the y-coordinate of the location of the bottom left corner of the inner conductor
% er = the relative permittivity of the dielectric which fills the space
% between the inner and outer conductor
% Vo = electric potential of the inner conductor (outer is grounded)
% Define the fundamental constant eo
eo=8.854e-12;
% Set number of nodes and node spacings
Nx=201;
hx=a/(Nx-1);
hy=hx;
Ny=round(b/hy+1);
% Set the initial values of V to zero
V = zeros(Nx,Ny);
Vnew = zeros(Nx,Ny);
% Set the known potential values (or boundary values)
V(1,1:Ny)=0; % Grounded left side
V(1:Nx,1)=0; % Grounded bottom side
V(Nx,1:Ny)=0; % Grounded right side
V(1:Nx,Ny)=0; % Grounded top side

% Determine indexes that represent the inner conductor
% These are rounded to ensure that they are integers
innerstartx=round(xo/hx+1);
innerendx=round(innerstartx+c/hx);
innerstarty=round(yo/hy+1);
innerendy=round(innerstarty+d/hy);
V(innerstartx:innerendx,innerstarty:innerendy)=Vo; % Set potentials of inner conductor

% Determine the final voltage distributions (your code goes here�)
while 1
    for i = 1:Nx
        for j = 1:Ny  %iterate through grid
            %if grid point is within inner conductor or on the outer
            %conductor don't change it, else calculate a new value
            if i == 1 || i == Nx || j == 1 || j == Ny || (i >= innerstartx && i <= innerendx && j >= innerstarty && j <= innerendy)
                Vnew(i, j) = V(i, j);
            else 
                Vnew(i, j) = (V(i-1,j) + V(i+1,j) + V(i,j-1) + V(i,j+1))/4;
            end
        end
    end
    %break from the while loop if change at each iteration is getting small
    if 1e-4 > max(max(abs(100*(Vnew-V)./(Vnew))))
        V=Vnew;
        break;
    end
    V=Vnew;
end

QL = 0;

for i = 1:Nx
    for j = 1:Ny    %iterate through grid
        En = 0;
        %depending on the location of our point, the orientation of the
        %second point we will be subtracting with will be different
        if (i == innerstartx && j<=innerendy && j>=innerstarty) 
            En = En + V(i,j)-V(i-1,j);
        elseif (i == innerendx && j<=innerendy && j>=innerstarty)
            En = En + V(i,j)-V(i+1,j);
        end
        if (j == innerstarty && i<=innerendx && i>=innerstartx)
            En = En + V(i,j)-V(i,j-1);
        elseif (j == innerendy && i<=innerendx && i>=innerstartx)
            En = En + V(i,j)-V(i,j+1)
        end
%         if (j == innerstarty && i == innerstartx)
%             En = V(i,j)-V(i-1,j-1)
%         elseif (j == innerendy && i == innerstartx)
%             En = V(i,j)-V(i-1,j+1)
%         elseif (j == innerstarty && i == innerendx)
%             En = V(i,j)-V(i+1,j-1)
%         elseif (j == innerendy && i == innerendx)
%             En = V(i,j)-V(i+1,j+1)

        %after finding En we add to our summer
        QL = QL + er*eo*En;
        
    end
end
%final capacitance value
C = QL/Vo
%calling matlab's gradient function
[Ey,Ex]=gradient(-V,hx,hy);


% Plot the grid points and known voltage nodes
% gridpointsx is a matrix (size Nx x Ny) that contains the x-values of the
% locations of the nodes within the grid.
% gridpointsy is a matrix (size Nx x Ny) that contains the y-values of the
% locations of the nodes within the grid.
[gridpointsx,gridpointsy]=meshgrid(0:hx:a,0:hy:b);

% innerx and innery are matrices that contains the x- and y-values of the
% locations of the nodes that relate to the inner conductor.
[innerx,innery]=meshgrid((innerstartx-1)*hx:hx:(innerendx-1)*hx,(innerstarty-1)*hy:hy:(innerendy-1)*hy);
% outerx and outery are matrices that contains the x- and y-values of the
% locations of the nodes that relate to the outer conductor.
% outerx=[0:hx:a,zeros(1,Ny-2),a:-hx:0,zeros(1,Ny-2)];
% outerx((Nx+1):(Nx+Ny-2))=a;
% outery=[zeros(1,Nx),hy:hy:(b-hy),zeros(1,Nx),(b-hy):-hy:hy];
% outery((Nx+Ny-1):(2*Nx+Ny-2))=b;
% figure
% plot(gridpointsx,gridpointsy,'b*');
% plot(outerx,outery,'kd');
% plot(innerx,innery,'ro');

% figure
% meshc(gridpointsx, gridpointsy, V');
% figure
% contourf(gridpointsx, gridpointsy, V');
% figure
% quiver(gridpointsx, gridpointsy, Ex', Ey');


