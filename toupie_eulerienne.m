close all 
clear all
clc
point = [];
#********TOUPIE EULERIENNE NON PESANTE***
#________CI_______
R = eye(3);
omega1 = 10/180*pi; omega2 =10/180*pi; omega3 = 2*pi;
%omega1 = 0*1; omega2 = 2; omega3=0.5;
omega = [omega1;omega2;omega3];
dt = 1e-2;
Q1=[];Q2=[];Q3=[];
OMEGA1 = []; OMEGA2=[]; OMEGA3=[];
SCH1=[];SCH2=[];SCH3=[];
ANGX = []; ANGY = []; ANGZ = [];
q0 =[10/180*pi;10/180*pi;10*180/pi];
q=[q0(1);q0(2);q0(3)];
ang=[10/180*pi;10/180*pi;10*180/pi]
%Coefficients d'inertie
M = 0.1; r = 0.01;
I2 = 3/10*M*r^2;
I1 = 5e-6; %Par défaut
I = [I1 0 0;0 I1 0;0 0 I2];
g = 9.81; l=2e-2;
#Cext=0;

#_____Integration_____
for t=0:dt:10
  #****SCHEMA DONNE****
  omega_mat = [0 -omega(3) omega(2);
               omega(3) 0 -omega(1);
              -omega(2) omega(1) 0];
  %***Toupie non pesante***
  omega = omega + dt*inv(I)*(-cross(omega,I*omega));
  %***Toupie pesante***
  %omega = omega +dt*inv(I)*(-cross(omega,I*omega)+M*g*l*[R(3,2);-R(3,1);0]);
  R = R*expm(omega_mat*dt);
  SCH1=[SCH1,omega(1)];SCH2=[SCH2,omega(2)];SCH3=[SCH3,omega(3)];
  ang(1) = ang(1) + dt*omega(1);
  ang(2) = ang(2) + dt*omega(2);
  ang(3) = ang(3) + dt*omega(3);
  ANGX = [ANGX,ang(1)]; ANGY = [ANGY,ang(2)]; ANGZ=[ANGZ,ang(3)];
  #*****VERSION ANALYTIQUE****
  OM = (I2-I1)/I1*omega(3);
  omega(1) = omega1*cos(OM*t);
  omega(2) = omega1*sin(OM*t);
  OMEGA1=[OMEGA1,omega(1)];
  OMEGA2=[OMEGA2,omega(2)];
  OMEGA3=[OMEGA3,omega(3)];
  q(1)=(omega1/OM)*sin(OM*t)+q0(1); 
  q(2) = -(omega1/OM)*cos(OM*t)+(q0(2)+omega1/OM);
  q(3) = omega3*t+q0(3);
  Q1=[Q1,q(1)];Q2=[Q2,q(2)];Q3=[Q3,q(3)]; 
endfor

t=linspace(0,10,length(OMEGA1));
subplot(1,4,1);
plot(t,ANGX);
hold on
plot(t,Q1);
ylabel("Angle x");
subplot(1,4,2);
plot(t,ANGY);
hold on
plot(t,Q2);
ylabel("Angle y");
subplot(1,4,3);
plot(t,ANGZ);
hold on
plot(t,Q3);
ylabel("Angle z");
%plot3(SCH1,SCH2,SCH3);
%plot3(SCH1,SCH2,SCH3);
%plot(Q1,Q2);
subplot(1,4,4)
plot3(ANGX,ANGY,ANGZ);
hold on 
plot3(Q1,Q2,Q3);
xlabel("Angle x");
ylabel("Angle y");
zlabel("Angle z");

%{
%changer VL
for it =1:max(size(t))
  X_R = ANGX(it);
  Y_R = ANGY(it);
  Z_R = ANGZ(it);
  
  %r = [cos(Z_R)*cos(Y_R) - sin(psi_R)*cos(theta_R)*sin(phi_R), -cos(psi_R)*sin(phi_R) - sin(psi_R)*cos(theta_R)*cos(phi_R), sin(psi_R)*sin(theta_R); 
       %sin(psi_R)*cos(phi_R) + cos(psi_R)*cos(theta_R)*sin(phi_R), -sin(psi_R)*sin(phi_R) + cos(psi_R)*cos(theta_R)*cos(phi_R), -cos(psi_R)*sin(theta_R)
       %sin(theta_R)*sin(phi_R)                                   , sin(theta_R)*cos(phi_R)                                    , cos(theta_R)              ];
   r = [cos(Z_R)*cos(Y_R), cos(Z_R)*sin(Y_R)*sin(X_R) - sin(Z_R)*cos(X_R), cos(Z_R)*sin(Y_R)*cos(X_R)+sin(Z_R)*sin(X_R);
        sin(Z_R)*cos(Y_R), sin(Z_R)*sin(Y_R)*sin(X_R) + cos(Z_R)*cos(X_R), sin(Z_R)*sin(Y_R)*cos(X_R) - cos(Z_R)*sin(X_R);
        -sin(Y_R), cos(Y_R)*sin(X_R), cos(Y_R)*cos(X_R)]   
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
}%
