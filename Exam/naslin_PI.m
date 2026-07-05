function [r0, r1, r_1] = naslin_PI(alpha, Gp)
    syms r0 r_1

    [num, den] = tfdata(Gp, 'v');

    num = num / den(1);
    den = den / den(1);

    b = num(end);
    a2 = den(1);
    a1 = den(2);
    a0 = den(3);

    c3 = a2;
    c2 = a1;
    c1 = a0 + b * r0;
    c0 = b * r_1;

    eq1 = c2^2 == alpha * c1 * c3;
    eq2 = c1^2 == alpha * c0 * c2;

    % Nech r1=0
    solution = solve([eq1, eq2], [r0, r_1]);

    r0 = double(solution.r0(1));
    r1 = 0;
    r_1 = double(solution.r_1(1));
end