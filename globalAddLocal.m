% Function that adds a single local stiffness matrix to an existing global stiffness matrix
% Sub-function used to develop the total global stiffness matrix
% Author: Declan Walsh
% Last Modified: 13/08/2016

% INPUTS
% idxA, idxB = nodal indices of 2 nodes used to form the element that has the local stiffness matrix
% kLocal = 4x4 single local stiffness matrix
% kGlobal = global stiffness matrix

% OUTPUTS
% kGlobal = global stiffness matrix

function [ kGlobal ] = globalAddLocal( idxA, idxB, kLocal, kGlobal )

    % finds x, y indicies in global matrix for element given nodal index
    % each node has an x and y value giving idx = 2*index - 1 and idy = 2*index
    Ax = idxA * 2 - 1;
    Ay = idxA * 2;
    Bx = idxB * 2 - 1;
    By = idxB * 2;
    
    idx = [Ax, Ay, Bx, By];
    
    % add each local stiffness element to its relevant spot in the global stiffness matrix
    for i = 1:4
        for j = 1:4
            kGlobal(idx(i), idx(j)) = kGlobal(idx(i), idx(j)) + kLocal(i, j);
        end
    end
    
end

