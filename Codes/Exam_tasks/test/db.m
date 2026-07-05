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
Gz = c2d(tflin, Ts, 'zoh');

dtf.num = cell2mat(Gz.Numerator);
dtf.den = cell2mat(Gz.Denominator);

RegStruct = DBReg(dtf);