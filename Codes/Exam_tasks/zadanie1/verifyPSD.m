function isGood = verifyPSD(PSDReg)
    q0 = PSDReg.q0;
    q1 = PSDReg.q1;
    q2 = PSDReg.q2;
    isGood = q0 > 0 && q1 > -q0 && -(q0 + q1) < q2 && q2 < q0;

    if isGood
        disp("PSD is okay")
    else
        disp("PSD is NOT GOOD")
    end
end

