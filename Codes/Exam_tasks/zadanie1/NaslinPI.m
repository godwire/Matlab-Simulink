function Reg = NaslinPI(tfun, alpha)
    syms s r0 r_m1;
    [num, den] = tfdata(tfun);
    
    G_p = poly2sym(cell2mat(num), s) / poly2sym(cell2mat(den), s);
    G_r = r0 + r_m1 / s;
    eq = 1 + (G_p * G_r) == 0;
    
    eq_simplified = expand(lhs(eq) * poly2sym(cell2mat(den), s));
    eq_final = collect(expand(eq_simplified * s), s);
    coeffs_list = coeffs(eq_final, s, 'All');
    
    eq1 = coeffs_list(2)^2 == alpha * coeffs_list(1) * coeffs_list(3);
    eq2 = coeffs_list(3)^2 == alpha * coeffs_list(2) * coeffs_list(4);

    disp(eq1);
    disp(eq2);
    
    sol = solve([eq1, eq2], [r0, r_m1]);
    
    Reg.P = double(sol.r0);
    Reg.I = double(sol.r_m1);
end