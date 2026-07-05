R = 50;
L = 1.5;
C = 100e-6;

num = 1;
den = [L R 1/C];
sys = tf(num, den);

step(sys)