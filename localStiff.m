%{
Vectorised function to calculate local stiffness matrices for 2D truss elements
Author: Lachlan Webb
Date: 24/03/2018

Inputs: 
A = cross sectional area of member
E = elastic modulus
L = length of member
l = cos(alpha), where alpha is angle between member and horizontal
m = sin(alpha)
n.b. all inputs can be scalars or vectors

Outputs: 
k = 3D array of stiffness matrices, where each 2D array corresponds to each
element
%}

function [k] = localStiff(A,E,L,l,m)
%reshaping vectors to 3rd dimension so that each (xy) 2D array in k
%corresponds to one member
L = reshape(L,1,1,length(L));
l = reshape(l,1,1,length(l));
m = reshape(m,1,1,length(m));

%stiffness matrix in terms of l & m
%can probably be cleaned up to only calculate half and flip over the
%diagonal
k = A.*E./L.*[l.^2,l.*m,-l.^2,-l.*m;l.*m,m.^2,-l.*m,-m.^2; ...
-l.^2,-l.*m,l.^2,l.*m;-l.*m,-m.^2,l.*m,m.^2];

end

