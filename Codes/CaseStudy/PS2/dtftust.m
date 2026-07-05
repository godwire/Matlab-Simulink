function out = dtftust(tf,Ts)
    syms s z;
    
    snum = poly2sym(cell2mat(tf.Numerator), s);
    sden = poly2sym(cell2mat(tf.Denominator), s);
    s_to_z = (2 / Ts) * ((z - 1) / (z + 1));
    
    [num, den] = numden(subs(snum / sden, s, s_to_z));
    num_coeffs = flip(double((coeffs(num, z))));
    den_coeffs = flip(double((coeffs(den, z))));
    
    num_coeffs = num_coeffs / den_coeffs(1);
    den_coeffs = den_coeffs / den_coeffs(1);

    out.num = num_coeffs;
    out.den = den_coeffs;
end

