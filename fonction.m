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
  ypoint(2,1) = matrice(1);
  ypoint(4,1) = matrice(2);
  ypoint(6,1) = matrice(3);
  
  

  
  %ypoint(2,1) = (-pinv(J'*I*J)*(2*J'*I*J*vit-2*vit'*J'*I*dMq*vit+M*g*l*cos(y(1))))(1);
  %ypoint(4,1) = (-pinv(J'*I*J)*(2*J'*I*J*vit-2*vit'*J'*I*dMq*vit+M*g*l*cos(y(1))))(2);
  %ypoint(6,1) = (-pinv(J'*I*J)*(2*J'*I*J*vit-2*vit'*J'*I*dMq*vit+M*g*l*cos(y(1))))(3);
end %function