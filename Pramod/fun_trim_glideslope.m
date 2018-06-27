function [f ] = fun_trim_glideslope(x)


g = 9.8;
I_yy = 1824.93;
%gamma=pi/180;
%gamma=pi/180

alpha=5*pi/180 ; %in radians
rho = 1.225;
m = 1043.26;
C_bar = 1.493;
b = 10.911;
S_ref = 16.1651;
C_L_0 = 0.25;
C_L_alpha = 4.47;
C_L_q = 1.7;
C_L_delta_e = 0.3476;
C_D_0 = 0.036;
k = 0.3;
C_M_0 = -0.02;
C_M_alpha = -1.8;
C_M_alpha_dot = -12.4;
C_M_delta_e = -1.28;
delta_e=-( C_M_0 +C_M_alpha*alpha)/C_M_delta_e;
C_L = C_L_0 + C_L_alpha*alpha +   C_L_delta_e*delta_e;
C_D = C_D_0 + k*C_L^2;
 T=0;
% disp(T)
% disp(V)
F(1)=-0.5*rho*x(1)^2*S_ref*C_D-m*g*sin(x(2))
F(2)=-0.5*rho*x(1)^2*S_ref*C_L+m*g*cos(x(2))
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here


end

