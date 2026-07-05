close all;
clc;
clear;

% J = input('Enter the moment of inertia of the platform (J): ');
% b = input('Enter the damping coefficient (b): ');
% Kg = input('Enter the gyroscopic steering coefficient (Kg): ');
% k = input('Enter the elasticity coefficient (k): ');
J = 0.5;
b = 2;
Kg = 0.1;
k = 1;
Ts = 0.95;

num = 1/J;
den = [1, (b - Kg)/J, k/J];

tflin = tf(num, den);
dtflin = c2d(tflin, Ts, "zoh");

low = -1;
high = 1;
freq = 1;
Tfinal = 100;
noise_std = 0.01;
[t, u] = pwm(low, high, freq, Tfinal, Ts, noise_std);

y = lsim(dtflin, u, t);
data_train = iddata(y, u, Ts);
%% Training data
figure("Name", "Training data")
subplot(2,1,1);
stairs (t, u, 'b', 'LineWidth', 1.5);
title('u(t)');
xlabel('Time');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
stairs(t, y, 'r', 'LineWidth', 1.5);
title('y(t)');
xlabel('Time');
ylabel('Amplitude');
grid on;

%% Model Training
na = 2; nb = 2; nk = 0;
model_arx = arx(data_train, [na nb nk]);
tfarx.num = model_arx.B;
tfarx.den = model_arx.A;

na = 2; nb = 2; nc = 2; nk = 0;
model_armax = armax(data_train, [na nb nc nk]);
tfarmax.num = model_armax.B;
tfarmax.den = model_armax.A;

Ttest = 20;
t_test = 0:Ts:Ttest;
N_test = length(t_test);

u_test = 2 * ones(N_test, 1);
u_test(round(N_test/2):end) = 0;

y_test = lsim(dtflin, u_test, t_test);
data_test = iddata(y_test, u_test, Ts);

%% Pole-Placement
tflin = tf(num, den);
dtflin = c2d(tflin, Ts, "tustin");
dtf.num = cell2mat(dtflin.Numerator);
dtf.den = cell2mat(dtflin.Denominator);

PpDTFReg = ppc(dtf, ones(1, 4) * 0.1);
PpARXReg = ppc(tfarx, ones(1, 4) * 0.3);
PpARMAXReg = ppc(tfarmax, ones(1, 4) * 0.3);

usim = 1;
tspan = [0 10];
ut = [1 5];
simdata = sim("ppsim.slx");

dtfsim = simdata.dtfsim;
darxsim = simdata.arxsim;
armaxsim = simdata.armaxsim;
y_ref = simdata.y_ref;

figure("Name", "Pole-Placement Regulator");

subplot(3,1,1);
stairs(dtfsim.Time, dtfsim.Data, 'r', "LineWidth", 1.5);
xlabel("Time");
ylabel("Inference");
title("Pole-Placement Regulator");
hold on;
plot(y_ref.Time, y_ref.Data, 'b--', "LineWidth", 1.5);
hold off;
grid on;
legend("Discrete TF + PP URO", "Y reference");

subplot(3,1,2);
stairs(darxsim.Time, darxsim.Data, 'r', "LineWidth", 1.5);
xlabel("Time");
ylabel("Inference");
title("ARX");
hold on;
plot(y_ref.Time, y_ref.Data, 'b--', "LineWidth", 1.5);
hold off;
grid on;
legend("ARX + PP URO", "Y reference");

subplot(3,1,3);
stairs(armaxsim.Time, armaxsim.Data, 'r', "LineWidth", 1.5);
xlabel("Time");
ylabel("Inference");
title("ARMAX");
hold on;
plot(y_ref.Time, y_ref.Data, 'b--', "LineWidth", 1.5);
hold off;
grid on;
legend("ARMAX + PP URO", "Y reference");

%% Dead-Beat
tfarx.num = [0 model_arx.B];
tfarmax.num = [0 model_armax.B];

dtflin = c2d(tflin, Ts, "zoh");
dtf.num = cell2mat(dtflin.Numerator);
dtf.den = cell2mat(dtflin.Denominator);

DbDTFReg = DBReg(dtf);
RegARX = DBReg(tfarx);
RegARMAX = DBReg(tfarmax);

usim = 1;
tspan = [0 10];
ut = [1 5];
simdata = sim("dbsim.slx");

dtfsim = simdata.dtfsim;
darxsim = simdata.arxsim;
armaxsim = simdata.armaxsim;
y_ref = simdata.y_ref;

figure("Name", "DeadBeat Regulator");

subplot(3,1,1);
stairs(dtfsim.Time, dtfsim.Data, 'r', "LineWidth", 1.5);
xlabel("Time");
ylabel("Inference");
title("DeadBeat Regulator");
hold on;
plot(y_ref.Time, y_ref.Data, 'b--', "LineWidth", 1.5);
hold off;
grid on;
legend("Discrete TF + DB URO", "Y reference");

subplot(3,1,2);
stairs(darxsim.Time, darxsim.Data, 'r', "LineWidth", 1.5);
xlabel("Time");
ylabel("Inference");
title("ARX");
hold on;
plot(y_ref.Time, y_ref.Data, 'b--', "LineWidth", 1.5);
hold off;
grid on;
legend("ARX + DB URO", "Y reference");

subplot(3,1,3);
stairs(armaxsim.Time, armaxsim.Data, 'r', "LineWidth", 1.5);
xlabel("Time");
ylabel("Inference");
title("ARMAX");
hold on;
plot(y_ref.Time, y_ref.Data, 'b--', "LineWidth", 1.5);
hold off;
grid on;
legend("ARMAX + DB URO", "Y reference");

%% Dead-Beat Limited u(t)
tfarx.num = [0 model_arx.B];
tfarmax.num = [0 model_armax.B];

dtflin = c2d(tflin, Ts, "zoh");
dtf.num = cell2mat(dtflin.Numerator);
dtf.den = cell2mat(dtflin.Denominator);

u_lim = 3.5;
DbDTFReg = DBRegRest(dtf, u_lim);
RegARX = DBRegRest(tfarx, u_lim);
RegARMAX = DBRegRest(tfarmax, u_lim);

usim = 1;
tspan = [0 10];
ut = [1 5];
simdata = sim("dbsim.slx");

dtfsim = simdata.dtfsim;
darxsim = simdata.arxsim;
armaxsim = simdata.armaxsim;
y_ref = simdata.y_ref;

figure("Name", "DeadBeat Regulator with limited u(t)");

subplot(3,1,1);
stairs(dtfsim.Time, dtfsim.Data, 'r', "LineWidth", 1.5);
xlabel("Time");
ylabel("Inference");
title("DeadBeat Regulator with limited u(t)");
hold on;
plot(y_ref.Time, y_ref.Data, 'b--', "LineWidth", 1.5);
hold off;
grid on;
legend("Discrete TF + DB URO", "Y reference");

subplot(3,1,2);
stairs(darxsim.Time, darxsim.Data, 'r', "LineWidth", 1.5);
xlabel("Time");
ylabel("Inference");
title("ARX");
hold on;
plot(y_ref.Time, y_ref.Data, 'b--', "LineWidth", 1.5);
hold off;
grid on;
legend("ARX + DB URO", "Y reference");

subplot(3,1,3);
stairs(armaxsim.Time, armaxsim.Data, 'r', "LineWidth", 1.5);
xlabel("Time");
ylabel("Inference");
title("ARMAX");
hold on;
plot(y_ref.Time, y_ref.Data, 'b--', "LineWidth", 1.5);
hold off;
grid on;
legend("ARMAX + DB URO", "Y reference");