clear
close all
clc

%% Controller Parameters
Kp = 100000;
Kd = 100000;

%% Initial Conditions
% Dynamical Model
qInitDM = [zeros(14, 1)];

% Simscape Multi-Body Model
qInitSM = [zeros(14, 1)];
