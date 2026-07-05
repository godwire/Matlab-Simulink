%% Solving the ODE using the Laplace Transform method and comparing with dsolve

% Declare symbolic variables and function
syms y(t) s
assume(t, 'real');

%% 1. Correct analytical solution using the Laplace Transform

% Define the Laplace-transformed right-hand side U(s) = 1/s
% So Y(s) = (1/s) / (s^2 + 3s + 2)
Y = (1/s) / (s^2 + 3*s + 2);

% Decompose into partial fractions
Y_part = partfrac(Y, s);

% Display the partial fraction decomposition
disp('Partial fraction decomposition of Y(s):');
pretty(Y_part)

% Inverse Laplace Transform to find y(t)
yLaplace = ilaplace(Y, s, t);
yLaplace = simplify(yLaplace);
disp('Solution obtained by inverse Laplace transform:');
pretty(yLaplace)

%% 2. Solution using dsolve (direct solution in the time domain)
% Define the ODE and initial conditions
Dy = diff(y,t);
ode = diff(y,t,2) + 3*Dy + 2*y == 1;
conds = [y(0)==0, Dy(0)==0];  % initial conditions: y(0) = 0, y'(0) = 0

% Solve using dsolve
y_dsolve = dsolve(ode, conds);
y_dsolve = simplify(y_dsolve);
disp('Solution obtained using dsolve:');
pretty(y_dsolve)

%% 3. Comparing both solutions
% Check if both solutions are equivalent
if simplify(yLaplace - y_dsolve) == 0
    disp('Both solutions are identical.');
else
    disp('Discrepancies found between the solutions.');
end

%% 4. Plotting both solutions for visual comparison
figure("Name", "Both solutions for visual comparison")
fplot(yLaplace, [0, 5], 'LineWidth', 2);
hold on
fplot(y_dsolve, [0, 5], '--r', 'LineWidth', 2);
xlabel('Time, t');
ylabel('y(t)');
title('Comparison of ODE solutions: Laplace Transform vs dsolve');
legend('Solution via Laplace Transform', 'Solution via dsolve');
grid on
