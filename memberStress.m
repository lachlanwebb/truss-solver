%{
Function to calculate the stresses in each truss member 
Vectorisation using 3D arrays requires parallel computing toolbox w/ special gpu
Author: Lachlan Webb
Date: 25/03/2018

Inputs: 
E = elastic modulus
lengths = vector of truss member lengths
u,v = nodal displacements
members = array of indexes of endpoints of each member
l = cos(alpha), where alpha is angle between member and horizontal
m = sin(alpha)

Outputs: 
stress = vector of internal stress in each member
%}

function [ stress ] = memberStress(E, lengths,u,v,members,l,m )

dU = diff(u(members)'); % calculating difference in nodal x-displacement for each member
dV = diff(v(members)'); % calculating difference in nodal y-displacement for each member

%initalising stress vector for efficiency
stress = zeros(length(members),1); 
for i = 1:size(members)
stress(i) = E/lengths(i).*[l(i),m(i)]*[dU(i);dV(i)];
end


