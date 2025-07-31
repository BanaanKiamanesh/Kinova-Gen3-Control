clear
close all
clc

%% Controller Parameters
Kp = 500000;
Kd = 500000;

% for SimScape
KpSM = 500000;
KdSM = 500000;

%% Initial Conditions
% Dynamical Model
qInitDM = [rand(7, 1); zeros(7, 1)];

% Simscape Multi-Body Model
qInitSM = [rand(7, 1); zeros(7, 1)];
