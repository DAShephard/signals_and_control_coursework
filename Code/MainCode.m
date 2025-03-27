s = tf('s');

G_system = (1.151*s + 0.1463) / (s^3 + 0.735*s^2 + 1.05*s)
G_system

f1 = figure;
t = [0:0.01:25];
step(G_system,t);
axis([0 25 0 5]);
ylabel('Step Response of G_{system}(s)');
xlabel('Time');

pole(G_system);

G_sensor = tf(1,[0.0021 1],'InputDelay',0.0063);
G_sensor

G_actuator = 1 / (0.014*s + 1);
G_actuator

G_closedloop_nc = feedback(series(G_system, G_actuator), G_sensor);

f2 = figure;
t = [0:0.01:25];
step(G_closedloop_nc,t);
axis([0 25 0 3]);
ylabel('Step Response of G_{closed loop}(s) without G_{controller}');
xlabel('Time');

pole(G_closedloop_nc)

Kc = 7.6808;
tauI = 1.62;
tauD = 0.6561;
G_controller = Kc * (1 + (1 / tauI*s) + tauD*s);
G_controller

s0 = series(G_system, G_controller);
G_closedloop = feedback(series(s0, G_actuator), G_sensor);

f3 = figure;
t = [0:0.01:5];
step(G_closedloop,t);
axis([0 5 0 3]);
ylabel('Step Response of G_{closed loop}(s)');
xlabel('Time');

exportgraphics(f1,'figure_1.png','Resolution',300)
exportgraphics(f2,'figure_2.png','Resolution',300)
exportgraphics(f3,'figure_3.png','Resolution',300)