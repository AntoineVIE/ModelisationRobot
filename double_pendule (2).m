 m1=2;m2=1;L1=1;L2=2;g=9.81;
epsilon = 1e-3;
pos0 = [pi/2;0;pi;0];
pos1 = pos0 - epsilon;
function ypoint = double_pendulum(t,y)
  ypoint = zeros(4,1);
  m1=2;m2=1;L1=1;L2=2;g=9.81;
  a = (m1+m2)*L1 ;
  b = m2*L2*cos(y(1)-y(3)) ;
  c = m2*L1*cos(y(1)-y(3));
  d = m2*L2 ;
  e = -m2*L2*y(4)*y(4)*sin(y(1)-y (3 ))-g*(m1+m2)*sin(y(1)) ;
  f = m2*L1*y(2)*y(2)*sin(y(1)-y(3))-m2*g*sin(y(3));
  ypoint(1) = y(2);
  ypoint(3) = y(4);
  ypoint(2) = (e*d-b*f)/(a*d-c*b);
  ypoint(4) = (a*f-c*e)/(a*d-c*b);

endfunction


[t,y] = ode45(@(t,y) double_pendulum(t,y), [0,20], pos0');
[t1,y1] = ode45(@(t,y) double_pendulum(t,y), [0,20], pos1');
  
xprime = L1*sin(y(:,1))+L2*sin(y(:,3));
yprime = -L1*cos(y(:,1))-L2*cos(y(:,3));

xprime1 = L1*sin(y1(:,1))+L2*sin(y1(:,3));
yprime1 = -L1*cos(y1(:,1))-L2*cos(y1(:,3));

subplot(2,3,1)
plot(t,xprime);
hold on
plot(t1,xprime1);
ylabel("X(t)");
subplot(2,3,2)
plot(t,yprime);
hold on;
plot(t1,yprime1);
ylabel("Y(t)");
subplot(2,3,3)
plot(xprime,yprime);
hold on
plot(xprime1,yprime1);
xlabel("Plan de phase Y(X)");
subplot(2,3,4)
plot(t,y(:,1));
hold on
plot(t1,y1(:,1));
ylabel("Theta_1(t)");
subplot(2,3,5)
plot(t,y(:,3));
hold on
plot(t1,y1(:,3));
ylabel("Theta_2(t)");
subplot(2,3,6)
plot(y(:,1),y(:,3))
hold on
plot(y1(:,1),y1(:,3))
title('Plan de phase')