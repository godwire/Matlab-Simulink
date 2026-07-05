function dXdt = odefun(t, x, J, b, K_g, k, u)
    X1 = x(1);
    X2 = x(2);
   
    dXdt = [X2; (1/J) * (- (b - K_g) * X2 - k * sin(X1) + u)];
end