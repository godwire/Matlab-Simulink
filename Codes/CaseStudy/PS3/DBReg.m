function Reg = DBReg(dtf)
% DBREG - Dead-beat regulátor pre ľubovoľný rád systému

    b = dtf.num;
    a = dtf.den;

    % Získaj B(z) a A(z) bez z^0 členov
    B = b(2:end);
    A = a(2:end);

    M = length(B);  % rád systému

    % Výpočet q0
    q0 = 1 / sum(B);

    % Q(z) = q0 + q1 z^-1 + ... + qM z^-M
    Q = zeros(1, M+1);
    Q(1) = q0;
    for i = 1:M
        Q(i+1) = A(i) * q0;
    end

    % P(z) = p1 z^-1 + ... + pM z^-M
    P = zeros(1, M);
    for i = 1:M
        P(i) = B(i) * q0;
    end
    P = -P;  % mínus podľa (1 - P(z))
    P = [1 P];  % pridať jednotku na začiatok

    % Výstup
    Reg.num = Q;
    Reg.den = P;
end
