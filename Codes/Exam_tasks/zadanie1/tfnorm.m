function ret = tfnorm(tfun)
    syms s

    [num, den] = tfdata(tfun);
    
    M_s = poly2sym(cell2mat(num), s);
    N_s = poly2sym(cell2mat(den), s);
    
    K_P = coeffs(N_s, s, 'All');
    K_P = 1 / K_P(end);
    
    N_s = flip(double(coeffs(N_s * K_P, s, 'All')));
    M_s = double(M_s * K_P);

    ret.num = M_s;
    ret.den = N_s;
end