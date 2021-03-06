close all
clearvars
clc

% Specification of the system and the robot
R = 2; % radius of the circle (desired trajectory)
wd = 0.5; % angular velocity for the circle (desired trajectory)
Kp = eye(2); % gain position control law
d = 0.15; % distance between M and P
Xi = [2.3; 0; pi]; % initial state
r = 0.1; % real wheel radius
L = 0.13; % real distance between the wheels and the robot centre
r_controller = 0.1; % estimated wheel radius
L_controller = 0.13; % estimated distance between the wheels and the robot centre
satMax = inf; % max value of the saturation
satMin = -inf; % min value of the saturation
time = 20; % simulation duration

% Run the simulation on Simulink
sim('staticDecouplingControl');

% Plot the trajectory of the robot
figure;
plot(P(:,1),P(:,2),'-','LineWidth',2); 
hold on, plot(X(:,1), X(:,2),'-','LineWidth',2);
hold on, plot(hd(:,1), hd(:,2),'-','LineWidth',2);
title('Trajectory of the robot');
legend('P trajectory','M trajectory','Desired P trajectory');
xlabel('x position in world frame[m]'); ylabel('y position in world frame [m]');

% Plot theta angle of the state X
theta = wrapTo2Pi(X(:,3));
theta = radtodeg(theta);
figure;
plot(tout,theta,'-','LineWidth',2);
title('Theta angle of the state X [deg]');
xlabel('time [s]'); ylabel('degrees [deg]');

% Plot error between h and hd (Pd-P)
errorPd_P = sqrt((Pd_P(:,1).^2)+(Pd_P(:,2).^2));
figure;
plot(tout,errorPd_P,'-','LineWidth',2);
title('Error between hd and h (Pd-P)');
xlabel('time [s]'); ylabel('error [m]');

% Plot error between h and X (P-M)
figure;
plot(tout,P_M,'-','LineWidth',2);
title('Error between h and X (P-M)');
legend('x','y');
xlabel('time [s]'); ylabel('x and y error [m]');

% Plot error between wd and w (wd-w)
figure;
plot(tout,wd_w,'-','LineWidth',2);
title('Error between wd and w (wd-w)');
xlabel('time [s]'); ylabel('Error [rad/s]');

% Plot wheel spins
figure;
plot(tout,spin,'-','LineWidth',2);
title('Wheel spins');
legend('right','left');
xlabel('time [s]'); ylabel('spin angular velocity [rad/s]');