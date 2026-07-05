function [r0_kr, omega_kr, T_kr] = MicCr(Gp)
    [num, den] = tfdata(Gp, 'v');
    omega = linspace(0.01, 100, 10000);

    s = 1j * omega;
    Gp_eval = polyval(num, s) ./ polyval(den, s);  % Gp(jω)

    phase = angle(Gp_eval);
    [~, idx] = min(abs(phase + pi));

    omega_kr = omega(idx);
    mag = abs(Gp_eval(idx));
    r0_kr = 1 / mag;
    T_kr = 2 * pi / omega_kr;
end
