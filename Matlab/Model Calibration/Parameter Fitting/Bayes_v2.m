function [output1,output2] = Bayes_v2(input1)

        % Data
        Exp_data = importdata('Exp_data.mat');
        a1 = length(Exp_data);

        % Number of Samples
        nsamples = 1E+04;

        % Number of estimated parameters
        p = length(input1);

        % Set time
        Data_time = importdata('tspan.mat'); 
        tspan = Data_time;

        % Set ODE options
        options = odeset('RelTol',1E-09,...
                                'AbsTol',1E-12,...
                                'NonNegative',1:56);

        % Initialize variables
%         initvalues = zeros(53,nsamples);
        
        
        
        free_params = repmat(input1,[1,nsamples]);
        
        % Assign the fitted parameter values a starting value
        free_params1(1) = 0.04;
        free_params1(2) = 0.008;
        free_params1(3) = 10;
        free_params1(4) = 0.02;
        free_params1(5) = 1;
        free_params1(6) = 1;
        free_params1(7) = 0.001;
        free_params1(8) = 0.001;
        free_params1(9) = 0.2;
        free_params1(10) = 0.005;
        free_params1(11) = 1;
        free_params1(12) = 1;
        free_params1(13) = 0.001;
        free_params1(14) = 0.005;
        free_params1(15) = 0.05;
        free_params1(16) = 1;
        free_params1(17) = 0.001;
        free_params1(18) = 0.02;
        free_params1(19) = 0.0005;
        free_params1(20) = 0.0005;
        free_params1(21) = 0.0005;
        free_params1(22) = 0.01;
        free_params1(23) = 0.0005;
        free_params1(24) = 0.01;
        free_params1(25) = 1000;
        free_params1(26) = 0.01;
        free_params1(27) = 12;
        free_params1(28) = 100;
        free_params1(29) = 50;
        free_params1(30) = 60;


        l = zeros(p,1);
        l1 = l;

        % mean of proposal distribution
        mprop = log(input1);
        prop = repmat(mprop,[1,nsamples]);

        % standard deviation of proposal distribution
        vprop = 0.05; 

        accept = zeros(nsamples,1);
        AR = zeros(nsamples,1);
        
        fx = zeros(nsamples,1);

        par = zeros(p,nsamples);

        beta = 1E-3;
        alpha = 2;


        %% Start Loop


            % Initialize parameter values from Lognormal Distribution
%             for i = 1:p
%                 params1(i) = lognrnd(mprop(i),vprop);
%             end
            
            
            
            for k = 1:nsamples
                
                % Initialize parameter values
                for i = 1:p
                    free_params(i,k) = lognrnd(mprop(i),vprop);
                end
                    
                k3 = free_params(1,k);
                k5 = free_params(2,k);
                deg_ratio = free_params(3,k);
                k8A = free_params(4,k);
                mult8B = free_params(5,k);
                mult8AB = free_params(6,k);
                k9 = free_params(7,k);
                k11 = free_params(8,k);
                k_13 = free_params(9,k);
                k14A = free_params(10,k);
                mult14B = free_params(11,k);
                mult14AB = free_params(12,k);
                k15 = free_params(13,k);
                k16 = free_params(14,k);
                k17outA = free_params(15,k);
                mult17B = free_params(16,k);
                k19 = free_params(17,k);
                k21 = free_params(18,k);
                k22 = free_params(19,k);
                k23 = free_params(20,k);
                k24 = free_params(21,k);
                k25a = free_params(22,k);
                k27 = free_params(23,k);
                k28 = free_params(24,k);
                totalSTAT = free_params(25,k);
                k30a = free_params(26,k);
                RJ = free_params(27,k);
                SHP2 = free_params(28,k);
                PPX = free_params(29,k);
                PPN = free_params(30,k);

                            
                % Calculate based on multiplication ratios
                k8B = mult8B*k8A;
                k8AB = mult8AB*k8A;
                k14B = mult14B*k14A;
                k14AB = mult14AB*k8A;
                k17outB = mult17B*k17outA;

                % Assign to parameter values
                params(4,1) = k3;
                params(7,1) = k5;
                params(11,1) = deg_ratio;
                params(12,1) = k8A;
                params(14,1) = k8B;
                params(16,1) = k8AB;
                params(18,1) = k9;
                params(21,1) = k11;
                params(25,1) = k_13;
                params(26,1) = k14A;
                params(27,1) = k14B;
                params(28,1) = k14AB;
                params(29,1) = k15;
                params(31,1) = k16;
                params(33,1) = k17outA;
                params(35,1) = k17outB;
                params(38,1) = k19;
                params(40,1) = k21;
                params(42,1) = k22;
                params(43,1) = k23;
                params(44,1) = k24;
                params(45,1) = k25a;
                params(48,1) = k27;
                params(49,1) = k28;
                params(54,1) = totalSTAT;
                params(55,1) = k30a;

                initvalues(2,1) = RJ;
                initvalues(5,1) = SHP2;
                initvalues(6,1) = PPX;
                initvalues(7,1) = PPN;


                % Parameter values 
                params(2,1) = 0.000056;
                params(3,1) = 0.0056;
