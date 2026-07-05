function [r0, r1, r_1] = GL_PI(Gp)

    [num, den] = tfdata(Gp, 'v');
    w0 = den(2)/1.75;
    K = ((2.15*(w0^2))-den(end))/num(end);
    Ti = (num(end)*K)/(w0^3);

    r0 = K;
    r1 = 0;
    r_1 = K/Ti;
end