function Reg = MomPI(tfun)
    sys = tfnorm(tfun);
    a1 = sys.den(2);
    a2 = sys.den(3);
    a3 = 0;
    
    r0 = (1/(2*sys.num)) * ((a1^3 - 2*a1*a2 + a3) / (a1*a2 - a3));
    r_m1 = (1/(2*sys.num)) * ((a1^2 - a2) / (a1*a2 - a3));
   
    Reg.P = r0;
    Reg.I = r0 / r_m1;
end