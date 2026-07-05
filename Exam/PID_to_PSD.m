function [q0,q1,q2] = PID_to_PSD(Kp,Kd,Ki,T_vz)
   
    K = Kp;
    Ti = Kp/Ki;
    Td = Kp*Kd;

    q0 = K*(1+(T_vz/(2*Ti))+(Td/T_vz));
    q1 = -K*(1+((2*Td)/T_vz)-(T_vz/(2*Ti)));
    q2 = K*(Td/T_vz);

end

