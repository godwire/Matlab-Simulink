function dx = systemDynamics(t, x)
    % System dynamics for canonical form of ODE
    % x(1) = y
    % x(2) = dy/dt
    
    dx = zeros(2,1);
    dx(1) = x(2);
    dx(2) = -3*x(2) - 2*x(1) + 1; % Constant input u(t) = 1
end
