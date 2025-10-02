% 3DoF Rocket Landing: cascaded PID control
% Monte Carlo runs for the simulink block design

% To run: Check the file system
% Cross check the simulink for data out
simulinkFile = './rocket3DoF.slx';
NSims = 10;
Xstore = cell(1, NSims);

for kk = 1:10
    x0 = -5 + 10 * rand; 
    z0 = 150 + 20 * rand; 
    vx0 = -1 + 2*rand; 
    vz0 = -11 + 2*rand; 
    theta0 = deg2rad(-5 + 10*rand);
    omega0 = deg2rad(0); 
    
    X0 = [x0, z0, vx0, vz0, theta0, omega0];

    assignin('base', 'X0', X0);
    out = sim(simulinkFile);
    traj = out.matlab_stateTrajectory; 
    Xstore{kk} = traj;
end

%
figure; 
hold on;
for kk = 1:NSims
    curr_traj = Xstore{kk}; 
    plot(curr_traj(:,1), curr_traj(:,2), '-.','LineWidth', 1.25, 'Color',[.5 .5 .5]);
    plot(curr_traj(1,1), curr_traj(1,2), 'sr','MarkerSize', 5, 'MarkerFaceColor','r');
end
plot(0, 3, 'sb','MarkerSize', 5, 'MarkerFaceColor','b');
hold off; grid on;
xlabel('x [m]'); ylabel('z [m]'); grid on; hold off; 
title('Monte Carlo Sim');
