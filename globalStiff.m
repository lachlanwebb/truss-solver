% Function that develops the global stiffness matrix from local stiffness matrices at each node
% Author: Declan Walsh
% Last Modified: 13/08/2016

% INPUTS
% k = 4x4xm array of local stiffness matrices for each of the m elements
% elements = vector of 2xm node numbers that m elements run between
% nodes = number of nodes in the system

% OUTPUTS
% kGlobal = mxm array of global stiffness matrix

function [ kGlobal ] = globalStiffDec( k, elements, nodes)

    % each node has 2DoF (x and y motion)
    DoF = 2*nodes;

    numElements = length(elements);
    [~, ~, lenK] = size(k);
    assert(numElements == lenK, 'Different number of elements and local stiffness matricies - insufficient number of local stiffness matrices');

    % create global stiffness matrix to be populated
    kGlobal = zeros(DoF, DoF);

    for i = 1:lenK
        % extract the nodal indices of the 2 nodes of the element
        idxA = elements(i, 1);
        idxB = elements(i, 2);

        % extract the local stiffness matrix of the element
        kLocal = k(:, :, i);

        % add the local stiffness matrix to the global stiffness matrix
        kGlobal = globalAddLocal(idxA, idxB, kLocal, kGlobal);
    end

end

