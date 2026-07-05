function Reg = ppc(dtf, poles)
    syms q0 q1 q2 p1

    B = dtf.num;
    A = dtf.den;

    Cd = poly(poles);

    a1 = A(2);
    a2 = A(3);

    b1 = B(1);
    b2 = B(2);

    c1 = Cd(2);
    c2 = Cd(3);
    c3 = Cd(4);
    c4 = Cd(5);

    eq1 = a1 - (1 + p1) + q0 * b1 == c1;
    eq2 = a2 - a1 * (1 + p1) + p1 + q0 * b2 + q1 * b1 == c2;
    eq3 = a1 * p1 - a2 * (1 + p1) + b2 * q1 + b1 * q2 == c3;
    eq4 = p1 * a2 + b2 * q2 == c4;

    sol = solve([eq1, eq2, eq3, eq4], [q0, q1, q2, p1]);

    q0 = double(sol.q0);
    q1 = double(sol.q1);
    q2 = double(sol.q2);
    p1 = double(sol.p1);

    Reg.num = [q0 q1 q2];
    Reg.den = conv([1 -1], [1 -p1]);
end
