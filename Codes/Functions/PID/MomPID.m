function Reg = MomPID(tfun)
    sys = tfnorm(tfun);
    M_s = sys.num;
    N_s = sys.den;

    eN_s = zeros(1, 5);
    eN_s(1:length(N_s(2:end))) = N_s(2:end);
    N_s = eN_s;
    
    a1 = N_s(1);
    a2 = N_s(2);
    a3 = N_s(3);
    a4 = N_s(4);
    a5 = N_s(5);

    A = [
      a1  -1   0;
      a3 -a2   a1;
      a5 -a4   a3
    ];

    B = (1/(2*M_s)) * [1; -a1^2 + 2*a2; a2^2 - 2*a1*a3 + 2*a4];

    if rank(A) < min(size(A))
        disp('Matrix A is singular or rank deficient. Solving with least-squares solution.');
        R = lsqminnorm(A, B); 
    else
        R = linsolve(A, B);
    end
    
    Reg.P = R(1);
    Reg.I = R(2);
    Reg.D = R(3);
end