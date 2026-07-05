function [G_R,Q,P] = dB_controller(Gp,u_max)
    
    [num, den] = tfdata(Gp, 'v');
    num = num / den(1);
    den = den / den(1);

    b1 = num(end-1);
    b2 = num(end);
    b_sum = sum(num);
    a1 = den(end-1);
    a2 = den(end);

    if nargin < 2
        q0 = 1/b_sum;
        q1 = a1 * q0;
        q2 = a2 * q0;
        
        p1 = b1 * q0;
        p2 = b2 * q0;

        Q = [q0, q1, q2];
        P = [1, p1, p2];

    else
        q0 = u_max;
        q1 = (a1 - 1)*q0 + 1/b_sum;
        q2 = (a2 - a1)*q0 + a1/b_sum;
        q3 = -a2*q0 + a2/b_sum;

        p1 = b1 * q0;
        p2 = (b2 - b1)*q0 + b1/b_sum;
        p3 = -b2*q0 + b2/b_sum;

        Q = [q0, q1, q2, q3];
        P = [1, p1, p2, p3];
    end

    G_R = tf(Q, P, Gp.Ts);
end