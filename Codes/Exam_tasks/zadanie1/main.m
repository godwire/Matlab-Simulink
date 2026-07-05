close all;
clc;
clear;
syms s r0 r_m1;

% J = input('Enter the moment of inertia of the platform (J): ');
% b = input('Enter the damping coefficient (b): ');
% Kg = input('Enter the gyroscopic steering coefficient (Kg): ');
% k = input('Enter the elasticity coefficient (k): ');
J = 0.5;
b = 2;
Kg = 0.1;
k = 1;

u = 1;
z = -0.1;
Ts = 0.475;
dirsorder = [11 12];

num = 1/J;
den = [1, (b - Kg)/J, k/J];

tflin = tf(num, den);
dtflin = dtftust(tflin, Ts);

x0 = [0; 0];
tspan = [0 20];
[t, y] = ode45(@(t, y) odefun(t, y, J, b, Kg, k, u), tspan, x0);
[y1, t1] = step(tflin, tspan(2));

%% Linearized vs non-linear
figure("Name", "Gyroscopic stabilization");
plot(t, y(:,1), 'b--', 'LineWidth', 1.5);
hold on;
plot(t1, y1, 'LineWidth', 1.5);
hold off;
legend("Non-linear", "Linear", "Location","southeast");
xlabel('Time [s]');
ylabel('\theta (angle) [rad]');
title('Linear vs Non-Linear');
grid on;

%% NASLIN
Ts_reg = 1.4;
alpha = 2;
NaslinReg = NaslinPI(tflin, alpha);
disp(strcat("Naslin y(inf) = ", num2str(ssPI(tflin, NaslinReg))));
PSDNaslinReg = PSD(NaslinReg, Ts_reg);
disp("PSD for Naslin: ");
verifyPSD(PSDNaslinReg);
PSDNaslinURO = dtf_URO(dtflin, PSDNaslinReg);

%% MOM 
MomReg = MomPI(tflin);
disp(strcat("MOM y(inf) = ", num2str(ssPI(tflin, MomReg))));
PSDMomReg = PSD(MomReg, Ts);
disp("PSD for MOM: ");
verifyPSD(PSDMomReg);
PSDMomURO = dtf_URO(dtflin, PSDMomReg);

%% PI 
outdata = sim("msim.slx");
time = outdata.y_t.Time;
data = outdata.y_t.Data;

%% PS
outdata_z = sim("psd_reg.slx");
data_z = outdata_z.y_z.Data;
time_z = outdata_z.y_z.Time;

%% NASLIN PI vs PS
figure("Name", "Gyroscopic stabilization PI vs PS (Naslin)");

hold on;
plot(time, data(:, 1), "LineWidth", 1.5);
stairs(time_z, data_z(:, 1), "LineWidth", 1.5);

plot(time, data(:, 3), "LineWidth", 1.5);
plot(time, data(:, 4), "LineWidth", 1.5);
hold off;

legend("PI", "PS", "Step", "Disorder", "Location","southeast");
xlabel("t(z)");
ylabel("y(z)");
title("Gyroscopic stabilization PI vs PS (Naslin)");
grid on;

%% MOM PI vs PS
figure("Name", "Gyroscopic stabilization PI vs PS (MOM)");

hold on;
plot(time, data(:, 2), "LineWidth", 1.5);
stairs(time_z, data_z(:, 2), "LineWidth", 1.5);

plot(time, data(:, 3), "LineWidth", 1.5);
plot(time, data(:, 4), "LineWidth", 1.5);
hold off;

legend("PI", "PS", "Step", "Disorder", "Location","southeast");
xlabel("t(z)");
ylabel("y(z)");
title("Gyroscopic stabilization PI vs PS (MOM)");
grid on;

%% Pole-Placement
PpReg = ppc(dtflin, [0.01 0.1 0.1 0.1]);
ppsimdata = sim("ppsim.slx");

pptime = ppsimdata.simout.Time;
ppdata = ppsimdata.simout.Data;

figure("Name", "Pole-Placement Regulator");
stairs(pptime, ppdata(:, 1), 'LineWidth', 1.5);
hold on
stairs(pptime, ppdata(:, 2), 'LineWidth', 1.5);
stairs(pptime, ppdata(:, 3), 'LineWidth', 1.5);
hold off

legend("y(z)", "w(z)", "z(z)");
xlabel("Time");
ylabel("y(z)");
title("Gyroscopic stabilization Pole-Placement");
grid on;

%% LQR vs Pole Placement
[A, B, C, D] = tf2ss(num, den);
Qc = 1;
Rc = 1;

Q = Qc * (C' * C);
R = Rc;

K = lqr(A, B, Q, R);
N = -inv(C * inv(A - B*K) * B);
Acl = A - B * K;
Bcl = B * N;

[num, den] = ss2tf(Acl, Bcl, C, D);
lqrtflin = tf(num, den);

lqrsimdata = sim("lqrsim.slx");

ylqrdata = lqrsimdata.simout.Data;
ylqrtime = lqrsimdata.simout.Time;

figure("Name", "LQR vs Pole-Placement");
stairs(ylqrtime, ylqrdata(:, 1), 'r', 'LineWidth', 1.5);
hold on;
plot(ylqrtime, ylqrdata(:, 2), 'LineWidth', 1.5);
stairs(ylqrtime, ylqrdata(:, 3), 'LineWidth', 1.5);

legend("Pole-Placement regulator", "Feedforward LQR", "w(t)");
xlabel("Time");
ylabel("Response");
title("LQR vs Pole-Placement");
grid on;

%% Dead-beat
dtf = c2d(tflin, Ts, 'zoh');
dtflin.num = cell2mat(dtf.Numerator);
dtflin.den = cell2mat(dtf.Denominator);

tfDBReg = DBReg(dtflin);
dbsimdata = sim("dbsim.slx");

dbtime = dbsimdata.simout.Time;
dbdata = dbsimdata.simout.Data;

figure("Name", "Dead Beat Regulator");
stairs(dbtime, dbdata(:, 1), 'LineWidth', 1.5);
hold on
stairs(dbtime, dbdata(:, 2), 'LineWidth', 1.5);
stairs(dbtime, dbdata(:, 3), 'LineWidth', 1.5);
hold off

legend("y(z)", "u(z)", "z(z)");
xlabel("Time");
ylabel("y(z)");
title("Gyroscopic stabilization Dead Beat");
grid on;
