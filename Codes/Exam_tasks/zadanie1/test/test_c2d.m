J = 2;
b = 1;
Kg = 0.5;
k = 4;

numerator = 1/J;  
denominator = [1, (b - Kg)/J, k/J];

sys = tf(numerator, denominator);

[y, tOut] = step(sys);
[y1, tOut1] = step(c2d(sys, 0.2, 'tustin'));

stairs(tOut1, y1)
hold on
plot(tOut, y)
