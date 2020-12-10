%************Toupie lagrangienne********
phi0 = 0.1; theta0 = 0.1; psi0=0;
dphi0 =10/180*pi; dtheta0 = 10/180*pi; dpsi0 = 2*pi;
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

function J = jacob(phi,theta,psi)
  J = zeros(3);
  J(1,1) = sin(theta)*sin(psi);
  J(1,2) = cos(psi);
  J(2,1) = sin(theta)*cos(psi);
  J(2,2) = -sin(psi);
  J(3,1) = cos(theta);
  J(3,3) = 1;
endfunction

function Jpoint = jacobpoint(phi,theta,psi,dpsi,dtheta)
  Jpoint = zeros(3);
  Jpoint(1,1) = cos(theta)*sin(psi)*dtheta+sin(theta)*cos(psi)*dpsi;
  Jpoint(1,2) = -sin(psi)*dpsi;
  Jpoint(2,1) = cos(theta)*cos(psi)*dtheta-sin(theta)*sin(psi)*dpsi;
  Jpoint(2,2) = -cos(psi)*dpsi;
  Jpoint(3,1) = -sin(theta)*dtheta;
  endfunction

function dJtheta = derivJtheta(phi,theta,psi)
  dJtheta = zeros(3);
  dJtheta(1,1) = cos(theta)*sin(psi);
  dJtheta(2,1) = cos(theta)*cos(psi);
  dJtheta(3,1) = -sin(theta);
endfunction

function dJpsi = derivJpsi(phi,theta,psi)
  dJpsi = zeros(3);
  dJpsi(1,1) = sin(theta)*cos(psi);
  dJpsi(1,2) = -sin(psi);
  dJpsi(2,1) = -sin(theta)*sin(psi);
  dJpsi(2,2) = -cos(psi);
endfunction
 
function ypoint = fonction(t,y,M,g,l,I)
  J = jacob(y(1),y(3),y(5));
  Jpoint = jacobpoint(y(1),y(3),y(5),y(6),y(4));
  dJtheta = derivJtheta(y(1),y(3),y(5));
  dJpsi = derivJpsi(y(1),y(3),y(5));
  ang = [y(1);y(3);y(5)];
  vit = [y(2);y(4);y(6)];
  dTq = [0 ; vit'*J'*I*dJtheta*vit; vit'*J'*I*dJpsi*vit];
  ypoint(1,1) = y(2);
  ypoint(3,1) = y(4);
  ypoint(5,1) = y(6);
  %matrice = -inv(J'*I*J)*(2*J'*I*Jpoint*vit-2*vit'*J'*I*dMq*vit);
  %matrice = -inv(J'*I*J)*(2*J'*I*Jpoint*vit-dTq-M*g*l*[0;-sin(ang(2));0]);
  matrice = -inv(J'*I*J)*(2*J'*I*Jpoint*vit-dTq);
  ypoint(2,1) = matrice(1)
  ypoint(4,1) = matrice(2);
  ypoint(6,1) = matrice(3);
  %ypoint(2,1) = (-pinv(J'*I*J)*(2*J'*I*J*vit-2*vit'*J'*I*dMq*vit+M*g*l*cos(y(1))))(1);
  %ypoint(4,1) = (-pinv(J'*I*J)*(2*J'*I*J*vit-2*vit'*J'*I*dMq*vit+M*g*l*cos(y(1))))(2);
  %ypoint(6,1) = (-pinv(J'*I*J)*(2*J'*I*J*vit-2*vit'*J'*I*dMq*vit+M*g*l*cos(y(1))))(3);
endfunction

[t,y] = ode45(@(t,y) fonction(t,y,M,g,l,I),[0 tmax], q0');


phi = y(:,1);
dphi = y(:,2);
theta = y(:,3);
dtheta = y(:,4);
psi = y(:,5);
dpsi = y(:,6);
subplot(1,4,1)
plot(t,psi);
subplot(1,4,2)
plot(t,phi);
subplot(1,4,3)
plot(t,theta);
subplot(1,4,4)
plot3(phi,theta,psi);

%plot3(phi,theta,psi);
%xlabel('phi(t)')
%ylabel('theta(t)')
%zlabel('psi(t)')
