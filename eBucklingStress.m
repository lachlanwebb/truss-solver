%{
Vectorised function to calculate critical buckling stress for a given
length and cross section
Author: Lachlan Webb
Date: 23/03/2018

Inputs: 
E = elastic modulus, MPa
I = second moment of area, mm^4
A = area, mm^2
k = factor accounting for end conditions
L = vector of lengths

Outputs: 
crit_stress = vector of critical stresses for each length 
%}

function [ crit_stress] = eBucklingStress( E,I,A,k,L )
F = pi^2*E*I./(k.*L).^2;
crit_stress = F./A;
end

