function [a, b] = pec()
% PEC - Diskrétna prenosová funkcia pre systém piecky (napr. 2. rádu)
% Gp(z) = (b1 z^-1 + b2 z^-2) / (1 + a1 z^-1 + a2 z^-2)

    a = [-1.2, 0.3];    % uprav podľa zadania
    b = [0.8, 0.1];
end
