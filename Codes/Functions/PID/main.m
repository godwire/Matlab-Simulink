tfun = tf(1, [1 9 16]);

alpha = 2;
NaslinRegPI = NaslinPI(tfun, alpha)
MOMRegPI = MomPI(tfun)
ZiegNicPI = ZiegNic(tfun, "PID")