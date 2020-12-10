function J = jacob(phi,theta,psi)
  J = zeros(3);
  J(1,1) = sin(theta)*sin(psi);
  J(1,2) = cos(psi);
  J(2,1) = sin(theta)*cos(psi);
  J(2,2) = -sin(psi);
  J(3,1) = cos(theta);
  J(3,3) = 1;
end %function