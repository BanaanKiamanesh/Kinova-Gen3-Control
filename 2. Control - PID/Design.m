clear
close all
clc

%% Controller Parameters
Kp = 100;
Kd = 100;
Ki = 20;

%% Initial Conditions
% Dynamical Model
qInitDM = [rand(7, 1); zeros(7, 1)];    % Joint Velocities Set to 0

% Simscape Multi-Body Model
qInitSM = [rand(7, 1); zeros(7, 1)];    % Joint Velocities Set to 0