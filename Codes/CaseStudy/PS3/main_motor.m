clear; clc;

% Načítanie systému motora
[a, b] = motor();  % z 'systems/motor.m'
dtf.num = [0, b];  % z^-1 a z^-2
dtf.den = [1, a];  % z^0, z^-1, z^-2

% --- DEAD-BEAT BEZ OBMEDZENIA ---
Reg = DBReg(dtf);
disp('Dead-beat bez saturácie:');
disp('Q(z):');
disp(Reg.num);
disp('P(z):');
disp(Reg.den);

% --- DEAD-BEAT S OBMEDZENÍM NA u(0) ---
u0 = 0.2;
RegSat = DBRegRest(dtf, u0);
disp(['Dead-beat so saturáciou (u(0) = ', num2str(u0), '):']);
disp('Q(z):');
disp(RegSat.num);
disp('P(z):');
disp(RegSat.den);

% Simulačný čas
N = 20;

% Žiadaný priebeh w(k)
w = ones(1, N);

% Simulácia bez obmedzenia
[y1, u1, e1] = simulate_response(a, b, Reg, w, N);

% Simulácia s obmedzením
[y2, u2, e2] = simulate_response(a, b, RegSat, w, N);

% Zobrazenie výsledkov
figure;
subplot(3,1,1); plot(0:N-1, y1, 'b', 0:N-1, y2, 'r--'); title('y(k)'); legend('bez obmedzenia','s obmedzením');
subplot(3,1,2); plot(0:N-1, u1, 'b', 0:N-1, u2, 'r--'); title('u(k)');
subplot(3,1,3); plot(0:N-1, e1, 'b', 0:N-1, e2, 'r--'); title('e(k)');
xlabel('k');

% Výpočet ustálených hodnôt
[y_inf1, u_inf1, e_inf1] = compute_steady_state(y1, u1, e1);
[y_inf2, u_inf2, e_inf2] = compute_steady_state(y2, u2, e2);

fprintf('\n--- USTÁLENÉ HODNOTY ---\n');
fprintf('Bez obmedzenia:\n y(∞) = %.4f, u(∞) = %.4f, e(∞) = %.4f\n', y_inf1, u_inf1, e_inf1);
fprintf('S obmedzením:\n y(∞) = %.4f, u(∞) = %.4f, e(∞) = %.4f\n', y_inf2, u_inf2, e_inf2);

tspan = 2;
desr = [1 1.1];
desr_val = 0.01;

% Load both simulations
Data      = sim("reg.slx");     % without saturation
DataSat   = sim("reg_sat.slx"); % with saturation

% Time vector 
nas_t = Data.tout;

% Extract signals
w_t     = Data.simout.Data(:, 1);
y_t     = Data.simout.Data(:, 2);
u_t     = Data.simout.Data(:, 3);
e_t     = Data.simout.Data(:, 4);

y_t_sat = DataSat.simout.Data(:, 2);
u_t_sat = DataSat.simout.Data(:, 3);
e_t_sat = DataSat.simout.Data(:, 4);

% Plot y(t)
figure;
stairs(nas_t, y_t, 'LineWidth', 2, 'Color', "r");
hold on;
stairs(nas_t, y_t_sat, 'LineWidth', 2, 'Color', "g");
stairs(nas_t, w_t, 'LineWidth', 2, 'Color', "b");
legend("y(t) - bez obmedzenia", "y(t) - s obmedzením", "w(t)");
title("Motor y(t) - Dead-Beat Regulátor");
xlabel("Čas [s]");
ylabel("y(t)");
grid on;

% Plot u(t)
figure;
stairs(nas_t, u_t, 'LineWidth', 2, 'Color', "r");
hold on;
stairs(nas_t, u_t_sat, 'LineWidth', 2, 'Color', "g");
stairs(nas_t, w_t, 'LineWidth', 2, 'Color', "b");
legend("u(t) - bez obmedzenia", "u(t) - s obmedzením", "w(t)");
title("Motor Riadiaca veličina u(t)");
xlabel("Čas [s]");
ylabel("u(t)");
grid on;

% Plot e(t)
figure;
stairs(nas_t, e_t, 'LineWidth', 2, 'Color', "r");
hold on;
stairs(nas_t, e_t_sat, 'LineWidth', 2, 'Color', "g");
stairs(nas_t, w_t, 'LineWidth', 2, 'Color', "b");
legend("e(t) - bez obmedzenia", "e(t) - s obmedzením", "w(t)");
title("Motor Regulačná odchýlka e(t)");
xlabel("Čas [s]");
ylabel("e(t)");
grid on;

