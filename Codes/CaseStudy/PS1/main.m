tspan = [0 70];
step_t = 5;
u_des = 1;
desr = [35 40];
desr_val = 0.5;

num = 0.1;
den = [1 1 0.2];

tffun = tf(num, den);

%% vykreslit priebeh regulovanej veliciny y(t) v otvorenej slucke
simdata = sim("msim.slx");
y = simdata.simout.Data(:, 1);
u = simdata.simout.Data(:, 2);
t = simdata.tout;

figure("Name", "System feedback on desired w(t)");
plot(t, y, 'r', 'LineWidth', 2);
hold on;
plot(t, u, 'b', 'LineWidth', 2);
grid on;
ylim([0 max(max(y, u)) + 0.5]);
legend("System feedback", "Desired value w(t)");
hold off;

%% Urcit koeficienty PID regulatora (alternativne P/PI/PD) s vyuzitim metod nepriamej syntezy

PINaslinCoef = NaslinPI(tffun, 1.75);
MomPICoef = MomPI(tffun);
ZiegNicPICoef = ZiegNicPID(tffun, 'PI');
GhPICoef = GhPI(num, den);
ButtwPICoef = ButtwPI(num, den);

%% Plot step function + disorder

figure("Name", "PI Regulator")
Reg = PINaslinCoef;
data = sim("reg.slx");

nas_t = data.tout;
siminfo = data.siminfo.Data;

stairs(nas_t, siminfo, '--', 'LineWidth', 2);
hold on;
grid on;
title("PI Regulators");

%% Naslin PI plot

simdata = data.simdata.Data;
nas_acout = data.acout.Data;
plot(nas_t, simdata, "LineWidth", 2);

%% MOM PI plot

Reg = MomPICoef;
data = sim("reg.slx");

simdata = data.simdata.Data;
mom_acout = data.acout.Data;
mom_t = data.tout;

plot(mom_t, simdata, "LineWidth", 2);

%% Ziegler-Nichols PI plot

Reg = ZiegNicPICoef;
data = sim("reg.slx");

simdata = data.simdata.Data;
zn_acout = data.acout.Data;
zn_t = data.tout;

plot(zn_t, simdata, "LineWidth", 2);

%% Graham-Lathrop PI plot

Reg = GhPICoef;
data = sim("reg.slx");

simdata = data.simdata.Data;
gl_acout = data.acout.Data;
gl_t = data.tout;

plot(gl_t, simdata, "LineWidth", 2);

%% Butterworth PI plot

Reg = ButtwPICoef;
data = sim("reg.slx");

simdata = data.simdata.Data;
bw_acout = data.acout.Data;
bw_t = data.tout;

plot(bw_t, simdata, "LineWidth", 2);

hold off;
legend("w(t)", "u(t)", "Naslin PI", "MOM PI", "Ziegler-Nichols PI", "Graham-Lathrop PI", "Butterworth PI", "Location", "southeast");

%% Plot action signal

figure("Name", "Action signal");
plot(nas_t, nas_acout, "LineWidth", 2);
hold on;
plot(mom_t, mom_acout, "LineWidth", 2);
plot(zn_t, zn_acout, "LineWidth", 2);
plot(gl_t, gl_acout, "LineWidth", 2);
plot(bw_t, bw_acout, "LineWidth", 2);
hold off;
grid on;

legend("Naslin", "MOM", "Ziegler-Nichols", "Graham-Lathrop", "Butterworth", "Location", "southeast");

%% c2d

dtfun = c2d(tffun, 0.5, 'tustin');
disp(dtfun);

dtfun = c2d(tffun, 0.15, 'tustin');
disp(dtfun);