%                 params(4,1) = 0.04;
                params(5,1) = 0.2;
                params(6,1) = 0.005;
%                 params(7,1) = 0.008;
                params(8,1) = 0.8;
                params(9,1) = 0.4;
                params(10,1) = 0.000256721177985165;
%                 params(11,1) = 10;
%                 params(12,1) = 0.02;
                params(13,1) = 0.1;
%                 params(14,1) = 0.02;
                params(15,1) = 0.1;
%                 params(16,1) = 0.02;
                params(17,1) = 0.1;
%                 params(18,1) = 0.001;
                params(19,1) = 0.2;
                params(20,1) = 0.003;
%                 params(21,1) = 0.001;
                params(22,1) = 0.2;
                params(23,1) = 0.003;
                params(24,1) = 0.0000002;
%                 params(25,1) = 0.2;
%                 params(26,1) = 0.005;
%                 params(27,1) = 0.005;
%                 params(28,1) = 0.005;
%                 params(29,1) = 0.001;
                params(30,1) = 0.2;
%                 params(31,1) = 0.005;
                params(32,1) = 0.0355;
%                 params(33,1) = 0.05;
                params(34,1) = 0.0355;
%                 params(35,1) = 0.05;
                params(36,1) = 0.01;
                params(37,1) = 400;
%                 params(38,1) = 0.001;
                params(39,1) = 0.01;
%                 params(40,1) = 0.02;
                params(41,1) = 0.1;
%                 params(42,1) = 0.0005;
%                 params(43,1) = 0.0005;
%                 params(44,1) = 0.0005;
%                 params(45,1) = 0.01;
                params(46,1) = 400;
                params(47,1) = 0.001;
%                 params(48,1) = 0.0005;
%                 params(49,1) = 0.01;
                params(50,1) = 0.01;
                params(51,1) = 0.5;
                params(52,1) = 1.2;
                params(53,1) = 1.36;
