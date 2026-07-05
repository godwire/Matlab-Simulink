J = 0.5;
b = 2;
Kg = 0.3;
k = 1;
Ts = 0.95;

num = 1/J;
den = [1, (b - Kg)/J, k/J];

tflin = tf(num, den);
dtflin = c2d(tflin, Ts, "zoh");

low = -1;
high = 1;
freq = 1;
Tfinal = 40;
noise_std = 0.01;
[t, u] = pwm(low, high, freq, Tfinal, Ts, noise_std);

y = lsim(dtflin, u, t);

% stairs(t, u)
% hold on
% stairs(t, y)

data_train = iddata(y, u', Ts);

na = 2; nb = 2; nk = 0;
model_arx = arx(data_train, [na nb nk]);
tfarx.num = model_arx.B;
tfarx.den = model_arx.A;

% [y, t] = step(tflin);
% [yd, td] = step(dtflin);

% plot(t, y);
% hold on
% stairs(td, yd)