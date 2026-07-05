function URO = dtf_URO(dtf, PSDReg)
    syms z;
    
    q0 = PSDReg.q0;
    q1 = PSDReg.q1;
    q2 = PSDReg.q2;
    
    G_p = poly2sym(dtf.num, z) / poly2sym(dtf.den, z);
    G_r = (q0 + q1 * z^-1 + q2 * z^-2) / (1 - z^-1);
    G_YW = (G_p * G_r) / (1 + G_p * G_r);
    [num, den] = numden(G_YW);
    
    num_coeffs = flip(double((coeffs(num, z))));
    den_coeffs = flip(double((coeffs(den, z))));
    
    URO.num = num_coeffs / den_coeffs(1);
    URO.den = den_coeffs / den_coeffs(1);     
end