%                 params(54,1) = 1000;
%                 params(55,1) = 0.01;
                params(56,1) = 400;
                params(57,1) = 0.001;
                params(58,1) = 0.0005;
                params(59,1) = 0.01;
                params(60,1) = 1.92540883488874E-05;
                params(61,1) = 0;


               % Initial values from Yamada 2003
                initvalues(1,1)= 9.09;
                % initvalues(2,1)= 12;
                initvalues(3,1)= 0;
                initvalues(4,1)= 0;
                % initvalues(5,1)= 100;
                % initvalues(6,1)= 50;
                % initvalues(7,1)= 60;
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

                % Assign variables for calculated quantities
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

                %Assign them
                params(1,1) = ksyn;
                initvalues(3,1) = S5Ac;
                initvalues(35,1) = S5An;
                initvalues(4,1) = S5Bc;
                initvalues(36,1) = S5Bn;
                params(32,1) = k17inA;
                params(34,1) = k17inB;
                params(61,1) = k35;

               
                % Repeat for free_params1 %%%%%%%%%%%%%
                k3 = free_params1(1);
                k5 = free_params1(2);
                deg_ratio = free_params1(3);
                k8A = free_params1(4);
                mult8B = free_params1(5);
                mult8AB = free_params1(6);
                k9 = free_params1(7);
                k11 = free_params1(8);
                k_13 = free_params1(9);
                k14A = free_params1(10);
                mult14B = free_params1(11);
                mult14AB = free_params1(12);
                k15 = free_params1(13);
                k16 = free_params1(14);
                k17outA = free_params1(15);
                mult17B = free_params1(16);
                k19 = free_params1(17);
                k21 = free_params1(18);
                k22 = free_params1(19);
                k23 = free_params1(20);
                k24 = free_params1(21);
                k25a = free_params1(22);
                k27 = free_params1(23);
                k28 = free_params1(24);
                totalSTAT = free_params1(25);
                k30a = free_params1(26);
                RJ = free_params1(27);
                SHP2 = free_params1(28);
                PPX = free_params1(29);
                PPN = free_params1(30);


                 % Calculate based on multiplication ratios
                k8B = mult8B*k8A;
                k8AB = mult8AB*k8A;
                k14B = mult14B*k14A;
                k14AB = mult14AB*k8A;
                k17outB = mult17B*k17outA;

                % Assign to parameter values
                params1(4,1) = k3;
                params1(7,1) = k5;
                params1(11,1) = deg_ratio;
                params1(12,1) = k8A;
                params1(14,1) = k8B;
                params1(16,1) = k8AB;
                params1(18,1) = k9;
                params1(21,1) = k11;
                params1(25,1) = k_13;
                params1(26,1) = k14A;
                params1(27,1) = k14B;
                params1(28,1) = k14AB;
                params1(29,1) = k15;
                params1(31,1) = k16;
                params1(33,1) = k17outA;
                params1(35,1) = k17outB;
                params1(38,1) = k19;
                params1(40,1) = k21;
                params1(42,1) = k22;
                params1(43,1) = k23;
                params1(44,1) = k24;
                params1(45,1) = k25a;
                params1(48,1) = k27;
                params1(49,1) = k28;
                params1(54,1) = totalSTAT;
                params1(55,1) = k30a;

                initvalues1(2,1) = RJ;
                initvalues1(5,1) = SHP2;
                initvalues1(6,1) = PPX;
                initvalues1(7,1) = PPN;


                % Parameter values 
                params1(2,1) = 0.000056;
                params1(3,1) = 0.0056;
%                 params1(4,1) = 0.04;
                params1(5,1) = 0.2;
                params1(6,1) = 0.005;
%                 params1(7,1) = 0.008;
                params1(8,1) = 0.8;
                params1(9,1) = 0.4;
                params1(10,1) = 0.000256721177985165;
%                 params1(11,1) = 10;
%                 params1(12,1) = 0.02;
                params1(13,1) = 0.1;
%                 params1(14,1) = 0.02;
                params1(15,1) = 0.1;
%                 params1(16,1) = 0.02;
                params1(17,1) = 0.1;
%                 params1(18,1) = 0.001;
                params1(19,1) = 0.2;
                params1(20,1) = 0.003;
%                 params1(21,1) = 0.001;
                params1(22,1) = 0.2;
                params1(23,1) = 0.003;
                params1(24,1) = 0.0000002;
%                 params1(25,1) = 0.2;
%                 params1(26,1) = 0.005;
%                 params1(27,1) = 0.005;
%                 params1(28,1) = 0.005;
%                 params1(29,1) = 0.001;
                params1(30,1) = 0.2;
