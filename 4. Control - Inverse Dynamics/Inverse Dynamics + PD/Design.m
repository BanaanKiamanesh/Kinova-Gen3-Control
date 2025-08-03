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
qInitDM = [zeros(14, 1)];

% Simscape Multi-Body Model
qInitSM = [zeros(14, 1)];

%% Derivative Filter(High Pass as Smooth Derivative)
W = 2 * pi * 50;
Zeta = 1 / sqrt(2);

DF.num = [W^2, 0];
DF.den = [1, 2*Zeta*W, W^2];

%% Load Robot for Inverse Kinematics
robot = loadrobot('kinovaGen3');
robot.DataFormat = 'column';