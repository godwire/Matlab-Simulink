T1 = 0.01;
T2 = 0.05;
T_vz = 0.1;
K = 1;

s = tf('s');

Gp = K/(T1*s*(T2*s+1));

[num, den] = tfdata(Gp, 'v');

% [q0,q1,q2] = PID_to_PSD(Kp,Kd,Ki,T_vz);

methoda = "ZN";

if methoda == "Naslin"
    [Kp, Kd, Ki] = naslin_PI(2,Gp);
    disp([Kp,Kd,Ki])

    out = sim("motor.slx");
    
    e = out.motor.Data(:,1);
    y = out.motor.Data(:,2);
    w = out.motor.Data(:,3);
    u = out.motor.Data(:,4);

    t = out.tout;

    [Kp,Kd,Ki] = GL_PI(Gp);
    disp([Kp,Kd,Ki])

    out1 = sim("motor.slx");
    
    e1 = out.motor.Data(:,1);
    y1 = out.motor.Data(:,2);
    w1 = out.motor.Data(:,3);
    u1 = out.motor.Data(:,4);

    t1 = out.tout;

    custom_plot2(t,y,w,u,e,t1,y1,u1,e1,methoda,[],[-1,1],[0,1.5],"Naslin");
end

if methoda == "ZN"
    [Kp,Kd,Ki] = Z_N1(Gp,"PID");
    disp([Kp,Kd,Ki])

    out = sim("motor.slx");
    
    e = out.motor.Data(:,1);
    y = out.motor.Data(:,2);
    w = out.motor.Data(:,3);
    u = out.motor.Data(:,4);

    t = out.tout;

    custom_plot(t,y,w,u,e,methoda,[],[-1,1],[0,1.5]);
end

if methoda == "PID-PSD"
    [Kp,Kd,Ki] = naslin_PI(2, Gp);

    out = sim("motor.slx");
    
    e = out.motor.Data(:,1);
    y = out.motor.Data(:,2);
    w = out.motor.Data(:,3);
    u = out.motor.Data(:,4);

    t = out.tout;

    [num, den] = tfdata(Gp, 'v');
    T_vz = 0.01;
    Gp_z = c2d(Gp,T_vz);
    [q0,q1,q2] = PID_to_PSD(Kp,Kd,Ki,T_vz);

    out = sim("motor_PSD.slx");
    
    e1 = out.motor.Data(:,1);
    y1 = out.motor.Data(:,2);
    w1 = out.motor.Data(:,3);
    u1 = out.motor.Data(:,4);

    t1 = out.tout;

    custom_plot2(t,y,w,u,e,t1,y1,u1,e1,methoda,[],[-1,1],[0,1.5],"PID","PSD");
end

disp("Параметры PID-регулятора:");
fprintf("Kp = %.4f\n", Kp);
fprintf("Ki = %.4f\n", Ki);
fprintf("Kd = %.4f\n", Kd);

Gp_z = c2d(Gp,T_vz);

[G_R_nolimit, Q_nolimit, P_nolimit] = dB_controller(Gp_z);
Q = Q_nolimit;
P = P_nolimit;

out = sim("DB.slx");
custom_plot3(out.tout,out.db.Data(:,3),out.db.Data(:,2),out.db.Data(:,4),out.db.Data(:,1),"DB bez ohranicenia",[],[],[0,2]);
