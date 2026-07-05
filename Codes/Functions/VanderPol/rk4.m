function [t, X] = rk4(dy, tspan, x0, h)
    t = tspan(1):h:tspan(2);
    n = length(t);
    X = zeros(length(x0), n);
    X(:,1) = x0;

    for i = 1:n-1
        k1 = h * dy(t(i), X(:,i));
        k2 = h * dy(t(i) + h/2, X(:,i) + k1/2);
        k3 = h * dy(t(i) + h/2, X(:,i) + k2/2);
        k4 = h * dy(t(i) + h, X(:,i) + k3);
        X(:,i+1) = X(:,i) + (1/6) * (k1 + 2*k2 + 2*k3 + k4);
    end
end