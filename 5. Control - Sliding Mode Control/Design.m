clear
close all
clc

%% Controller Parameters
Lambda = 50000;
Eta = 50000;

%% Initial Conditions
% Dynamical Model
qInitDM = [rand(7, 1); zeros(7, 1)];

% Simscape Multi-Body Model
qInitSM = [rand(7, 1); zeros(7, 1)];
