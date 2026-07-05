%% T1_B: Solving a second-order ODE using MATLAB solvers and custom RK4 method

% Clear workspace
clear;
clc;

%% Define system parameters
% System: y''(t) + 3y'(t) + 2y(t) = 1
% Rewrite into substitution canonical form (state-space)
% x1 = y, x2 = y'
% Then:
% x1' = x2
% x2' = -3*x2 -2*x1 + 1

% Define simulation time
tspan = [0 5]; 
% Initial conditions: y(0) = 0, y'(0) = 0
x0 = [0; 0];

%% Solve using ode45
[t_ode45, x_ode45] = ode45(@systemDynamics, tspan, x0);

%% Solve using ode23
[t_ode23, x_ode23] = ode23(@systemDynamics, tspan, x0);

%% Solve using ode15s (stiff solver, for robustness check)
[t_ode15s, x_ode15s] = ode15s(@systemDynamics, tspan, x0);

%% Solve using custom RK4 method
dt = 0.01; % time step for RK4
[t_rk4, x_rk4] = rk4Solver(@systemDynamics, tspan, x0, dt);

%% Plot the solutions (x1 = y(t))
figure;
plot(t_ode45, x_ode45(:,1), 'b-', 'LineWidth', 2); hold on;
plot(t_ode23, x_ode23(:,1), 'r--', 'LineWidth', 2);
plot(t_ode15s, x_ode15s(:,1), 'g-.', 'LineWidth', 2);
plot(t_rk4, x_rk4(:,1), 'k:', 'LineWidth', 2);
xlabel('Time t [s]');
ylabel('State x_1(t) = y(t)');
title('Comparison of solutions for y(t)');
legend('ode45', 'ode23', 'ode15s', 'RK4 (custom)', 'Location', 'best');
grid on;

%% Plot the derivatives (x2 = dy/dt)
figure;
plot(t_ode45, x_ode45(:,2), 'b-', 'LineWidth', 2); hold on;
plot(t_ode23, x_ode23(:,2), 'r--', 'LineWidth', 2);
plot(t_ode15s, x_ode15s(:,2), 'g-.', 'LineWidth', 2);
plot(t_rk4, x_rk4(:,2), 'k:', 'LineWidth', 2);
xlabel('Time t [s]');
ylabel('State x_2(t) = dy/dt');
title('Comparison of solutions for dy/dt');
legend('ode45', 'ode23', 'ode15s', 'RK4 (custom)', 'Location', 'best');
grid on;
