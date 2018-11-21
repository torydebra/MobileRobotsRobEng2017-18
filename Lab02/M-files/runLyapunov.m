close all
clearvars
clc

% Specification of the system and the robot
R = 2; % radius of the circle (desired trajectory)
wd = 0.5; % angular velocity for the circle (desired trajectory)
Kx = 1; % gain for x position
Ky = 1; % gain for y position
Ktheta = 1; % gain for theta orientation
thetadInit = pi/2; % desired initial theta
Xi = [2.3; 0; pi]; % initial state
r = 0.1; % real wheel radius
L = 0.13; % real distance between the wheels and the robot centre
r_controller = 0.1; % estimated wheel radius
L_controller = 0.143; % estimated distance between the wheels and the robot centre
satMax = inf; % max value of the saturation
satMin = -inf; % min value of the saturation
time = 20; % simulation duration

% Run the simulation on Simulink
sim('lyapunovControlLaw');

% Plot the trajectory of the robot
figure;
hold on, plot(X(:,1), X(:,2),'-','LineWidth',2);
hold on, plot(Xd(:,1), Xd(:,2),'-','LineWidth',2);
title('Trajectory of the robot');
legend('M trajectory','Desired M trajectory');
xlabel('x position in world frame[m]'); ylabel('y position in world frame [m]');

% Plot error between X and Xd (Md-M)
errorXd_X = [sqrt((Xd_X(:,1).^2)+(Xd_X(:,2).^2)), Xd_X(:,3)];
figure;
plot(tout,errorXd_X,'-','LineWidth',2);
title('Error between Xd and X');
legend('x and y','theta');
xlabel('time [s]'); ylabel('Trajectory and theta error [m, rad]');

% Plot error between wd and w (wd-w)
figure;
plot(tout,wd_w,'-','LineWidth',2);
title('Error between wd and w (wd-w)');
xlabel('time [s]'); ylabel('Error [rad/s]');

% Plot error between vd and v (vd-v)
figure;
plot(tout,vd_v,'-','LineWidth',2);
title('Error between vd and v (vd-v)');
xlabel('time [s]'); ylabel('Error [m/s]');

% Plot wheel spins
figure;
plot(tout,spin,'-','LineWidth',2);
title('Wheel spins');
legend('right','left');
xlabel('time [s]'); ylabel('spin angular velocity [rad/s]');