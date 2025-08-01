clear
close all
clc

%% Controller Parameters
n  = 7;
Kp = 250000;
Kd = 1000;

% Comment out for SM
% Kp = 500000;
% Kd = 500000;

% Lyapunov
A = [zeros(n, n), eye(n); -diag(Kp*ones(n, 1)), -diag(Kd*ones(n, 1))];
B = [zeros(n, n); eye(n)];
Q = eye(2*n);
P = lyap(A', Q);

% Robust term params
epsilon = 0.01;
alpha   = 0.9;
gamma1  = 3.5; gamma2 = 1.8; gamma3 = 5;

%% Initial Conditions
% Dynamical Model
qInitDM = [rand(n, 1); zeros(n, 1)];

% Simscape Multi-Body Model
qInitSM = [rand(n, 1); zeros(n, 1)];
