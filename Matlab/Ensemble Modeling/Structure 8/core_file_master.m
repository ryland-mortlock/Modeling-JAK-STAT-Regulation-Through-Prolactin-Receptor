function dydt = core_file_master(t,y,params )

% Ryland Mortlock
% July 1st, 2019

%Specify variable names
PRL = y(1);
RJ = y(2);
S5c = y(3);
SHP2 = y(4);
PPX = y(5);
PPN = y(6);
PRLRJ = y(7);
PRLRJ2 = y(8);
PRLRJ2a = y(9);
PRLRJ2aS5c = y(10);
pS5c = y(11);
PRLRJ2apS5c = y(12);
pS5cpS5c = y(13);
PRLRJ2aSHP2 = y(14);
PPXpS5c = y(15);
PPXpS5cpS5c = y(16);
pS5cS5c = y(17);
pS5npS5n = y(18);
pS5n = y(19);
PPNpS5n = y(20);
S5n = y(21);
PPNpS5npS5n = y(22);
pS5nS5n = y(23);
mRNAn = y(24);
mRNAc = y(25);
SOCS1 = y(26);
SOCS1PRLRJ2a = y(27);
PRLRJ2aS5cSHP2 = y(28);
SOCS1PRLRJ2aSHP2 = y(29);
mRn = y(30);
mRc = y(31);
Rc = y(32);

% Specify Parameter names
k1 = params(1);
k2 = params(2);
k_2 = params(3);
k3 = params(4);
k_3 = params(5);
k4 = params(6);
k5 = params(7);
k_5 = params(8);
k6 = params(9);
kdeg = params(10);
deg_ratio = params(11);
k7 = params(12);
k_7 = params(13);
k8 = params(14);
k_8 = params(15);
k9 = params(16);
k_9 = params(17);
k10 = params(18);
k11 = params(19);
k_11 = params(20);
k12 = params(21);
k13 = params(22);
k_13 = params(23);
k14 = params(24);
k15 = params(25);
k_15 = params(26);
k16 = params(27);
k17a = params(28);
k17b = params(29);
k18a = params(30);
k18b = params(31);
k19 = params(32);
k20 = params(33);
k21 = params(34);
k_21 = params(35);
k22 = params(36);
k23 = params(37);
k24 = params(38);
k25a = params(39);
k25b = params(40);
k26 = params(41);
k27 = params(42);
k28 = params(43);
k29 = params(44);
Vratio = params(45);
ncratio = params(46);
totalSTAT = params(47);

