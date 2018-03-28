%{
Vectorised function to calculate the lengths of lines from cartesian
co-ordinates, and the sine and cosine of the angle alpha measured from the
horizontal
Used for calculating member lengths of trusses from node positions
Author: Lachlan Webb
Date: 23/03/2018

Inputs: 
x,y = cartesian co-ordinates of endpoints
members = array of indexes of endpoints of each member

Outputs: 
lengths = vector of member lengths, corresponding with vector 'members' 
cos_a = cosine of angle a
sin_a = sine of angle a
%}
function [ lengths,cos_a,sin_a ] = trussTrig(x,y,members)

lengths = (diff(x(members)').^2+diff(y(members)').^2).^(1/2);
lengths = lengths';

cos_a = diff(x(members)')'./lengths;
sin_a = diff(y(members)')'./lengths;

end

