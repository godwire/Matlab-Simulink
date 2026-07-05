syms s z;

J = 0.5;
b = 2;
Kg = 0.1;
k = 1;
Ts = 0.5;

num = 1/J;
den = [1, (b - Kg)/J, k/J];
tflin = tf(num, den);

dtflin = dtftust(tflin, Ts);