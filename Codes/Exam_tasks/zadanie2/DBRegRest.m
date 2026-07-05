function Reg = DBRegRest(dtf, u0)
    b = dtf.num;
    a = dtf.den;

    a1 = a(2);
    a2 = a(3);
    a3 = 0;

    b1 = b(2);
    b2 = b(3);
    b3 = 0;

    q0 = u0;
    q1 = (a1 - 1) * q0 + (1 / sum(b));
    q2 = (a2 - a1) * q0 + (a1 / sum(b));
    q3 = (a3 - a2) * q0 + (a2 / sum(b));

    p1 = q0 * b1;
    p2 = (b2 - b1) * q0 + (b1 / sum(b));
    p3 = (b3 - b2) * q0 + (b2 / sum(b));

    Q = [q0 q1 q2 q3];
    P = [-1 p1 p2 p3] * -1;

    Reg.num = Q;
    Reg.den = P;
end