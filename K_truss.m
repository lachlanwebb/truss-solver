% Main script for analysing K-truss for MMAN4410 assignment 1
% Credit to Declan Walsh for script & solution structure and globalStiff
% and globalAddLocal functions
% Effort has been made to vectorise as much as possible for efficiency
% Author: Lachlan Webb
% Date: 25/03/2018
clear all; close all; clc;
%% Truss parameters
% material properties spaghetti
d = 2; %mm
A = pi/4*d^2; %mm^2
I = pi/64*d.^2; %mm^4
E = 2.47E3; %MPa
UTS = 30; %MPa

% problem parameters
span = 40;  %cm
members = 6; % number of horizontal members 
hor = span/members; % length of each horizontal member
height = 5; %cm
vert = height/2;    %length of (most) vertical members
load = 12.6; %N   %applied load

%error margin
delta = 1E-12; %used to check different methods give the same result
%% Geometry set-up
% cartesian co-ordinates of nodal positions, w.r.t bottom left corner (node 1)
x = [0:hor:6*hor,hor,2*hor,4*hor,5*hor,hor:hor:5*hor];
y = [zeros(1,7),vert*ones(1,4),height*ones(1,5)];

%checking data is valid
assert(length(x) == length(y))
nodes = length(x);

%arrays containing indexes of endpoints of each member within truss
bottom_row = [1,2;2,3;3,4;4,5;5,6;6,7];
top_row = [12,13;13,14;14,15;15,16];
diagonals = [1,12;3,8;8,13;4,9;9,14;4,10;10,14;5,11;11,15;7,16];
verticals = [2,8;8,12;3,9;9,13;4,14;5,10;10,15;6,11;11,16];
%combining
members = [bottom_row;diagonals;verticals;top_row]; 

% checking statically determinant
numReactions = 3; %pin & roller joint
assert(length(members) == 2*nodes -numReactions)

%calculating lengths and trig quantities for each member
[mLengths,l,m] = trussTrig(x,y,members);

%% FEM - truss elements
%calculating local stiffness matrices
%kLocal is 3D array, where each 2D slice is stiffness matrix of an element
kLocal = localStiff(A,E,mLengths,l,m);

%combining local matrices into global stiffness matrix
kGlobal = globalStiff(kLocal,members,nodes);

%initalising applied load vector, where every odd element is force in
%x-direction, even in y-direction
PQ = zeros(length(kGlobal),1);
%load applied in negative y-direction at 4th node
PQ(4*2) = -load;

%boundary conditions
noDOF = [1,2,7*2];

%apply boundary conditions to reduce matrix
[kGlobalRed,PQRed] = boundCond(kGlobal,noDOF,PQ);

%calculate displacements of reduced matrix
UV = kGlobalRed\PQRed;

%reinsert constrained nodes back into displacement vector, such that every
%odd-element is x-direction, every even is y
UV_full = totDisplace(UV,noDOF);
 
%total force vector, including reactions at nodes
R = kGlobal*UV_full;
%calculating theoretical reaction forces
react = load/2;
%checking FEM gives expected answer
assert(R(noDOF(2)) - react <delta & R(noDOF(3)) - react <delta);

%extract seperate u and v vectors
u = UV_full(1:2:end); %x-displacements
v = UV_full(2:2:end); %y-displacements

%calculate stress in each element
FEM_stress = memberStress(E,mLengths,u,v,members,l,m);
%%
%plotting truss
plotTruss(x, y, members, 0, 1)

%calling method of joints script
methodJoints
hand_stress  = force./A;

% Euler buckling 
% Assuming fixed ends 
k_factor = 0.5;
crit_stress = eBucklingStress( E,I,A,k_factor,mLengths);

