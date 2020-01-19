% Ryland Mortlock
% December 2nd, 2019

% Generate heat map showing initial peak in Stat5B nucleus/cytoplasm ratio
    % Varying k2 and k12 at the same time
      

clear all
close all
type = 'weighted';

Data_time = importdata('tspan.mat'); 

%Run the model at these timepoints
predTime = [0:60:1*3600];

% Load experimental data
Exp_data = importdata('Exp_data.mat');


% Load fitted parameyer vales
ALL_params = importdata('free_params.mat');
ALL_params = sortrows(ALL_params,1);
numFits = size(ALL_params,1);



%% Set which parameters we will vary
param1_name = 'RJ';
param1_ref = 2;

param2_name = 'PPX';
param2_ref = 6;

multiplier_vec = logspace(-1,1,50);

%% Generate model predictions
tic
% Pre-allocate
result_mat = zeros(length(multiplier_vec),length(multiplier_vec));

% outer loop will set 1st param
for j = 1:length(multiplier_vec)
disp(j)
    
% inner loop will set 2nd param
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
                
               % Vary the parameters of interest
                initvalues(param1_ref,1) = initvalues(param1_ref,1).*multiplier_vec(j);
                initvalues(param2_ref,1) = initvalues(param2_ref,1).*multiplier_vec(k);


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

% Find initial peak in Stat5B nucleus / cytoplasm ratio
my_peaks = findpeaks(transloc_predB(:,i));
if isempty(my_peaks) == 1
    pks(i) = transloc_predB(61,i);
    disp('No peak')
    disp(i)
else
pks(i) = my_peaks(1);
end

clear('my_peaks')
end

% Calculate mean model predictions from 25 parameter sets
result_mat(j,k) = mean(pks(i));

clear('pks')

end
end
toc

save('result_mat_IV_10000.mat','result_mat')

%% Make heat map
% colormap('jet')
% imagesc(result_mat)
% colorbar

% Create this vector of strings just to use for xtick and ytick labels
my_label = strings(1,50);
my_label(1) = 0.1;
my_label(25) = 1;
my_label(50) = 10;

[a b] = size(result_mat);
    

    %Create figure - keep all of this the same
    ny = size(result_mat,2);
    nx = size(result_mat,1);
    fig1 = figure(1);
    padded = padarray((log(result_mat)),[1,1],'post');
    % padded = padarray(result_mat,[1,1],'post');
    p = pcolor(padded);
    colorDepth = 1000;
    colormap(jet(colorDepth));
    set(p, 'EdgeColor', 'none');
%   set(p, 'Edgecolor','black','LineWidth',2)
    set(gca,'xgrid', 'off', 'ygrid', 'off', 'gridlinestyle', '-', 'Xcolor','k', 'Ycolor', 'k','LineWidth',3);
    set(gca,'FontSize',4, 'FontWeight','bold','Fontname','Arial')
    pbaspect([nx ny 1])
    axis  square;
    axis equal tight;
    colorbar
    caxis ([log(min(min(result_mat))) log(max(max(result_mat)))]);
    %caxis ([min(min(result_mat)) max(max(result_mat))]);
    set(gca,'XTick',1:1:b);
    set(gca,'YTick',1:1:a);
    set(gcf,'color','white')
    ax = gca;
    XTick = get(ax, 'XTick');
    XTickLabel = get(ax, 'XTickLabel');
    set(ax,'XTick',XTick+0.5)
    set(ax,'XTickLabel',XTickLabel)
    YTick = get(ax, 'YTick');
    YTickLabel = get(ax, 'YTickLabel');
    set(gca,'TickLength',[ 0 0 ])
    set(ax,'YTick',YTick+0.5)
    set(ax,'YTickLabel',YTickLabel)
    set(gca,'XTickLabel',my_label,'FontSize',16)
    set(gca,'YTickLabel',my_label,'FontSize',16)
    set(gca,'XTickLabelRotation',90)
    set(gcf, 'renderer', 'painters');
    set(gcf, 'color', 'white');
    f = get(gca,'title');
    set(f,'FontSize',16,'FontWeight','bold')

    
    xlabel('PPX')
    ylabel('RJ')
    saveas(fig1,'IV_heat_map','png');
    
    
%     %Here are the only things that should be changed
%     title(time_label)
%     set(gcf, 'PaperUnits', 'inches');
%     x_width=16; %Adjust sizes below to make a good image
%     y_width=12;
%     set(gcf, 'PaperPosition', [1 -1 x_width y_width]);
%     %Set file directory below
%  
% %     filepath2 = '/Users/Ryland/Dropbox/Ryland Project Folder/Nov 2018 eFAST and PI/Sensitivity Analysis/Figures/PRL limited/Sti Heat Maps/';
%     baseFileName = sprintf('%s',time_label);
% %     fullFileName = fullfile(filepath2, baseFileName);
%     saveas(fig2,baseFileName,'png');

