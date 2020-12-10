% Analyse pendule 
clear all; close all; format compact; format short g;

%CI
teta_init = 70;
teta_init = teta_init/180*pi;
dteta_init = 0;

%Domaine temporel
t0 = 0; tmax = 20;

%Paramètres
g = 9.81; l= 1;
param(1) = g; param(2) = l;

%Fonction
fon = @(T,Y) [Y(2); -g/l*sin(Y(1))];


%Résolution numérique
[T,Y] = ode45(fon,[t0,tmax],[teta_init, dteta_init],[],param);

%Traçage
figure;
subplot(2,1,1);
  plot(T,Y(:,1));
  title('Pendule simple') ; ;
  ylabel('\theta (t) [rad]') ;
subplot(2,1,2);
  plot(T,Y(:,2));
  ylabel('\omega (t) [rad/sec]') ;
  xlabel('temps [sec]');
  

