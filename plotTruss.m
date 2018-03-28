% Function that plots a truss from given nodes and elements
% Author: Declan Walsh
% Last Modified: 13/08/2016

% INPUTS
% x, y = cartesion co-ordinates of nodes
% lines = vector of 2xn node numbers that elements run between
% dispText = 1 to overlay node and element numbers on graph

% OUTPUTS
% ax = handle to figure

function [ ax ] = plotTruss( x, y, lines, dispTextTruss, dispTextNodes )

    ax = figure;
    xlabel('X Distance (in)');
    ylabel('Y Distance (in)');
    axis off;
    hold on
    axis equal

    % plot elements in form of lines
    for i = 1:length(lines)
        nodeA = lines(i, 1);
        nodeB = lines(i, 2);
        xLine = [x(nodeA), x(nodeB)];
        yLine = [y(nodeA), y(nodeB)];
        line(xLine, yLine, 'Color','black')

        % label elements if requested
        if(dispTextTruss == 1)
            xAv = (xLine(1) + xLine(2))/2;
            yAv = (yLine(1) + yLine(2))/2;
            text(xAv, yAv, sprintf('%d', i))
        end

    end

    % plot nodes
    plot(x, y, 'r*')

    % label nodes
    if(dispTextNodes == 1)
        for j = 1:length(x)
            text(x(j), y(j), sprintf('%d', j));
        end
    end

    hold off


end

