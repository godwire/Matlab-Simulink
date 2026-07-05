function [a, b] = motor()
% MOTOR - Diskrétna prenosová funkcia jednosmerného motora
% Gp(z) = (1.79 z^-1 + 1.5 z^-2) / (1 - 1.58 z^-1 + 0.58 z^-2)

    a = [-1.58, 0.58];   % menovateľ A(z) bez z^0
    b = [1.79, 1.5];     % čitateľ B(z)
end