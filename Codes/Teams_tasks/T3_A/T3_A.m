figure;
plot(out.tout, out.y(:,2), 'DisplayName', 'y(t)');
hold on;
plot(out.tout, out.dy(:,2), '--', 'DisplayName', 'dy/dt');
title('Numerické riešenie LDR v Simulinku');
xlabel('čas [s]');
ylabel('hodnoty');
legend show;
grid on;

hold off;

% Definícia rovnice
LDR = @(t, y) [y(2); -3*y(2) - 2*y(1) + 1];  % Jednotkový vstup

% Počiatočné podmienky
y0 = [0; 0];

% Simulácia
[t, y] = ode45(LDR, [0 10], y0);

% Plot
figure;
plot(t, y(:,1), 'DisplayName', 'y(t)');
hold on;
plot(t, y(:,2), 'DisplayName', 'dy/dt');
title('Numerické riešenie LDR pomocou ode45');
xlabel('čas [s]');
ylabel('Výstupy');
legend;
grid on;
