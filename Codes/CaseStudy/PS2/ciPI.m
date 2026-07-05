% Control-Intervention value for URO (G_r + PI)
function u_inf = ciPI(tf, Reg)
    syms s r0 r_m1
    
    G_r = r0 + r_m1 / s;
    [num, den] = tfdata(tf);
    G_p = poly2sym(cell2mat(num), s) / poly2sym(cell2mat(den), s);

    G_r = subs(G_r, [r0 r_m1], [Reg.P Reg.I]);

    eq = G_r / (1 + (G_p * G_r));
    u_inf = double(limit(s * eq * 1/s, s, 0));
end

