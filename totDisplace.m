%{
Function to insert constrained nodes into displacement vector
Results for constrained nodes are removed in previous step to improve
efficiency of solution of linear system
Can likely be vectorised
Author: Lachlan Webb
Date: 25/03/2018

Inputs: 
UV = vector of displacements of unconstrained nodes
noDOF = vector of indexes of constrained nodes in original unreduced system 

Outputs: 
UV_full = full vector of displacements for every node
%}

function [UV_full] = totDisplace(UV,noDOF)

%lengthen UV to full length
UV_full = cat(1,UV,zeros(size(noDOF))');
    for i= 1:length(noDOF)
        idx = noDOF(i);
        %shifting every after constrained node down one element
        UV_full(idx+1:end) = UV_full(idx:end-1);
        UV_full(idx) = 0; 
    end
end

