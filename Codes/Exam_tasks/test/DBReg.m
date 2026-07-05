function Reg = DBReg(dtf)
    b = dtf.num;
    a = dtf.den;

    disp(b);
    disp(a);

    q0 = 1 / (b(2) + b(3));
    q1 = a(2) * q0;
    q2 = a(3) * q0;

    p1 = b(2) * q0;
    p2 = b(3) * q0;
    Q = [q0 q1 q2];

    P = [p1 p2] * -1;
    P = [1 P(1) P(2)];

    Reg.num = Q;
    Reg.den = P;
end

