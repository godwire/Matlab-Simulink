mu = 1;
tspan = [0 20];
x0 = [2; 0];
h = 0.1;

[t1, X1] = ode45(@(t, x) van_der_pol(t, x, mu), tspan, x0);
[t2, X2] = rk4(@(t, x) van_der_pol(t, x, mu), tspan, x0, h);
out = sim("model.slx");

hold on
plot(t1, X1(:,1), 'b', 'LineWidth', 1.5);
plot(t2, X2(1, :), 'r--', 'LineWidth', 1.5);
plot(out.simout.Time, out.simout.Data(:, 1), 'g*');
hold off

xlabel('Time');
ylabel('x_1');
title('Van der Pol Oscillator');
legend(["ode45" "RK4" "Simulink"])
grid on;

% out.simout.Time
