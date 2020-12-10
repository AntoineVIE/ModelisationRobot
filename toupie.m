close all 
clear all
clc
point = [];
%************Toupie lagrangienne********
phi0 = 10/180*pi; theta0 = 10/180*pi; psi0 = 0*10/180*pi; %changer VL
dphi0 = 0*1; dtheta0 = 2; dpsi0=0.5; % changer VL
q0 = [phi0;dphi0;theta0;dtheta0;psi0;dpsi0];
Q1=[];Q2=[];Q3=[];
tmax = 10; 
%_________PARAMETRES______

%Coefficients d'inertie
M = 0.1; r = 0.01;
I2 = 3/10*M*r^2;
I1 = 5e-6; %Par défaut
I = [I1 0 0;0 I1 0;0 0 I2];
g = 9.81; l = 2e-2;

[t,y] = ode45(@(t,y) fonction(t,y,M,g,l,I),[0 tmax], q0');


phi = y(:,1);
dphi = y(:,2);
theta = y(:,3);
dtheta = y(:,4);
psi = y(:,5);
dpsi = y(:,6);
subplot(1,4,1)
plot(t,phi);
subplot(1,4,2)
plot(t,theta);
subplot(1,4,3)
plot(t,psi);
subplot(1,4,4)
plot3(phi,theta,psi);


%changer VL
for it =1:max(size(t))
  phi_R = y(it,1);
  theta_R = y(it,3);
  psi_R = y(it,5);
  
  r = [cos(psi_R)*cos(phi_R) - sin(psi_R)*cos(theta_R)*sin(phi_R), -cos(psi_R)*sin(phi_R) - sin(psi_R)*cos(theta_R)*cos(phi_R), sin(psi_R)*sin(theta_R); 
       sin(psi_R)*cos(phi_R) + cos(psi_R)*cos(theta_R)*sin(phi_R), -sin(psi_R)*sin(phi_R) + cos(psi_R)*cos(theta_R)*cos(phi_R), -cos(psi_R)*sin(theta_R)
       sin(theta_R)*sin(phi_R)                                   , sin(theta_R)*cos(phi_R)                                    , cos(theta_R)              ];
       
point = [point,2*r(:,3)];
figure(10)
plot3( [ 0 , r(1,1) ] , [ 0 , r(2,1) ],  [ 0 , r(3,1) ] ,'linewidth',2,'Color','r');
hold on
plot3( [ 0 , r(1,2) ] , [ 0 , r(2,2) ],  [ 0 , r(3,2) ] ,'linewidth',2,'Color','g');
plot3( [ 0 , r(1,3) ] , [ 0 , r(2,3) ],  [ 0 , r(3,3) ] ,'linewidth',2,'Color','b');
plot3(point(1,:),point(2,:),point(3,:),'linewidth',2,'Color','k');
axis square equal;
grid on;
hold off;
title(['t = ' num2str(t(it)) 's'])
xlim([-2 2])
ylim([-2 2])
zlim([-2 2])
drawnow;
pause(0.01)
end
%plot3(phi,theta,psi);
%xlabel('phi(t)')
%ylabel('theta(t)')
%zlabel('psi(t)')

