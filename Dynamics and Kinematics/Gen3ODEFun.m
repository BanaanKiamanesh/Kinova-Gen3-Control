function x_dot = Gen3ODEFun(t, x, tau)
% Auto-generated numeric ODE function by ManipulatorDynamics.
% Uses compiled mex helpers for B, C, g.
n = 7;
q  = x(1:n);
qd = x(n+1:end);
B  = Gen3ODEFun_B(q);
C  = Gen3ODEFun_C(q, qd);
g  = Gen3ODEFun_g(q);
fv = [0 0 0 0 0 0 0]';
fc = [0 0 0 0 0 0 0]';
friction = fv.*qd + fc.*sign(qd);
qdd = B \ (tau - C*qd - friction - g);
x_dot = [qd; qdd];
end
