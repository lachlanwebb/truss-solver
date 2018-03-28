%% method of joints
force = zeros(size(mLengths)); 

%node 1
force(7) = -react*mLengths(7)/height;
force(1) = -force(7)*hor/mLengths(7);

%node 2
force(2) = force(1);
force(17) = 0; 

%node 12
force(18) = -force(7)*height/mLengths(7);
force(26) = force(7)*hor/mLengths(7); 

%node 8
force(8) = 1/2*(force(18)-force(17))*mLengths(8)/vert;
force(9) = -force(8);

%node 3
force(3) = force(2) + hor/mLengths(8)*force(8);
force(19) = -vert/mLengths(8)*force(8);

%node 13 
force(20) = -vert/mLengths(9)*force(9);
force(27) = force(26) + force(9)*hor/mLengths(9);

%node 9
force(11) = 1/2*(force(19)-force(20))*mLengths(11)/vert; 
force(10) = -force(11);

%node 4
force(21) = load-2*vert/mLengths(10)*force(10);

%by symmetry
force(4) = force(3);
force(5) = force(2);
force(6) = force(1);
force(12) = force(10);
force(13) = force(11);
force(14) = force(8);
force(15) = force(9);
force(16) = force(7);
force(22) = force(19);
force(23) = force(20);
force(24) = force(17);
force(25) = force(18);
force(28) = force(27);
force(29) = force(26);