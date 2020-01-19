% Ryland Mortlock
% November 24th, 2019

% Generate novel predictions when varying influential parameters
    % Creates a plot of pStatA, pStatB, nucleus/cytoplasm ratio A and B,
    % and Bcl-xL fold change over time (as in Figure 6) but with
    % perturbations to single fitted parameter values
    

clear all
close all
type = 'weighted';

Data_time = importdata('tspan.mat'); 

%Run the model at these timepoints
predTime = [0:60:24*3600];

% Load experimental data
Exp_data = importdata('Exp_data.mat');


% Load fitted parameyer vales
ALL_params = importdata('free_params.mat');
ALL_params = sortrows(ALL_params,1);
numFits = size(ALL_params,1);



% free_params = [0.109709750601466;0.00927907244997107;0.971457672185374;20.6432024829247;0.0472809692961210;16.0927968865182;1.70563079879507;0.00810980838332706;6.02453236050481;9.68165950029885;0.00211566044269692;0.0266225524010845;0.0312073732750853;0.0391172367213432;0.00502926999502561;0.101761349137690;0.000302086702765119;0.0230977638435886;0.000296177213569438;0.00534606788865659;709.452852763266;42.2489853309736;39.6479671713842;66.6123840756945];
% numFits = 19;


%% Outer loop through parameters we want to vary
param_list = ["RJ","PPX"];

param_ref = [2,6];

multiplier_vec = [.1 .5 1 2 10];

for j = 1
    my_param_name = param_list(j);
    my_param_ref = param_ref(j);

%% inner loop through  variations in a single parameter


% Pre-allocate results to plot
pStatA_mat = zeros(length(multiplier_vec),361);
pStatB_mat = zeros(length(multiplier_vec),361);
translocA_mat = zeros(length(multiplier_vec),361);
translocB_mat = zeros(length(multiplier_vec),361);
Bcl_mat = zeros(length(multiplier_vec),length(predTime));
    

for k = 1:length(multiplier_vec)


%% Run with fits (PRL stimulation)


for i = 1:numFits
    
free_params1 = ALL_params(i,2:end);


% Assign the fitted parameter values
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
                
                
                
               % Vary the parameter of interest
                initvalues(my_param_ref,1) = initvalues(my_param_ref,1).*multiplier_vec(k);


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

% Set options
options = odeset('RelTol',1e-9,'AbsTol',1e-12,'NonNegative',[1:length(initvalues)]);

% simulate the model
[~, predConc] = ode15s(@core_file_Bcl,predTime,initvalues,options,params);
  
% Calculated quantities
total_pStatA = predConc(:,13) +2.*predConc(:,15) + predConc(:,16) + predConc(:,19) + 2*predConc(:,21) + predConc(:,23) + predConc(:,24) + predConc(:,27) + 2*predConc(:,28) + predConc(:,29) + predConc(:,31) + predConc(:,33) + 2*predConc(:,37) + predConc(:,38) + predConc(:,40) + predConc(:,43);
total_pStatB = predConc(:,14) +2.*predConc(:,17) + predConc(:,16) + predConc(:,20) + 2*predConc(:,22) + predConc(:,23) + predConc(:,25) + predConc(:,26) + 2*predConc(:,30) + predConc(:,29) + predConc(:,32) + predConc(:,34) + 2*predConc(:,39) + predConc(:,38) + predConc(:,41) + predConc(:,42);

pStatA_norm(:,i) = total_pStatA./total_pStatA(31);% normalized to 30 minute
pStatB_norm(:,i) = total_pStatA./total_pStatA(31);% normalized to 30 minute

Stat_cytoA = predConc(:,3) + predConc(:,11) + predConc(:,13) + 2*predConc(:,15) + predConc(:,16) + predConc(:,19) + 2*predConc(:,21) + predConc(:,23) + 2*predConc(:,24) + predConc(:,26) + predConc(:,27) + predConc(:,48);
Stat_cytoB = predConc(:,4) + predConc(:,12) + predConc(:,14) + 2*predConc(:,17) + predConc(:,16) + predConc(:,20) + 2*predConc(:,22) + predConc(:,23) + 2*predConc(:,25) + predConc(:,26) + predConc(:,27) + predConc(:,49);

