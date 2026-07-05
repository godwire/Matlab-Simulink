function dx = rlcSystem(t, x, R, L, C)
    % System dynamics for RLC circuit in substitution canonical form
    % x(1) = uC(t) - capacitor voltage
    % x(2) = duC/dt
    
    % Input signal: unit step
    u = 1; 
    
    dx = zeros(2,1);
    dx(1) = x(2);
    dx(2) = (1/(L*C))*(u - R*C*x(2) - x(1));
end
