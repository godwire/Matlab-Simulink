K1 = 100;
T1 = 0.15;

tspan = [0 50];
step_t = 5;
u_des = 1;
desr = [35 40];
desr_val = 0.01;

num = K1;
den = conv([T1 1], [1 0]);
tfun = tf(num, den);

NaslinReg = NaslinPI(tfun, 2.2);
ButtwReg = ButtwPI(num, den);
GhReg = GhPI(num, den);

%% Plot step function + disorder

figure("Name", "PI Regulator")

Reg = NaslinReg;
data = sim("reg.slx");
nas_t = data.tout;
simout = data.simout.Data(:, 1);
data = data.simout.Data(:, 2);

stairs(nas_t, simout, '--', 'LineWidth', 2);
hold on;
grid on;
title("PI Regulator");
xlabel("Time");
ylabel("y(t)");


%% Naslin PI plot

plot(nas_t, data, "LineWidth", 2);

%% Butterworth PI plot

Reg = ButtwReg;
data = sim("reg.slx");
buttw_t = data.tout;
data = data.simout.Data(:, 2);

plot(buttw_t, data, "LineWidth", 2);

%% Graham-Lathrop PI plot

Reg = GhReg;
data = sim("reg.slx");
gh_t = data.tout;
data = data.simout.Data(:, 2);

plot(gh_t, data, "LineWidth", 2);

hold off;
legend("w(t)", "Naslin PI",  "Butterworth PI", "Graham-Lathrop PI", "Location", "southeast");

%% Urcenie kritickeho zosilnenia/periody Michajlovovym kriteriom

[r0_kr, omega_kr, T_kr] = MicCr(tfun);

fprintf('Michajlov criterion:\n');
fprintf('omega_KR = %.4f rad/s\n', omega_kr);
fprintf('r0_KR = %.4f\n', r0_kr);
fprintf('T_KR = %.4f s\n', T_kr);

%% y(inf)
y_inf_naslin = ssPI(tfun, NaslinReg);
y_inf_buttw = ssPI(tfun, ButtwReg);
y_inf_gh = ssPI(tfun, GhReg);

fprintf("y(inf) for Naslin: %.4f\n", y_inf_naslin);
fprintf("y(inf) for Butterworth: %.4f\n", y_inf_buttw);
fprintf("y(inf) for Graham-Lathrop: %.4f\n\n", y_inf_gh);

u_inf_naslin = ciPI(tfun, NaslinReg);
u_inf_buttw = ciPI(tfun, ButtwReg);
u_inf_gh = ciPI(tfun, GhReg);

fprintf("u(inf) for Naslin: %.4f\n", u_inf_naslin);
fprintf("u(inf) for Butterworth: %.4f\n", u_inf_buttw);
fprintf("u(inf) for Graham-Lathrop: %.4f\n", u_inf_gh);

%% Discretization

u = 1;
T_vz = 0.4;
dtf = c2d(tfun, T_vz, 'tustin');

figure("Name", "PS Regulator");

%% Naslin PS Reg
Ts_reg = 0.02;
PSDReg = PSD(NaslinReg, Ts_reg);

data = sim("dreg.slx");
nas_t = data.tout;
simout = data.simout.Data(:, 1);
data = data.simout.Data(:, 2);

stairs(nas_t, simout, '--', 'LineWidth', 2);
hold on;
grid on;
stairs(nas_t, data, 'LineWidth', 2);

%% Butterworth PS plot

Ts_reg = 0.03;
PSDReg = PSD(ButtwReg, Ts_reg);

data = sim("dreg.slx");
buttw_t = data.tout;
data = data.simout.Data(:, 2);

stairs(buttw_t, data, 'LineWidth', 2);

%% Graham-Lathrop PS plot

Ts_reg = 0.04;
PSDReg = PSD(GhReg, Ts_reg);

data = sim("dreg.slx");
gh_t = data.tout;
data = data.simout.Data(:, 2);

stairs(gh_t, data, 'LineWidth', 2);

title("PS Regulator");
xlabel("Time");
ylabel("y(k)");
legend("w(t)", "Naslin PI",  "Butterworth PI", "Graham-Lathrop PI", "Location", "southeast");
hold off;