%Specify ODEs
dydt(1,1) = (k_2*PRLRJ - k2*PRL*RJ)*1.39E-4; % Adjusted for volume of cell to volume of cytoplasm ratio
dydt(2,1) = k1 + k_2*PRLRJ - k2*PRL*RJ - k3*PRLRJ*RJ + k_3*PRLRJ2 - kdeg*RJ + k29*Rc;
dydt(3,1) = k_5*PRLRJ2aS5c - k5*S5c*PRLRJ2a + k12*PPXpS5c - k13*S5c*pS5c + k_13*pS5cS5c + k10*PRLRJ2aS5cSHP2 + kdeg*deg_ratio*(PRLRJ2aS5c + PRLRJ2aS5cSHP2) - k17a*S5c + k17b*S5n.*Vratio;
dydt(4,1) = k_9*PRLRJ2aSHP2 - k9*PRLRJ2a*SHP2 + k10*PRLRJ2aSHP2 - k9*SHP2*SOCS1PRLRJ2a + k_9*SOCS1PRLRJ2aSHP2 + k10*SOCS1PRLRJ2aSHP2 - k9*SHP2*PRLRJ2aS5c + k_9*PRLRJ2aS5cSHP2 + k10*PRLRJ2aS5cSHP2 + kdeg*deg_ratio*(PRLRJ2aSHP2 + PRLRJ2aS5cSHP2 + SOCS1PRLRJ2aSHP2) + k24*SOCS1PRLRJ2aSHP2;
dydt(5,1) = k_11*PPXpS5c - k11*PPX*pS5c + k12*PPXpS5c - k11*PPX*pS5cpS5c + k_11*PPXpS5cpS5c + k12*PPXpS5cpS5c;
dydt(6,1) = k_15*PPNpS5n - k15*PPN*pS5n + k16*PPNpS5n - k15*PPN*pS5npS5n + k_15*PPNpS5npS5n + k16*PPNpS5npS5n;
dydt(7,1) =  k2*PRL*RJ - k_2*PRLRJ - k3*PRLRJ*RJ + k_3*PRLRJ2 - kdeg*deg_ratio*PRLRJ;
dydt(8,1) = k3*PRLRJ*RJ - k_3*PRLRJ2 - k4*PRLRJ2 + k10*PRLRJ2aSHP2 + k10*SOCS1PRLRJ2aSHP2 + k10*PRLRJ2aS5cSHP2 - kdeg*deg_ratio*PRLRJ2;
dydt(9,1) = k4*PRLRJ2 - k5*PRLRJ2a*S5c + k_5*PRLRJ2aS5c + k6*PRLRJ2aS5c - k7*PRLRJ2a*pS5c + k_7*PRLRJ2apS5c - k9*PRLRJ2a*SHP2 + k_9*PRLRJ2aSHP2 - k21*PRLRJ2a*SOCS1 + k_21*SOCS1PRLRJ2a + k23*SOCS1PRLRJ2a - kdeg*deg_ratio*PRLRJ2a;
dydt(10,1) = k5*PRLRJ2a*S5c - k_5*PRLRJ2aS5c - k6*PRLRJ2aS5c - k9*SHP2*PRLRJ2aS5c + k_9*PRLRJ2aS5cSHP2 - kdeg*deg_ratio*PRLRJ2aS5c;
dydt(11,1) = k6*PRLRJ2aS5c - k7*PRLRJ2a*pS5c + k_7*PRLRJ2apS5c - 2*k8*pS5c*pS5c + 2*k_8*pS5cpS5c - k11*PPX*pS5c + k_11*PPXpS5c - k13*pS5c*S5c + k_13*pS5cS5c + kdeg*deg_ratio*PRLRJ2apS5c;
dydt(12,1) = k7*PRLRJ2a*pS5c - k_7*PRLRJ2apS5c - kdeg*deg_ratio*PRLRJ2apS5c;
dydt(13,1) = k8*pS5c*pS5c - k_8*pS5cpS5c - k11*PPX*pS5cpS5c + k_11*PPXpS5cpS5c - k14*pS5cpS5c;
dydt(14,1) = k9*PRLRJ2a*SHP2 - k_9*PRLRJ2aSHP2 - k10*PRLRJ2aSHP2 + k23*SOCS1PRLRJ2aSHP2 - kdeg*deg_ratio*PRLRJ2aSHP2;
dydt(15,1) = k11*PPX*pS5c - k_11*PPXpS5c - k12*PPXpS5c;
dydt(16,1) = k11*PPX*pS5cpS5c - k_11*PPXpS5cpS5c - k12*PPXpS5cpS5c;
dydt(17,1) = k13*pS5c*S5c - k_13*pS5cS5c + k12*PPXpS5cpS5c;
dydt(18,1) = k14*pS5cpS5c./Vratio + k8*pS5n*pS5n - k_8*pS5npS5n - k15*PPN*pS5npS5n + k_15*PPNpS5npS5n;
dydt(19,1) = 2*k_8*pS5npS5n - 2*k8*pS5n*pS5n - k15*PPN*pS5n + k_15*PPNpS5n - k13*pS5n*S5n + k_13*pS5nS5n;
dydt(20,1) = k15*PPN*pS5n - k_15*PPNpS5n - k16*PPNpS5n;
dydt(21,1) = k16*PPNpS5n - k13*pS5n*S5n + k_13*pS5nS5n + k17a*S5c./Vratio - k17b*S5n;
dydt(22,1) = k15*PPN*pS5npS5n - k_15*PPNpS5npS5n - k16*PPNpS5npS5n;
dydt(23,1) = k16*PPNpS5npS5n + k13*pS5n*S5n - k_13*pS5nS5n;
dydt(24,1) = k18a*pS5npS5n/(k18b+pS5npS5n) - k19*mRNAn;
dydt(25,1) = k19*mRNAn.*Vratio -k22*mRNAc;
dydt(26,1) = k20*mRNAc - k21*SOCS1*PRLRJ2a + k_21*SOCS1PRLRJ2a - k23*SOCS1 + k10*SOCS1PRLRJ2aSHP2 + kdeg*deg_ratio*(SOCS1PRLRJ2a + SOCS1PRLRJ2aSHP2);
dydt(27,1) = k21*SOCS1*PRLRJ2a - k_21*SOCS1PRLRJ2a - k9*SHP2*SOCS1PRLRJ2a + k_9*SOCS1PRLRJ2aSHP2 - k23*SOCS1PRLRJ2a - kdeg*deg_ratio*SOCS1PRLRJ2a - k24*SOCS1PRLRJ2a;
dydt(28,1) = k9*SHP2*PRLRJ2aS5c - k_9*PRLRJ2aS5cSHP2 - k10*PRLRJ2aS5cSHP2 - kdeg*deg_ratio*PRLRJ2aS5cSHP2;
dydt(29,1) = k9*SHP2*SOCS1PRLRJ2a - k_9*SOCS1PRLRJ2aSHP2 - k10*SOCS1PRLRJ2aSHP2 - k23*SOCS1PRLRJ2aSHP2 - kdeg*deg_ratio*SOCS1PRLRJ2aSHP2 - k24*SOCS1PRLRJ2aSHP2;
dydt(30,1) = k25a*pS5npS5n/(k25b+pS5npS5n) - k26*mRn;
dydt(31,1) = k26*mRn.*Vratio - k27*mRc;
dydt(32,1) = k28*mRc - k29*Rc;


end

