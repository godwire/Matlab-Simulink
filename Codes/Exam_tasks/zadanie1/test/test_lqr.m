J = 2;
b = 1;
Kg = 0.5;
k = 4;

numerator = 1/J;  
denominator = [1, (b - Kg)/J, k/J];

sys = tf(numerator, denominator);

R = 1;

[A,B,C,D] = tf2ss(numerator, denominator);

Q = 80*(C')*C;
[K,S,P] = lqr(A,B,Q,R);
sys = ss(A-B*K,B,C,D);

[num, den] = ss2tf(A-B*K, B, C, D);

step(tf(num, den))