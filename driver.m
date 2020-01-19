%% Run model simulations
    % Input: parameter values and initial conditions
    % Output: predicted time courses for all molecular species
    
clear all
close all

%Run the model at these timepoints
predTime = [0:60:48*3600];

% Parameter values 
params(2,1) = 0.000056;
params(3,1) = 0.0056;
params(4,1) = 0.04;
params(5,1) = 0.2;
params(6,1) = 0.005;
params(7,1) = 0.008;
params(8,1) = 0.8;
params(9,1) = 0.4;
params(10,1) = 0.000256721177985165;
params(11,1) = 10;
params(12,1) = 0.02;
params(13,1) = 0.1;
params(14,1) = 0.02;
params(15,1) = 0.1;
params(16,1) = 0.02;
params(17,1) = 0.1;
params(18,1) = 0.001;
params(19,1) = 0.2;
params(20,1) = 0.003;
params(21,1) = 0.001;
params(22,1) = 0.2;
params(23,1) = 0.003;
params(24,1) = 0.0000002;
params(25,1) = 0.2;
params(26,1) = 0.005;
params(27,1) = 0.005;
params(28,1) = 0.005;
params(29,1) = 0.001;
params(30,1) = 0.2;
params(31,1) = 0.005;
params(32,1) = 0.0355;
params(33,1) = 0.05;
params(34,1) = 0.0355;
params(35,1) = 0.05;
params(36,1) = 0.01;
params(37,1) = 400;
params(38,1) = 0.001;
params(39,1) = 0.01;
params(40,1) = 0.02;
params(41,1) = 0.1;
params(42,1) = 0.0005;
params(43,1) = 0.0005;
params(44,1) = 0.0005;
params(45,1) = 0.01;
params(46,1) = 400;
params(47,1) = 0.001;
params(48,1) = 0.0005;
params(49,1) = 0.01;
params(50,1) = 0.01;
params(51,1) = 0.5;
params(52,1) = 1.2;
params(53,1) = 1.36;
params(54,1) = 1000;
params(55,1) = 0.01;
params(56,1) = 400;
params(57,1) = 0.001;
params(58,1) = 0.0005;
params(59,1) = 0.01;
params(60,1) = 1.92540883488874E-05;
params(61,1) = 0;


% Initial values
initvalues(1,1)= 9.09;
initvalues(2,1)= 12;
initvalues(3,1)= 0;
initvalues(4,1)= 0;
initvalues(5,1)= 100;
initvalues(6,1)= 50;
initvalues(7,1)= 60;
initvalues(8,1)= 0;
initvalues(9,1)= 0;
initvalues(10,1)= 0;
initvalues(11,1)= 0;
initvalues(12,1)= 0;
initvalues(13,1)= 0;
initvalues(14,1)= 0;
initvalues(15,1)= 0;
initvalues(16,1)= 0;
initvalues(17,1)= 0;
initvalues(18,1)= 0;
initvalues(19,1)= 0;
initvalues(20,1)= 0;
initvalues(21,1)= 0;
initvalues(22,1)= 0;
initvalues(23,1)= 0;
initvalues(24,1)= 0;
initvalues(25,1)= 0;
initvalues(26,1)= 0;
initvalues(27,1)= 0;
initvalues(28,1)= 0;
initvalues(29,1)= 0;
initvalues(30,1)= 0;
initvalues(31,1)= 0;
initvalues(32,1)= 0;
initvalues(33,1)= 0;
initvalues(34,1)= 0;
initvalues(35,1)= 0;
initvalues(36,1)= 0;
initvalues(37,1)= 0;
initvalues(38,1)= 0;
initvalues(39,1)= 0;
initvalues(40,1)= 0;
initvalues(41,1)= 0;
initvalues(42,1)= 0;
initvalues(43,1)= 0;
initvalues(44,1)= 0;
initvalues(45,1)= 0;
initvalues(46,1)= 0;
initvalues(47,1)= 0;
initvalues(48,1)= 0;
initvalues(49,1)= 0;
initvalues(50,1)= 0;
initvalues(51,1)= 0;
initvalues(52,1)= 0;
initvalues(53,1)= 0;
initvalues(54,1) = 0;
initvalues(55,1) = 0;
initvalues(56,1) = 50;

