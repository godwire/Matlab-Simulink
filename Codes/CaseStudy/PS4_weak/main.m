% Prenosová funkcia motora (napr. z cvičenia)
[a,b] = motor();
dtf.num = b;
dtf.den = [1, a];

% Predpísané póly uzavretého obvodu
poles = [0.1, 0.2, 0.3, 0.4];  % alebo iné

% Výpočet regulátora
Reg = ppc(dtf, poles);

disp('Polynomiálny regulátor:');
disp('Q(z):'); disp(Reg.num);
disp('P(z):'); disp(Reg.den);


%Plot
tspan = 2;
desr = [1 1.1];
desr_val = 0.01;

data = sim("reg.slx");
nas_t = data.tout;
w_t = data.simout.Data(:, 1);
y_t = data.simout.Data(:, 2);
u_t = data.simout.Data(:, 3);
e_t = data.simout.Data(:, 4);

%Plot y(t)
figure;
stairs(nas_t, y_t, 'LineWidth', 2,'Color',"r");
hold on;
stairs(nas_t, w_t, 'LineWidth', 2,'Color',"b");
legend ("y(t)","w(t)");
hold off;
grid on;
title("PP Regulator");
xlabel("Time");
ylabel("y(t)");

%Plot u(t)
figure;
stairs(nas_t, u_t, 'LineWidth', 2,'Color',"r");
hold on;
stairs(nas_t, w_t, 'LineWidth', 2,'Color',"b");
legend ("u(t)","w(t)");
hold off;
grid on;
title("PP Regulator");
xlabel("Time");
ylabel("u(t)");

%Plot e(t)
figure;
stairs(nas_t, e_t, 'LineWidth', 2,'Color',"r");
hold on;
stairs(nas_t, w_t, 'LineWidth', 2,'Color',"b");
legend ("e(t)","w(t)");
hold off;
grid on;
title("PP Regulator");
xlabel("Time");
ylabel("e(t)");