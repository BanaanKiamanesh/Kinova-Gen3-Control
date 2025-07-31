clear
close all
clc

%% Controller Parameters
Kp = 10000;
Kd = 10000;

% for SimScape
KpSM = 50000;
KdSM = 50000;

%% Initial Conditions
% Dynamical Model
qInitDM = [rand(7, 1); zeros(7, 1)];

% Simscape Multi-Body Model
qInitSM = [rand(7, 1); zeros(7, 1)];