% Assign variable names for calculated quantities
kdeg = params(10,1);
RJ = initvalues(2,1);
Vratio = params(51,1);
ncratioA = params(52,1);
ncratioB = params(53,1);
totalSTAT = params(54,1);
k17outA = params(33,1);
k17outB = params(35,1);
k34 = params(60,1);
BCL = initvalues(56,1);

% Calculate quantities
ksyn = kdeg*RJ; % syn rate of RJ
S5Ac = totalSTAT/(1 + ncratioA*Vratio); % STAT5 in cytosol
S5An = (totalSTAT - S5Ac)/Vratio; %STAT5 in nucleus
S5Bc = totalSTAT/(1 + ncratioB*Vratio); % STAT5 in cytosol
S5Bn = (totalSTAT - S5Bc)/Vratio; %STAT5 in nucleus
k17inA = S5An/S5Ac*(Vratio)*k17outA;
k17inB = S5Bn/S5Bc*(Vratio)*k17outB;
k35 = k34*BCL;

%Assign them back to params and initvalues
params(1,1) = ksyn;
initvalues(3,1) = S5Ac;
initvalues(35,1) = S5An;
initvalues(4,1) = S5Bc;
initvalues(36,1) = S5Bn;
params(32,1) = k17inA;
params(34,1) = k17inB;
params(61,1) = k35;

% Set options
options = odeset('RelTol',1e-9,'AbsTol',1e-12,'NonNegative',[1:length(initvalues)]);

% simulate the model
[~, predConc] = ode15s(@core_file,predTime,initvalues,options,params);
  
% Calculated quantities
total_pStatA = predConc(:,13) +2.*predConc(:,15) + predConc(:,16) + predConc(:,19) + 2*predConc(:,21) + predConc(:,23) + predConc(:,24) + predConc(:,27) + 2*predConc(:,28) + predConc(:,29) + predConc(:,31) + predConc(:,33) + 2*predConc(:,37) + predConc(:,38) + predConc(:,40) + predConc(:,43);
total_pStatB = predConc(:,14) +2.*predConc(:,17) + predConc(:,16) + predConc(:,20) + 2*predConc(:,22) + predConc(:,23) + predConc(:,25) + predConc(:,26) + 2*predConc(:,30) + predConc(:,29) + predConc(:,32) + predConc(:,34) + 2*predConc(:,39) + predConc(:,38) + predConc(:,41) + predConc(:,42);

pStatA_norm = total_pStatA./total_pStatA(31);% normalized to 30 minute
pStatB_norm = total_pStatA./total_pStatA(31);% normalized to 30 minute

Stat_cytoA = predConc(:,3) + predConc(:,11) + predConc(:,13) + 2*predConc(:,15) + predConc(:,16) + predConc(:,19) + 2*predConc(:,21) + predConc(:,23) + 2*predConc(:,24) + predConc(:,26) + predConc(:,27) + predConc(:,48);
Stat_cytoB = predConc(:,4) + predConc(:,12) + predConc(:,14) + 2*predConc(:,17) + predConc(:,16) + predConc(:,20) + 2*predConc(:,22) + predConc(:,23) + 2*predConc(:,25) + predConc(:,26) + predConc(:,27) + predConc(:,49);

Stat_nucleusA = 2*predConc(:,28) + predConc(:,29) + predConc(:,31) + predConc(:,33) + predConc(:,35) + 2*predConc(:,37) + predConc(:,38) + 2*predConc(:,40) + predConc(:,42) + predConc(:,43);
Stat_nucleusB = 2*predConc(:,30) + predConc(:,29) + predConc(:,32) + predConc(:,34) + predConc(:,36) + 2*predConc(:,39) + predConc(:,38) + 2*predConc(:,41) + predConc(:,42) + predConc(:,43);

nucleus_cyto_ratioA = Stat_nucleusA./Stat_cytoA;
nucleus_cyto_ratioB = Stat_nucleusB./Stat_cytoB;

transloc_predA = nucleus_cyto_ratioA;
transloc_predB = nucleus_cyto_ratioB;

% Bcl-xL fold change
Bcl = predConc(:,56)./predConc(1,56);
