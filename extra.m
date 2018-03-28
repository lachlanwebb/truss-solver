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

% report
reportVector = [1,2,3,7,17,8,19,10,21,18,9,20,11,26,27]; 
