clear
close all
clc

%% Controller Parameters
Lambda = [500000 * ones(2, 1); 50000 * ones(5, 1)];
Eta = [500000 * ones(2, 1); 50000 * ones(5, 1)];

%% Initial Conditions
% Dynamical Model
qInitDM = [rand(7, 1); zeros(7, 1)];

% Simscape Multi-Body Model
qInitSM = [rand(7, 1); zeros(7, 1)];
