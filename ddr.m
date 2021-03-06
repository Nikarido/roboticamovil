% DDR simulation tracing a curve
% (c) Universidad de Guanajuato 2019
% Author: Juan-Pablo Ramirez-Paredes
%         <jpi.ramirez@ugto.mx>
% Robotica Movil
r = 0.1;
L = 0.5;
v = 0.4;
omega = 0;
ur = v/r + L*omega/(2*r);
ul = v/r - L*omega/(2*r);

[t, y] = ode45(@(t, x) car(x, r, L, ur, ul), [0 10], [0 0 0]');

np = size(t, 1);
T = zeros(3, 3, np);
for i=1:np
    T(:,:,i) = SE2(y(i,1), y(i,2), y(i,3));
end

tranimate2(T)
figure(1)
trplot2(T(:,:,1), 'frame', 'inicio')
hold
trplot2(T(:,:,end), 'color', 'r', 'frame', 'final')
plot(y(:,1), y(:,2))
axis([-3 3 -3 3])

figure(2)
plot(t, y(:,1), t, y(:,2), t, y(:,3))
legend('X', 'Y', '\theta')