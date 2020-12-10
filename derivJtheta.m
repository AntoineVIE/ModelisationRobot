function dJtheta = derivJtheta(phi,theta,psi)
  dJtheta = zeros(3);
  dJtheta(1,1) = cos(theta)*sin(psi);
  dJtheta(2,1) = cos(theta)*cos(psi);
  dJtheta(3,1) = -sin(theta);
end %function