Stat_nucleusA = 2*predConc(:,28) + predConc(:,29) + predConc(:,31) + predConc(:,33) + predConc(:,35) + 2*predConc(:,37) + predConc(:,38) + 2*predConc(:,40) + predConc(:,42) + predConc(:,43);
Stat_nucleusB = 2*predConc(:,30) + predConc(:,29) + predConc(:,32) + predConc(:,34) + predConc(:,36) + 2*predConc(:,39) + predConc(:,38) + 2*predConc(:,41) + predConc(:,42) + predConc(:,43);

nucleus_cyto_ratioA = Stat_nucleusA./Stat_cytoA;
nucleus_cyto_ratioB = Stat_nucleusB./Stat_cytoB;

transloc_predA(:,i) = nucleus_cyto_ratioA;
transloc_predB(:,i) = nucleus_cyto_ratioB;

rec_total = predConc(:,2) + predConc(:,8) + 2*predConc(:,9) + 2*predConc(:,10) + 2*predConc(:,11) + 2*predConc(:,12) + 2*predConc(:,18) + 2*predConc(:,47) + 2*predConc(:,48) + 2*predConc(:,49) + 2*predConc(:,50);
rec_internalized = 1 - rec_total./initvalues(2);
intern_pred(i) = rec_internalized(31);

% Bcl fold change
Bcl(:,i) = predConc(:,56)./predConc(1,56);

end