%                 params1(31,1) = 0.005;
                params1(32,1) = 0.0355;
%                 params1(33,1) = 0.05;
                params1(34,1) = 0.0355;
%                 params1(35,1) = 0.05;
                params1(36,1) = 0.01;
                params1(37,1) = 400;
%                 params1(38,1) = 0.001;
                params1(39,1) = 0.01;
%                 params1(40,1) = 0.02;
                params1(41,1) = 0.1;
%                 params1(42,1) = 0.0005;
%                 params1(43,1) = 0.0005;
%                 params1(44,1) = 0.0005;
%                 params1(45,1) = 0.01;
                params1(46,1) = 400;
                params1(47,1) = 0.001;
%                 params1(48,1) = 0.0005;
%                 params1(49,1) = 0.01;
                params1(50,1) = 0.01;
                params1(51,1) = 0.5;
                params1(52,1) = 1.2;
                params1(53,1) = 1.36;
%                 params1(54,1) = 1000;
%                 params1(55,1) = 0.01;
                params1(56,1) = 400;
                params1(57,1) = 0.001;
                params1(58,1) = 0.0005;
                params1(59,1) = 0.01;
                params1(60,1) = 1.92540883488874E-05;
                params1(61,1) = 0;


               % Initial values from Yamada 2003
                initvalues1(1,1)= 9.09;
                % initvalues1(2,1)= 12;
                initvalues1(3,1)= 0;
                initvalues1(4,1)= 0;
                % initvalues1(5,1)= 100;
                % initvalues1(6,1)= 50;
                % initvalues1(7,1)= 60;
                initvalues1(8,1)= 0;
                initvalues1(9,1)= 0;
                initvalues1(10,1)= 0;
                initvalues1(11,1)= 0;
                initvalues1(12,1)= 0;
                initvalues1(13,1)= 0;
                initvalues1(14,1)= 0;
                initvalues1(15,1)= 0;
                initvalues1(16,1)= 0;
                initvalues1(17,1)= 0;
                initvalues1(18,1)= 0;
                initvalues1(19,1)= 0;
                initvalues1(20,1)= 0;
                initvalues1(21,1)= 0;
                initvalues1(22,1)= 0;
                initvalues1(23,1)= 0;
                initvalues1(24,1)= 0;
                initvalues1(25,1)= 0;
                initvalues1(26,1)= 0;
                initvalues1(27,1)= 0;
                initvalues1(28,1)= 0;
                initvalues1(29,1)= 0;
                initvalues1(30,1)= 0;
                initvalues1(31,1)= 0;
                initvalues1(32,1)= 0;
                initvalues1(33,1)= 0;
                initvalues1(34,1)= 0;
                initvalues1(35,1)= 0;
                initvalues1(36,1)= 0;
                initvalues1(37,1)= 0;
                initvalues1(38,1)= 0;
                initvalues1(39,1)= 0;
                initvalues1(40,1)= 0;
                initvalues1(41,1)= 0;
                initvalues1(42,1)= 0;
                initvalues1(43,1)= 0;
                initvalues1(44,1)= 0;
                initvalues1(45,1)= 0;
                initvalues1(46,1)= 0;
                initvalues1(47,1)= 0;
                initvalues1(48,1)= 0;
                initvalues1(49,1)= 0;
                initvalues1(50,1)= 0;
                initvalues1(51,1)= 0;
                initvalues1(52,1)= 0;
                initvalues1(53,1)= 0;
                initvalues1(54,1) = 0;
                initvalues1(55,1) = 0;
                initvalues1(56,1) = 50;

                % Assign variables for calculated quantities
                kdeg = params1(10,1);
                RJ = initvalues1(2,1);

                Vratio = params1(51,1);
                ncratioA = params1(52,1);
                ncratioB = params1(53,1);
                totalSTAT = params1(54,1);

                k17outA = params1(33,1);
                k17outB = params1(35,1);
                
                k34 = params1(60,1);
                BCL = initvalues1(56,1);

                % Calculate quantities
                ksyn = kdeg*RJ; % syn rate of RJ
                S5Ac = totalSTAT/(1 + ncratioA*Vratio); % STAT5 in cytosol
                S5An = (totalSTAT - S5Ac)/Vratio; %STAT5 in nucleus
                S5Bc = totalSTAT/(1 + ncratioB*Vratio); % STAT5 in cytosol
                S5Bn = (totalSTAT - S5Bc)/Vratio; %STAT5 in nucleus
                k17inA = S5An/S5Ac*(Vratio)*k17outA;
                k17inB = S5Bn/S5Bc*(Vratio)*k17outB;
                k35 = k34*BCL;

                %Assign them
                params1(1,1) = ksyn;
                initvalues1(3,1) = S5Ac;
                initvalues1(35,1) = S5An;
                initvalues1(4,1) = S5Bc;
                initvalues1(36,1) = S5Bn;
                params1(32,1) = k17inA;
                params1(34,1) = k17inB;
                params1(61,1) = k35;
                        
                        
                % Simulate ODEs
                [~, predConc] = ode15s(@core_file_Bcl,tspan,initvalues,options,params); 
                
                [~, predConc1] = ode15s(@core_file_Bcl,tspan,initvalues1,options,params1); 


                %% Compute Norm of (i + 1)th error

                % Calculated quantities 
                total_pStatA = predConc(:,13) +2.*predConc(:,15) + predConc(:,16) + predConc(:,19) + 2*predConc(:,21) + predConc(:,23) + predConc(:,24) + predConc(:,27) + 2*predConc(:,28) + predConc(:,29) + predConc(:,31) + predConc(:,33) + 2*predConc(:,37) + predConc(:,38) + predConc(:,40) + predConc(:,43);
                total_pStatB = predConc(:,14) +2.*predConc(:,17) + predConc(:,16) + predConc(:,20) + 2*predConc(:,22) + predConc(:,23) + predConc(:,25) + predConc(:,26) + 2*predConc(:,30) + predConc(:,29) + predConc(:,32) + predConc(:,34) + 2*predConc(:,39) + predConc(:,38) + predConc(:,41) + predConc(:,42);

                pStatA_norm = [total_pStatA(3) total_pStatA(5) total_pStatA(6) total_pStatA(8) total_pStatA(10) total_pStatA(12)]./total_pStatA(5);  
                pStatB_norm = [total_pStatB(3) total_pStatB(5) total_pStatB(6) total_pStatB(8) total_pStatB(10) total_pStatB(12)]./total_pStatB(5);  

                Stat_cytoA = predConc(:,3) + predConc(:,11) + predConc(:,13) + 2*predConc(:,15) + predConc(:,16) + predConc(:,19) + 2*predConc(:,21) + predConc(:,23) + 2*predConc(:,24) + predConc(:,26) + predConc(:,27) + predConc(:,48);
                Stat_cytoB = predConc(:,4) + predConc(:,12) + predConc(:,14) + 2*predConc(:,17) + predConc(:,16) + predConc(:,20) + 2*predConc(:,22) + predConc(:,23) + 2*predConc(:,25) + predConc(:,26) + predConc(:,27) + predConc(:,49);

                Stat_nucleusA = 2*predConc(:,28) + predConc(:,29) + predConc(:,31) + predConc(:,33) + predConc(:,35) + 2*predConc(:,37) + predConc(:,38) + 2*predConc(:,40) + predConc(:,42) + predConc(:,43);
                Stat_nucleusB = 2*predConc(:,30) + predConc(:,29) + predConc(:,32) + predConc(:,34) + predConc(:,36) + 2*predConc(:,39) + predConc(:,38) + 2*predConc(:,41) + predConc(:,42) + predConc(:,43);

                nucleus_cyto_ratioA = Stat_nucleusA./Stat_cytoA;
                nucleus_cyto_ratioB = Stat_nucleusB./Stat_cytoB;

                transloc_predA = [nucleus_cyto_ratioA(5) nucleus_cyto_ratioA(6) nucleus_cyto_ratioA(7) nucleus_cyto_ratioA(9) nucleus_cyto_ratioA(12)];  
                transloc_predB = [nucleus_cyto_ratioB(2) nucleus_cyto_ratioB(4) nucleus_cyto_ratioB(5) nucleus_cyto_ratioB(6) nucleus_cyto_ratioB(8) nucleus_cyto_ratioB(9) nucleus_cyto_ratioB(10) nucleus_cyto_ratioB(11) nucleus_cyto_ratioB(12)];  

                %Calculate the predicted response and structure in same way as exp data
                Pred_data = zeros(a1,1);

                %pStat5 predicted response 
                Pred_data(1:6,1) = pStatA_norm;
                Pred_data(7:12,1) = pStatB_norm;

                % nucleus over cyto prediction
                Pred_data(13:17,1) = transloc_predA;
                Pred_data(18:26,1) = transloc_predB;
                
                % Bcl-xL fold change
                Pred_data(27:33) = [predConc(8,56) predConc(10,56) predConc(12,56) predConc(13,56) predConc(14,56) predConc(15,56) predConc(16,56)]./predConc(1,56);
                
                err = (Pred_data - Exp_data)./Exp_data;
                error = ((0.5)*sum(err.^2)) + beta;
                
                
                
                
                
                 % Calculated quantities for best run
                total_pStatA1 = predConc1(:,13) +2.*predConc1(:,15) + predConc1(:,16) + predConc1(:,19) + 2*predConc1(:,21) + predConc1(:,23) + predConc1(:,24) + predConc1(:,27) + 2*predConc1(:,28) + predConc1(:,29) + predConc1(:,31) + predConc1(:,33) + 2*predConc1(:,37) + predConc1(:,38) + predConc1(:,40) + predConc1(:,43);
                total_pStatB1 = predConc1(:,14) +2.*predConc1(:,17) + predConc1(:,16) + predConc1(:,20) + 2*predConc1(:,22) + predConc1(:,23) + predConc1(:,25) + predConc1(:,26) + 2*predConc1(:,30) + predConc1(:,29) + predConc1(:,32) + predConc1(:,34) + 2*predConc1(:,39) + predConc1(:,38) + predConc1(:,41) + predConc1(:,42);

                pStatA_norm1 = [total_pStatA1(3) total_pStatA1(5) total_pStatA1(6) total_pStatA1(8) total_pStatA1(10) total_pStatA1(12)]./total_pStatA1(5);  
                pStatB_norm1 = [total_pStatB1(3) total_pStatB1(5) total_pStatB1(6) total_pStatB1(8) total_pStatB1(10) total_pStatB1(12)]./total_pStatB1(5);  

                Stat_cytoA1 = predConc1(:,3) + predConc1(:,11) + predConc1(:,13) + 2*predConc1(:,15) + predConc1(:,16) + predConc1(:,19) + 2*predConc1(:,21) + predConc1(:,23) + 2*predConc1(:,24) + predConc1(:,26) + predConc1(:,27) + predConc1(:,48);
                Stat_cytoB1 = predConc1(:,4) + predConc1(:,12) + predConc1(:,14) + 2*predConc1(:,17) + predConc1(:,16) + predConc1(:,20) + 2*predConc1(:,22) + predConc1(:,23) + 2*predConc1(:,25) + predConc1(:,26) + predConc1(:,27) + predConc1(:,49);

                Stat_nucleusA1 = 2*predConc1(:,28) + predConc1(:,29) + predConc1(:,31) + predConc1(:,33) + predConc1(:,35) + 2*predConc1(:,37) + predConc1(:,38) + 2*predConc1(:,40) + predConc1(:,42) + predConc1(:,43);
                Stat_nucleusB1 = 2*predConc1(:,30) + predConc1(:,29) + predConc1(:,32) + predConc1(:,34) + predConc1(:,36) + 2*predConc1(:,39) + predConc1(:,38) + 2*predConc1(:,41) + predConc1(:,42) + predConc1(:,43);

                nucleus_cyto_ratioA1 = Stat_nucleusA1./Stat_cytoA1;
                nucleus_cyto_ratioB1 = Stat_nucleusB1./Stat_cytoB1;

                transloc_predA1 = [nucleus_cyto_ratioA1(5) nucleus_cyto_ratioA1(6) nucleus_cyto_ratioA1(7) nucleus_cyto_ratioA1(9) nucleus_cyto_ratioA1(12)];  
                transloc_predB1 = [nucleus_cyto_ratioB1(2) nucleus_cyto_ratioB1(4) nucleus_cyto_ratioB1(5) nucleus_cyto_ratioB1(6) nucleus_cyto_ratioB1(8) nucleus_cyto_ratioB1(9) nucleus_cyto_ratioB1(10) nucleus_cyto_ratioB1(11) nucleus_cyto_ratioB1(12)];  

                %Calculate the predicted response and structure in same way as exp data
                Pred_data1 = zeros(a1,1);

                %pStat5 predicted response 
                Pred_data1(1:6,1) = pStatA_norm1;
                Pred_data1(7:12,1) = pStatB_norm1;

                % nucleus over cyto prediction
                Pred_data1(13:17,1) = transloc_predA1;
                Pred_data1(18:26,1) = transloc_predB1;
                
                % Bcl-xL fold change
                Pred_data1(27:33) = [predConc1(8,56) predConc1(10,56) predConc1(12,56) predConc1(13,56) predConc(14,56) predConc1(15,56) predConc1(16,56)]./predConc1(1,56);
                                
                err1 = (Pred_data1 - Exp_data)./Exp_data;
                error1 = ((0.5)*sum(err1.^2)) + beta;
                
                
                
 

                %% Parameters
                
                gg = free_params(:,k);
                gg1 = free_params1;

                % prior
                for i = 1:p
                    l(i) = (log(gg(i)) - log(input1(i)))^2;
                    l1(i) = (log(gg1(i)) - log(input1(i)))^2;
                end
                
                ll = sum(l);

                ll1 = sum(l1);

                % Target density
                a = ((error1/error)^((length(err)/2) + alpha))...
                    *exp((-0.5/(2^2))*(ll - ll1));

                % Randomly sample from unif distribution
                b = unifrnd(0,1);

                % Track essentials over iteration
                fx(k) = error1;
                par(:,k) = gg1;
                
                % Acceptance criteria
                lambda = min([1,a]);
                
                % Acceptance Ratio
                if b <= lambda
                    accept(k) = 1;
                else
                    accept(k) = 0;
                end
                                
                AR(k) = sum(accept)/k;
                
                % Tune std of proposal based on acceptance ratio
                if AR(k) <= 0.29
                    vprop = 0.01;
                end
                
                if AR(k) > 0.29 && AR(k) <= 0.31
                    vprop = 0.05;
                end
                
                if AR(k) > 0.31
                    vprop = 0.1;
                end
                
                if b <= lambda
                    free_params1 = free_params(:,k); % Set new parameter values
                    if error < min(fx(1:k))
                        for i = 1:p
                            mprop(i) = log(gg(i)); % Update proposal mean
                        end
                    end
                end
                
                prop(:,k) = mprop;
                                
                % Display
                D = ['iter = ',num2str(k),', best error = ',num2str(error1),', lambda = ',num2str(round(lambda,1)),', AR = ',num2str(round(AR(k),2))];
                disp(D);

                % End loop

            end

            output1 = par;
            
            output2 = fx;
                        
return