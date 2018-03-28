%{
Vectorised function to remove unnecessary rows and columns from global
stiffness matrix when applying boundary conditions
Author: Lachlan Webb
Date: 25/03/2018

Inputs: 
kGlobal = global stiffness matrix
noDOF = vector containing indexes of constrained nodes
PQ = vector of applied loads 

Outputs: 
kGlobal = reduced global stiffness matrix
PQ = reduced applied loads vector
%}
function [ kGlobal,PQ ] = boundCond( kGlobal, noDOF,PQ )
kGlobal(noDOF,:) = [];
kGlobal(:,noDOF) = [];

PQ(noDOF) = [];
end

