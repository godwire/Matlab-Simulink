function [a, b] = vymenik()
% VYMENIK - Diskrétna prenosová funkcia výmenníka pomocou c2d()
% G(s) = 1 / (1 + 3s)^3 → 3. rádu systém
% Použije sa Tustinova (bilineárna) transformácia s krokovaním 0.1 s

    Ts = 10;  % vzorkovacia perióda

    % Spojitý systém
    Gs = tf(1, conv([3 1], conv([3 1], [3 1])));  % (1+3s)^3

    % Diskretizácia
    Gz = c2d(Gs, Ts, 'tustin');  % môžeš skúsiť aj 'zoh'

    % Získanie koeficientov
    [num, den] = tfdata(Gz, 'v');

    % Odstránenie z^0 členov z menovateľa (už zahrnuté ako 1)
    b = num(2:end);  % B(z)
    a = den(2:end);  % A(z) bez jednotky
end
