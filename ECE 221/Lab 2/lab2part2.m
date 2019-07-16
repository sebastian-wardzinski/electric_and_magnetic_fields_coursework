Q = 3e-3;
a = 0.5;
pl = Q/(2*pi*a);
epsilon_0 = 8.854e-12;

y = linspace(0.1,2,46);

%Ex_integrand = (pl*a/(4*pi*epsilon_0))*((-a*cos(t))/(sqrt((a*cos(t))^2 + (y-a*sin(t))^2).^3));
%= (pl*a/(4*pi*epsilon_0))*((y - a*sin(t))/(sqrt((a*cos(t))^2 + (y-a*sin(t))^2).^3));
Ez_theory = 0;

[Etot, Ex_matlab, Ey_matlab, Ez_matlab] = ringofcharge(a,pl,0,y,0,500);

figure(1);
hold on;
plot(y,Ey_matlab, 'b');
plot(y,Ex_matlab, 'g');
plot(y,Ez_matlab, 'r');
grid on;
%plot(z,Ez_theory,'b-');

xlabel("z [m]");
ylabel("Ez [N/C]");
legend("Ey_{matlab}","Ex_{matlab}","Ez_{matlab}");

