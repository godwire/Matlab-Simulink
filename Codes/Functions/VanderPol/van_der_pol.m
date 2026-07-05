function dxdt = van_der_pol(t, x, mu)
    dxdt = zeros(2,1);
    dxdt(1) = x(2);
    dxdt(2) = mu * (1 - x(1)^2) * x(2) - x(1);
end