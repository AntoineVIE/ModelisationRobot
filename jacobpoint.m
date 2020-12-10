function Jpoint = jacobpoint(phi,theta,psi,dpsi,dtheta)
  Jpoint = zeros(3);
  Jpoint(1,1) = cos(theta)*sin(psi)*dtheta+sin(theta)*cos(psi)*dpsi;
  Jpoint(1,2) = -sin(psi)*dpsi;
  Jpoint(2,1) = cos(theta)*cos(psi)*dtheta-sin(theta)*sin(psi)*dpsi;
  Jpoint(2,2) = -cos(psi)*dpsi;
  Jpoint(3,1) = -sin(theta)*dtheta;
end %function

