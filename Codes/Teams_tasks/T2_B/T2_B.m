%% Van der Pol oscillator simulation
% Parameters
mu = 1;  % Nelinearita oscilátora

% Initial conditions
x0 = [2; 0];  % [x(0); x_dot(0)]

% Time span
tspan = [0 20];

% Solve ODE
[t, x] = ode45(@(t, x) van_der_pol(t, x, mu), tspan, x0);

% Plot results
figure;
subplot(2,1,1);
plot(t, x(:,1));
title('Van der Pol Oscillator - x(t)');
xlabel('Time [s]');
ylabel('x');
grid on;

subplot(2,1,2);
plot(t, x(:,2));
title('Van der Pol Oscillator - x''(t)');
xlabel('Time [s]');
ylabel('x''');
grid on;

%% Mathematic pendulum simulation
% Parameters
g = 9.81;  % gravitačné zrýchlenie [m/s^2]
l = 1.0;   % dĺžka kyvadla [m]

% Initial conditions
theta0 = [pi/3; 0];  % [theta(0); theta_dot(0)]

% Time span
tspan = [0 10];

% Solve ODE
[t, theta] = ode45(@(t, theta) pendulum(t, theta, g, l), tspan, theta0);

% Plot results
figure;
subplot(2,1,1);
plot(t, theta(:,1));
title('Mathematic Pendulum - \theta(t)');
xlabel('Time [s]');
ylabel('\theta [rad]');
grid on;

subplot(2,1,2);
plot(t, theta(:,2));
title('Mathematic Pendulum - \theta''(t)');
xlabel('Time [s]');
ylabel('\theta'' [rad/s]');
grid on;

%% Funkcia pre Van der Pol oscillator
function dxdt = van_der_pol(~, x, mu)
    dxdt = zeros(2,1);
    dxdt(1) = x(2);
    dxdt(2) = mu*(1 - x(1)^2)*x(2) - x(1);
end

%% Funkcia pre Matematické kyvadlo
function dthetadt = pendulum(~, theta, g, l)
    dthetadt = zeros(2,1);
    dthetadt(1) = theta(2);
    dthetadt(2) = -(g/l)*sin(theta(1));
end
