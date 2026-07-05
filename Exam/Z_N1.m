function [Kp, Kd, Ki] = Z_N1(Gp, ctype)
    % Получаем запас по амплитуде, фазе и частоты
    [GM, PM, Wcg, Wcp] = margin(Gp);

    % Флаг: использовать ли метод колебаний
    useFrequencyMethod = isfinite(GM) && GM > 1e-3 && isfinite(Wcp) && Wcp > 1e-3;

    if useFrequencyMethod
        Ku = 1 / GM;            % Критическое усиление
        Pu = 2 * pi / Wcp;      % Период устойчивых колебаний

        switch upper(ctype)
            case 'P'
                Kc = 0.5 * Ku; Ti = Inf; Td = 0;
            case 'PI'
                Kc = 0.45 * Ku; Ti = Pu / 1.2; Td = 0;
            case 'PID'
                Kc = 0.60 * Ku; Ti = Pu / 2; Td = Pu / 8;
            otherwise
                error('Unknown controller type "%s"', ctype)
        end

    else
        % Step-response метод (аппроксимация через наклон и запаздывание)
        Tsim = 5;   % Больше времени моделирования для лучшей аппроксимации
        dt   = Tsim / 1000;
        [y, t] = step(Gp, 0:dt:Tsim);

        idx = round(0.8 * numel(t)):numel(t);
        slope = mean(diff(y(idx)) ./ diff(t(idx)));

        if abs(slope) < 1e-6 || isnan(slope)
            warning("Step response slope too small. Aborting ZN tuning.");
            Kp = 0; Kd = 0; Ki = 0;
            return;
        end

        Kp_ol = slope;
        Lvals = t(idx) - y(idx) / slope;
        L = mean(Lvals);
        T_ol = L;

        if isnan(L) || L <= 0
            warning("Delay L is invalid. Aborting ZN tuning.");
            Kp = 0; Kd = 0; Ki = 0;
            return;
        end

        switch upper(ctype)
            case 'P'
                Kc =     T_ol / (L * Kp_ol); Ti = Inf;    Td = 0;
            case 'PI'
                Kc = 0.9 * T_ol / (L * Kp_ol); Ti = 3.33 * L; Td = 0;
            case 'PID'
                Kc = 1.2 * T_ol / (L * Kp_ol); Ti =    2 * L; Td = 0.5 * L;
            otherwise
                error('Unknown controller type "%s"', ctype)
        end
    end

    % Финальный расчёт PID-параметров
    Kp = Kc;
    Kd = Td * Kc;
    Ki = (isinf(Ti) || Ti == 0) ? 0 : Kc / Ti;

    % Проверка на адекватность значений
    if any(isnan([Kp, Ki, Kd])) || any(isinf([Kp, Ki, Kd])) || any(abs([Kp, Ki, Kd]) > 1e6)
        warning("Computed PID values are invalid or too large.");
        Kp = 0; Ki = 0; Kd = 0;
    end
end
