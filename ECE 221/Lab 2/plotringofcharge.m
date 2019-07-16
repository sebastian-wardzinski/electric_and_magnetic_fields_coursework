Q = 3e-3;
a = 0.5;
pl = Q/(2*pi*a);
epsilon_0 = 8.854e-12;

Q = 2*pi*a*pl;

Ex = zeros(500);
Ey = zeros(500);
Ez = zeros(500);
z = linspace(-3,3,500);
for i = 1:1:length(z)
    [Etot(i), Ex(i), Ey(i), Ez(i)] = ringofcharge(a,pl,0,0,z(i),500);
end

figure(1);
hold on;
plot(z,Ex, 'b');
plot(z,Ey, 'g');
plot(z,Ez, 'r');
grid on;

xlabel("z [m]");
ylabel("Ez [N/C]");
legend("Ex","Ey","Ez");
