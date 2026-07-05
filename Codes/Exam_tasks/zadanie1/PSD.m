function ZReg = PSD(SReg, Ts)
    ZReg.q0 = SReg.P * (1 + (Ts / (2 * SReg.I)));
    ZReg.q1 = -SReg.P * (1 - (Ts / (2 * SReg.I)));
    ZReg.q2 = 0;
end

