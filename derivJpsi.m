function dJpsi = derivJpsi(phi,theta,psi)
  dJpsi = zeros(3);
  dJpsi(1,1) = sin(theta)*cos(psi);
  dJpsi(1,2) = -sin(psi);
  dJpsi(2,1) = -sin(theta)*sin(psi);
  dJpsi(2,2) = -cos(psi);
end %function