% Calculate mean model predictions from 25 parameter sets
pStatA_mat(k,:) = mean(pStatA_norm(1:361,:)');
pStatB_mat(k,:) = mean(pStatB_norm(1:361,:)');
translocA_mat(k,:) = mean(transloc_predA(1:361,:)');
translocB_mat(k,:) = mean(transloc_predB(1:361,:)');
Bcl_mat(k,:) = mean(Bcl');


end

%% Make figure for this parameter

% PStatA figure

% Set color scheme
cols = cbrewer('qual','Paired',10);
my_cols(3,:) = cols(10,:); % Purple
cols = cbrewer('seq','Blues',8);
my_cols(1,:) = cols(6,:); % Light blue
my_cols(2,:) = cols(8,:); % Dark blue

% Calculate time vectors for plotting
Data_time_minutes = Data_time./60;
predTime_minutes =predTime./60;
Data_time_hours = Data_time_minutes./60;
predTime_hours =predTime_minutes./60;
pStat_hours = predTime_hours(1:361);



% %--- plot pStatA
% subplot(2,2,1);
% plot(pStat_hours,pStatA_mat(1,:),'--','color',my_cols(1,:),'LineWidth',2)
% hold on;
% plot(pStat_hours,pStatA_mat(2,:),':','color',my_cols(1,:),'LineWidth',2)
% hold on;
% plot(pStat_hours,pStatA_mat(3,:),'-','color',my_cols(1,:),'LineWidth',3)
% hold on;
% plot(pStat_hours,pStatA_mat(4,:),'-.','color',my_cols(1,:),'LineWidth',2)
% hold on;
% plot(pStat_hours,pStatA_mat(5,:),'-','color',my_cols(1,:),'LineWidth',2)
% hold on;
% % Experimental data
% scatter([Data_time_hours(3) Data_time_hours(5) Data_time_hours(6) Data_time_hours(8) Data_time_hours(10) Data_time_hours(12)],Exp_data(1:6),48,'MarkerEdgeColor',my_cols(1,:),'Marker','s','Linewidth',1,'MarkerFaceColor',my_cols(1,:))
% 
% box off;
% ax = gca;
% ax.LineWidth = 3;
% ax.FontSize = 10;
% set(gcf,'color','w');
% ax.TickDir = 'out';
% ax.XGrid = 'off';
% ax.YGrid = 'off';
% xt = get(gca, 'XTick');
% set(gca, 'FontWeight', 'Bold')
% 
% %title('STAT5A','FontSize',14,'FontWeight','bold','Color','k');
% %  xlabel('Time (hours)','FontSize',10,'FontWeight','bold','Color','k')
% ylabel('pStatA norm to 30min','FontSize',14,'FontWeight','bold','Color','k')
% 
% legend('0.1x','0.5x','1x','2x','10x')
% legend('boxoff')
% legend('Location','eastoutside')
% 
% title(my_param_name,'FontSize',14,'FontWeight','bold','Color','k');

% 
% 
% %--- plot pStatB
% subplot(2,2,2);
% plot(pStat_hours,pStatB_mat(1,:),'--','color',my_cols(2,:),'LineWidth',2)
% hold on;
% plot(pStat_hours,pStatB_mat(2,:),':','color',my_cols(2,:),'LineWidth',2)
% hold on;
% plot(pStat_hours,pStatB_mat(3,:),'-','color',my_cols(2,:),'LineWidth',3)
% hold on;
% plot(pStat_hours,pStatB_mat(4,:),'-.','color',my_cols(2,:),'LineWidth',2)
% hold on;
% plot(pStat_hours,pStatB_mat(5,:),'-','color',my_cols(2,:),'LineWidth',2)
% hold on;
% % Experimental data
% Data_time2 = [Data_time_hours(3) Data_time_hours(5) Data_time_hours(6) Data_time_hours(8) Data_time_hours(10) Data_time_hours(12)]; 
% scatter(Data_time2,Exp_data(7:12),48,'MarkerEdgeColor',my_cols(2,:),'Marker','s','Linewidth',1,'MarkerFaceColor',my_cols(2,:))
% 
% box off;
% ax = gca;
% ax.LineWidth = 3;
% ax.FontSize = 12;
% set(gcf,'color','w');
% ax.TickDir = 'out';
% ax.XGrid = 'off';
% ax.YGrid = 'off';
% xt = get(gca, 'XTick');
% set(gca, 'FontWeight', 'Bold')
% 
% %  xlabel('Time (hours)','FontSize',10,'FontWeight','bold','Color','k')
% ylabel('pStatB norm to 30min','FontSize',14,'FontWeight','bold','Color','k')
% % legend('boxoff')
% 
% title(my_param_name,'FontSize',14,'FontWeight','bold','Color','k');
% 


%--- plot translocation prediction A
subplot(1,3,1);
plot(pStat_hours,translocA_mat(1,:),'--','color',my_cols(1,:),'LineWidth',2)
hold on;
plot(pStat_hours,translocA_mat(2,:),':','color',my_cols(1,:),'LineWidth',2)
hold on;
plot(pStat_hours,translocA_mat(3,:),'-','color',my_cols(1,:),'LineWidth',3)
hold on;
plot(pStat_hours,translocA_mat(4,:),'-.','color',my_cols(1,:),'LineWidth',2)
hold on;
plot(pStat_hours,translocA_mat(5,:),'-','color',my_cols(1,:),'LineWidth',2)
hold on;
% Experimental data
Data_time3 = [Data_time_hours(5) Data_time_hours(6) Data_time_hours(7) Data_time_hours(9) Data_time_hours(12)];
scatter(Data_time3,Exp_data(13:17),48,'MarkerEdgeColor',my_cols(1,:),'Marker','s','Linewidth',1,'MarkerFaceColor',my_cols(1,:))

error3 = [0.1919942;
0.1599941
0.1728005
0.1472004
0.1664005];

errorbar(Data_time3, Exp_data(13:17), error3, 'LineStyle','none','Color',my_cols(1,:));

box off;
ax = gca;
ax.LineWidth = 3;
ax.FontSize = 12;
set(gcf,'color','w');
ax.TickDir = 'out';
ax.XGrid = 'off';
ax.YGrid = 'off';
xt = get(gca, 'XTick');
set(gca, 'FontWeight', 'Bold')

xlabel('Time (hours)','FontSize',14,'FontWeight','bold','Color','k')
ylabel('nucleus/cyto ratio A','FontSize',14,'FontWeight','bold','Color','k')
ylim([1 10])
% legend('0.1x','0.5x','1x','2x','10x')
% legend('boxoff')
% legend('Location','eastoutside')

% 
% 
% %--- plot translocation prediction B
% % subplot(2,2,4);
% plot(pStat_hours,translocB_mat(1,:),'--','color',my_cols(2,:),'LineWidth',2)
% hold on;
% plot(pStat_hours,translocB_mat(2,:),':','color',my_cols(2,:),'LineWidth',2)
% hold on;
% plot(pStat_hours,translocB_mat(3,:),'-','color',my_cols(2,:),'LineWidth',3)
% hold on;
% plot(pStat_hours,translocB_mat(4,:),'-.','color',my_cols(2,:),'LineWidth',2)
% hold on;
% plot(pStat_hours,translocB_mat(5,:),'-','color',my_cols(2,:),'LineWidth',2)
% hold on;
% % Experimental data
% Data_time4 = [Data_time_hours(2) Data_time_hours(4) Data_time_hours(5) Data_time_hours(6) Data_time_hours(8) Data_time_hours(9) Data_time_hours(10) Data_time_hours(11) Data_time_hours(12)];
% scatter(Data_time4,Exp_data(18:26),48,'MarkerEdgeColor',my_cols(2,:),'Marker','s','Linewidth',1,'MarkerFaceColor',my_cols(2,:))
% 
% error4 = [0.3967948;
% 0.4832015
% 0.5312016
% 0.4576015
% 0.4031949
% 0.4191949
% 0.3583887
% 0.336001
% 0.3711886];
% 
% errorbar(Data_time4, Exp_data(18:26), error4, 'LineStyle','none','Color',my_cols(2,:));
% 
% 
% box off;
% ax = gca;
% ax.LineWidth = 3;
% ax.FontSize = 12;
% set(gcf,'color','w');
% ax.TickDir = 'out';
% ax.XGrid = 'off';
% ax.YGrid = 'off';
% xt = get(gca, 'XTick');
% set(gca, 'FontWeight', 'Bold')
% 
% % title('STAT5B','FontSize',18,'FontWeight','bold','Color','k');
% xlabel('Time (hours)','FontSize',14,'FontWeight','bold','Color','k')
% ylabel('nucleus/cyto ratio','FontSize',14,'FontWeight','bold','Color','k')
% % legend('boxoff')

% Plot Bcl
subplot(1,3,3)
plot(predTime_hours,Bcl_mat(1,:),'--','color',my_cols(3,:),'LineWidth',2)
hold on;
plot(predTime_hours,Bcl_mat(2,:),':','color',my_cols(3,:),'LineWidth',2)
hold on;
plot(predTime_hours,Bcl_mat(3,:),'-','color',my_cols(3,:),'LineWidth',3)
hold on;
plot(predTime_hours,Bcl_mat(4,:),'-.','color',my_cols(3,:),'LineWidth',2)
hold on;
plot(predTime_hours,Bcl_mat(5,:),'-','color',my_cols(3,:),'LineWidth',2)
hold on;
% Experimental data
Data_time5 = [Data_time_hours(8) Data_time_hours(10) Data_time_hours(12) Data_time_hours(13) Data_time_hours(14) Data_time_hours(15) Data_time_hours(16)];
scatter(Data_time5,Exp_data(27:33),48,'MarkerEdgeColor',my_cols(3,:),'Marker','s','Linewidth',1,'MarkerFaceColor',my_cols(3,:))

error5 = [0.0594048;
0.0891216
0.0593759
0.0630888
0.2153281
0.2004768
0.1893241];

errorbar(Data_time5, Exp_data(27:33), error5, 'LineStyle','none','Color',my_cols(3,:));


box off;
ax = gca;
ax.LineWidth = 3;
ax.FontSize = 12;
set(gcf,'color','w');
ax.TickDir = 'out';
ax.XGrid = 'off';
ax.YGrid = 'off';
xt = get(gca, 'XTick');
set(gca, 'FontWeight', 'Bold')

% title('STAT5B','FontSize',18,'FontWeight','bold','Color','k');
xlabel('Time (hours)','FontSize',14,'FontWeight','bold','Color','k')
% title('Bcl-xL','FontSize',14,'FontWeight','bold','Color','k')
ylabel('Bcl-xL fold change','FontSize',14,'FontWeight','bold','Color','k')
ylim([1 4])
% legend('boxoff')

% legend('0.1x','0.5x','1x','2x','10x')
% legend('boxoff')
% legend('Location','eastoutside')

% % Set size of figure
% width = 10;
% height = 6;
% set(gcf,'units','inches','position',[1,0.5,width,height])
% 
% % Save it
% fig_name = strcat(my_param_name,"_A_legend.png");
% saveas(gcf,fig_name)
% 
% 
% % Clear figure
% clf


% PStatB figure

% 
% %--- plot pStatA
% subplot(2,2,1);
% plot(pStat_hours,pStatA_mat(1,:),'--','color',my_cols(1,:),'LineWidth',2)
% hold on;
% plot(pStat_hours,pStatA_mat(2,:),':','color',my_cols(1,:),'LineWidth',2)
% hold on;
% plot(pStat_hours,pStatA_mat(3,:),'-','color',my_cols(1,:),'LineWidth',3)
% hold on;
% plot(pStat_hours,pStatA_mat(4,:),'-.','color',my_cols(1,:),'LineWidth',2)
% hold on;
% plot(pStat_hours,pStatA_mat(5,:),'-','color',my_cols(1,:),'LineWidth',2)
% hold on;
% % Experimental data
% scatter([Data_time_hours(3) Data_time_hours(5) Data_time_hours(6) Data_time_hours(8) Data_time_hours(10) Data_time_hours(12)],Exp_data(1:6),48,'MarkerEdgeColor',my_cols(1,:),'Marker','s','Linewidth',1,'MarkerFaceColor',my_cols(1,:))
% 
% box off;
% ax = gca;
% ax.LineWidth = 3;
% ax.FontSize = 10;
% set(gcf,'color','w');
% ax.TickDir = 'out';
% ax.XGrid = 'off';
% ax.YGrid = 'off';
% xt = get(gca, 'XTick');
% set(gca, 'FontWeight', 'Bold')
% 
% %title('STAT5A','FontSize',14,'FontWeight','bold','Color','k');
% %  xlabel('Time (hours)','FontSize',10,'FontWeight','bold','Color','k')
% ylabel('pStatA norm to 30min','FontSize',14,'FontWeight','bold','Color','k')
% % legend('boxoff')
% title(my_param_name,'FontSize',14,'FontWeight','bold','Color','k');
% 


% %--- plot pStatB
% subplot(2,2,2);
% plot(pStat_hours,pStatB_mat(1,:),'--','color',my_cols(2,:),'LineWidth',2)
% hold on;
% plot(pStat_hours,pStatB_mat(2,:),':','color',my_cols(2,:),'LineWidth',2)
% hold on;
% plot(pStat_hours,pStatB_mat(3,:),'-','color',my_cols(2,:),'LineWidth',3)
% hold on;
% plot(pStat_hours,pStatB_mat(4,:),'-.','color',my_cols(2,:),'LineWidth',2)
% hold on;
% plot(pStat_hours,pStatB_mat(5,:),'-','color',my_cols(2,:),'LineWidth',2)
% hold on;
% % Experimental data
% Data_time2 = [Data_time_hours(3) Data_time_hours(5) Data_time_hours(6) Data_time_hours(8) Data_time_hours(10) Data_time_hours(12)]; 
% scatter(Data_time2,Exp_data(7:12),48,'MarkerEdgeColor',my_cols(2,:),'Marker','s','Linewidth',1,'MarkerFaceColor',my_cols(2,:))
% 
% box off;
% ax = gca;
% ax.LineWidth = 3;
% ax.FontSize = 12;
% set(gcf,'color','w');
% ax.TickDir = 'out';
% ax.XGrid = 'off';
% ax.YGrid = 'off';
% xt = get(gca, 'XTick');
% set(gca, 'FontWeight', 'Bold')
% 
% %  xlabel('Time (hours)','FontSize',10,'FontWeight','bold','Color','k')
% ylabel('pStatB norm to 30min','FontSize',14,'FontWeight','bold','Color','k')
% % legend('boxoff')
% 
% title(my_param_name,'FontSize',14,'FontWeight','bold','Color','k');
% legend('0.1x','0.5x','1x','2x','10x')
% legend('boxoff')
% legend('Location','eastoutside')
% 
% %--- plot translocation prediction A
% subplot(2,2,3);
% plot(pStat_hours,translocA_mat(1,:),'--','color',my_cols(1,:),'LineWidth',2)
% hold on;
% plot(pStat_hours,translocA_mat(2,:),':','color',my_cols(1,:),'LineWidth',2)
% hold on;
% plot(pStat_hours,translocA_mat(3,:),'-','color',my_cols(1,:),'LineWidth',3)
% hold on;
% plot(pStat_hours,translocA_mat(4,:),'-.','color',my_cols(1,:),'LineWidth',2)
% hold on;
% plot(pStat_hours,translocA_mat(5,:),'-','color',my_cols(1,:),'LineWidth',2)
% hold on;
% % Experimental data
% Data_time3 = [Data_time_hours(5) Data_time_hours(6) Data_time_hours(7) Data_time_hours(9) Data_time_hours(12)];
% scatter(Data_time3,Exp_data(13:17),48,'MarkerEdgeColor',my_cols(1,:),'Marker','s','Linewidth',1,'MarkerFaceColor',my_cols(1,:))
% 
% error3 = [0.1919942;
% 0.1599941
% 0.1728005
% 0.1472004
% 0.1664005];
% 
% errorbar(Data_time3, Exp_data(13:17), error3, 'LineStyle','none','Color',my_cols(1,:));
% 
% box off;
% ax = gca;
% ax.LineWidth = 3;
% ax.FontSize = 12;
% set(gcf,'color','w');
% ax.TickDir = 'out';
% ax.XGrid = 'off';
% ax.YGrid = 'off';
% xt = get(gca, 'XTick');
% set(gca, 'FontWeight', 'Bold')
% 
% % title('STAT5A','FontSize',18,'FontWeight','bold','Color','k');
% % xlabel('Time (hours)','FontSize',14,'FontWeight','bold','Color','k')
% % ylabel('nucleus/cytoplasm ratio','FontSize',14,'FontWeight','bold','Color','k')
% % legend('boxoff')
% 
% 

%--- plot translocation prediction B
 subplot(1,3,2);
plot(pStat_hours,translocB_mat(1,:),'--','color',my_cols(2,:),'LineWidth',2)
hold on;
plot(pStat_hours,translocB_mat(2,:),':','color',my_cols(2,:),'LineWidth',2)
hold on;
plot(pStat_hours,translocB_mat(3,:),'-','color',my_cols(2,:),'LineWidth',3)
hold on;
plot(pStat_hours,translocB_mat(4,:),'-.','color',my_cols(2,:),'LineWidth',2)
hold on;
plot(pStat_hours,translocB_mat(5,:),'-','color',my_cols(2,:),'LineWidth',2)
hold on;
% Experimental data
Data_time4 = [Data_time_hours(2) Data_time_hours(4) Data_time_hours(5) Data_time_hours(6) Data_time_hours(8) Data_time_hours(9) Data_time_hours(10) Data_time_hours(11) Data_time_hours(12)];
scatter(Data_time4,Exp_data(18:26),48,'MarkerEdgeColor',my_cols(2,:),'Marker','s','Linewidth',1,'MarkerFaceColor',my_cols(2,:))

error4 = [0.3967948;
0.4832015
0.5312016
0.4576015
0.4031949
0.4191949
0.3583887
0.336001
0.3711886];

errorbar(Data_time4, Exp_data(18:26), error4, 'LineStyle','none','Color',my_cols(2,:));


box off;
ax = gca;
ax.LineWidth = 3;
ax.FontSize = 12;
set(gcf,'color','w');
ax.TickDir = 'out';
ax.XGrid = 'off';
ax.YGrid = 'off';
xt = get(gca, 'XTick');
set(gca, 'FontWeight', 'Bold')

% title('STAT5B','FontSize',18,'FontWeight','bold','Color','k');
xlabel('Time (hours)','FontSize',14,'FontWeight','bold','Color','k')
ylabel('nucleus/cyto ratio B','FontSize',14,'FontWeight','bold','Color','k')
ylim([1 30])
% legend('boxoff')
% legend('0.1x','0.5x','1x','2x','10x')
% legend('boxoff')
% legend('Location','eastoutside')
% 
% % Plot Bcl
% subplot(2,2,4)
% plot(predTime_hours,Bcl_mat(1,:),'--','color',my_cols(3,:),'LineWidth',2)
% hold on;
% plot(predTime_hours,Bcl_mat(2,:),':','color',my_cols(3,:),'LineWidth',2)
% hold on;
% plot(predTime_hours,Bcl_mat(3,:),'-','color',my_cols(3,:),'LineWidth',3)
% hold on;
% plot(predTime_hours,Bcl_mat(4,:),'-.','color',my_cols(3,:),'LineWidth',2)
% hold on;
% plot(predTime_hours,Bcl_mat(5,:),'-','color',my_cols(3,:),'LineWidth',2)
% hold on;
% % Experimental data
% Data_time5 = [Data_time_hours(8) Data_time_hours(10) Data_time_hours(12) Data_time_hours(13) Data_time_hours(14) Data_time_hours(15) Data_time_hours(16)];
% scatter(Data_time5,Exp_data(27:33),48,'MarkerEdgeColor',my_cols(3,:),'Marker','s','Linewidth',1,'MarkerFaceColor',my_cols(3,:))
% 
% error5 = [0.0594048;
% 0.0891216
% 0.0593759
% 0.0630888
% 0.2153281
% 0.2004768
% 0.1893241];
% 
% errorbar(Data_time5, Exp_data(27:33), error5, 'LineStyle','none','Color',my_cols(3,:));
% 
% 
% box off;
% ax = gca;
% ax.LineWidth = 3;
% ax.FontSize = 12;
% set(gcf,'color','w');
% ax.TickDir = 'out';
% ax.XGrid = 'off';
% ax.YGrid = 'off';
% xt = get(gca, 'XTick');
% set(gca, 'FontWeight', 'Bold')
% 
% % title('STAT5B','FontSize',18,'FontWeight','bold','Color','k');
% xlabel('Time (hours)','FontSize',14,'FontWeight','bold','Color','k')
% % title('Bcl-xL','FontSize',14,'FontWeight','bold','Color','k')
% ylabel('Bcl-xL fold change','FontSize',14,'FontWeight','bold','Color','k')
% % legend('boxoff')
% % legend('0.1x','0.5x','1x','2x','10x')
% % legend('boxoff')
% % legend('Location','eastoutside')


% Set size of figure
width = 15;
height = 2.5;
set(gcf,'units','inches','position',[1,0.5,width,height])

% Save it
fig_name = strcat(my_param_name,"_new.png");
saveas(gcf,fig_name)


% Clear figure
clf

end