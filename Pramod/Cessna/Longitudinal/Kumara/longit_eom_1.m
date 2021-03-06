
function [F] = longit_eom_1(x)

V=x(1);
alfa=x(2);
gama=x(3);
q=x(4);

m=15119.28;
rho=1.225;
c=3.511296;
Iyy=205125.76;
S=37.16;

T=35561.2344;
deltae=-0.206768;

       CD= 4.267648255 *(alfa)^2 -0.2509555143 *(alfa)  + 0.1423
       CL= 4.302913041 *(alfa)   +0.825059225  *(deltae)+ 0.732
       Cm=-0.2503825565*(alfa)   -1.122997278  *(deltae)- 0.123*(q)-0.1885

       
       F(1)=  (T*cos(alfa)-(0.5*rho*V^2*S*CD)-(m*9.81*sin(gama)))/m
       F(2)=q-(T*sin(alfa)+(0.5*rho*V^2*S*CL)-(m*9.81*cos(gama)))/(m*V)
       F(3)=  (T*sin(alfa)+(0.5*rho*V^2*S*CL)-(m*9.81*cos(gama)))/(m*V)
       F(4)=  (0.5*rho*V^2*S*Cm*c)*(0.5/Iyy)
end

