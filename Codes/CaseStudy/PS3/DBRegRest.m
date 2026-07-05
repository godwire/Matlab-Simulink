function Reg = DBRegRest(dtf, u0)
% DBREGREST - Dead-beat regulátor s obmedzením na u(0) = u0
% Funguje pre ľubovoľný rád systému

    b = dtf.num;
    a = dtf.den;

    % Získaj A(z) a B(z) bez z^0 členov
    A = a(2:end);
    B = b(2:end);

    M = length(B);  % rád systému
    q0 = u0;
    Bsum = sum(B);

    % Výpočet q1...qM+1
    Q = zeros(1, M+2);
    Q(1) = q0;
    for i = 1:M
        if i == 1
            Q(i+1) = (A(i) - 1) * q0 + 1 / Bsum;
        else
            Q(i+1) = q0 * (A(i) - A(i-1)) + A(i-1) / Bsum;
        end
    end
    Q(M+2) = A(M) * (-q0 + 1 / Bsum);

    % Výpočet p1...pM+1
    P = zeros(1, M+1);
    for i = 1:M
        if i == 1
            P(i) = B(i) * q0;
        else
            P(i) = q0 * (B(i) - B(i-1)) + B(i-1) / Bsum;
        end
    end
    P(M+1) = -B(M) * (q0 - 1 / Bsum);
    P = [1 -P];  % pridaj 1 a zmeň znamienko

    % Výstup
    Reg.num = Q;
    Reg.den = P;
end
