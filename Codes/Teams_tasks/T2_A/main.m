%% T2_A: Simulation of RLC circuit (charging a capacitor)

% Clear workspace
clear;
clc;

%% Parameters
R = 10;        % Resistance [Ohm]
L = 0.5;       % Inductance [H]
C = 0.01;      % Capacitance [F]

% Define simulation time
tspan = [0 2]; 
% Initial conditions: capacitor voltage and its derivative
x0 = [0; 0]; % x1(0) = 0V, x2(0) = 0V/s

%% Solve with ode45
[t, x] = ode45(@(t, x) rlcSystem(t, x, R, L, C), tspan, x0);

% Input signal (unit step)
u = ones(size(t)); 

%% Plot capacitor voltage (uC) and current (i)
figure;
plot(t, x(:,1), 'b-', 'LineWidth', 2); hold on;
plot(t, C*x(:,2), 'r--', 'LineWidth', 2); % i(t) = C * duC/dt
xlabel('Time t [s]');
ylabel('Amplitude');
title('RLC Circuit Response (Charging Capacitor)');
legend('Capacitor Voltage u_C(t)', 'Current i(t)', 'Location', 'best');
grid on;

%% Plot input and capacitor voltage
figure;
plot(t, u, 'k-', 'LineWidth', 2); hold on;
plot(t, x(:,1), 'b--', 'LineWidth', 2);
xlabel('Time t [s]');
ylabel('Voltage [V]');
title('Input Voltage u(t) and Capacitor Voltage u_C(t)');
legend('Input Voltage u(t)', 'Capacitor Voltage u_C(t)', 'Location', 'best');
grid on;
