function Reg = ZiegNicPID(tfun, type)
    K_p = tfnorm(tfun).num;
    T = tfresp(tfun);

    switch type
        case "P"
            Reg.P = T.n / (K_p*T.u);
        case "PI"
            Reg.P = 0.9 * (T.n / (K_p*T.u));
            Reg.I = 3.5 * T.u;
        case "PD"
            Reg.P = 1.2 * (T.n / (K_p*T.u));
            Reg.D = 0.25 * T.u;
        case "PID"
            Reg.P = 1.25 * (T.n / (K_p*T.u));
            Reg.I = 2 * T.u;
            Reg.D = 0.05 * T.u;
    end
end