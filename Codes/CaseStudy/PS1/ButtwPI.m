function Reg = ButtwPI(num, den)
    syms s r0 r_m1 w0
    G_p = poly2sym(num, s) / poly2sym(den, s);
    G_r = r0 + r_m1 / s;
    eq = 1 + G_p * G_r == 0;


    eq_simplified = expand(lhs(eq) * poly2sym(den, s));
    eq_final = collect(expand(eq_simplified * s), s);

    coeffs_list = coeffs(eq_final, s, 'All');
    mult = double(1 / coeffs_list(1));
    coeffs_list = coeffs_list * mult;

    c2 = coeffs_list(2);
    c1 = coeffs_list(3);
    c0 = coeffs_list(4);

    w0 = solve(c2 == 2 * w0, w0, 'Real', true);
    w0 = double(w0);

    disp(w0)

    Kp = solve(c1 == 2 * w0^2, r0, 'Real', true);
    Reg.P = double(Kp);

    Ti = solve(c0 == w0^3, r_m1, 'Real', true);
    Reg.I = double(Ti);
end