function [y, u, e] = simulate_response(a, b, Reg, w, N)
% SIMULATE_RESPONSE - Simuluje odpoveď URO systému s dead-beat regulátorom
%
% Vstupy:
%   a    - menovateľ prenosu systému (bez 1), A(z) = 1 + a1 z^-1 + ...
%   b    - čitateľ prenosu systému, B(z)
%   Reg  - štruktúra s Reg.num (Q) a Reg.den (P) – regulátor
%   w    - požadovaná hodnota (vektor dĺžky N)
%   N    - počet simulovaných krokov
%
% Výstupy:
%   y    - výstup regulovaného systému
%   u    - riadiaca veličina
%   e    - regulačná odchýlka (w - y)

    na = length(a);
    nb = length(b);
    nq = length(Reg.num);
    np = length(Reg.den) - 1;

    % Inicializácia
    y = zeros(1, N);
    u = zeros(1, N);
    e = zeros(1, N);

    for k = 1:N
        % regulačná odchýlka
        e(k) = w(k) - y(k);

        % výpočet u(k)
        uk = 0;
        for i = 1:min(np, k-1)
            uk = uk + (-Reg.den(i+1)) * u(k-i);
        end
        for i = 1:min(nq, k)
            uk = uk + Reg.num(i) * e(k - i + 1);
        end
        u(k) = uk;

        % výpočet y(k)
        yk = 0;
        for i = 1:min(na, k-1)
            yk = yk - a(i) * y(k-i);
        end
        for i = 1:min(nb, k)
            yk = yk + b(i) * u(k - i + 1);
        end
        y(k) = yk;
    end
end
