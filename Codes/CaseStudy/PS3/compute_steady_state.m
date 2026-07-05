function [y_inf, u_inf, e_inf] = compute_steady_state(y, u, e)
% COMPUTE_STEADY_STATE - Výpočet ustálených hodnôt y(∞), u(∞), e(∞)
% z posledných vzoriek simulácie
%
% Vstupy:
%   y - výstupná veličina y(k)
%   u - riadiaca veličina u(k)
%   e - regulačná odchýlka e(k)
%
% Výstupy:
%   y_inf - y(∞)
%   u_inf - u(∞)
%   e_inf - e(∞)

    % Počet krokov, ktoré považujeme za "ustálené"
    tail = round(length(y) * 0.2);  % posledných 20 %

    y_inf = mean(y(end-tail+1:end));
    u_inf = mean(u(end-tail+1:end));
    e_inf = mean(e(end-tail+1:end));
end
