function [t, x] = rk4Solver(dynamics, tspan, x0, dt)
    % Custom RK4 solver for ODE
    % dynamics: function handle to the system dynamics
    % tspan: simulation time [start end]
    % x0: initial conditions
    % dt: time step size

    t = tspan(1):dt:tspan(2); % time vector
    N = length(t); % number of steps
    n = length(x0); % state dimension
    x = zeros(N, n); % preallocate state matrix
    x(1,:) = x0'; % set initial condition
    
    for i = 1:N-1
        k1 = dynamics(t(i), x(i,:)');
        k2 = dynamics(t(i) + dt/2, x(i,:)' + dt/2 * k1);
        k3 = dynamics(t(i) + dt/2, x(i,:)' + dt/2 * k2);
        k4 = dynamics(t(i) + dt, x(i,:)' + dt * k3);
        
        x(i+1,:) = x(i,:) + (dt/6)*(k1' + 2*k2' + 2*k3' + k4');
    end
end
