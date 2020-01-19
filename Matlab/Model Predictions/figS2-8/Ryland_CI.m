% Ryland Mortlock
% 7/22/19

% Calculate mean and 95% CI of model predictions

% Load data timepoints
Data_time = importdata('tspan.mat'); 

% Load experimental data
Exp_data = importdata('Exp_data.mat');

% Model prediction timepoints
predTime = [0:60:24*3600];

% Load model predictions
pStatA = importdata('pStatA_norm.mat')';
pStatB = importdata('pStatB_norm.mat')';
ncA = importdata('transloc_predA.mat')';
ncB = importdata('transloc_predB.mat')';
Bcl = importdata('Bcl_pred.mat')';

my_num = 4;

pStatA = pStatA(1:my_num,1:361); 
pStatB = pStatB(1:my_num,1:361);
ncA = ncA(1:my_num,1:361);
ncB = ncB(1:my_num,1:361);
Bcl = Bcl(1:my_num,1:1441);

% pStatA = [pStatA(1:my_num,1:361); pStatA(95,1:361)];
% pStatB = [pStatB(1:my_num,1:361); pStatB(95,1:361)];
% ncA = [ncA(1:my_num,1:361); ncA(95,1:361)];
% ncB = [ncB(1:my_num,1:361); ncB(95,1:361)];
% Bcl = [Bcl(1:my_num,:); Bcl(95,:)];

N = size(pStatA,1); % Number of fits

pStatA_mean = mean(pStatA);                     % Mean Of All Experiments At Each Value Of ‘x’
pStatA_std = std(pStatA);
pStatA_SEM = std(pStatA)/sqrt(N);               % Compute ‘Standard Error Of The Mean’ Of All Experiments At Each Value Of ‘x’
pStatA_CI95 = tinv([0.025 0.975], N-1);         % Calculate 95% Probability Intervals Of t-Distribution
pStatA_yCI95 = bsxfun(@times, pStatA_SEM, pStatA_CI95(:));   % Calculate 95% Confidence Intervals Of All Experiments At Each Value Of ‘x’

pStatB_mean = mean(pStatB);                     % Mean Of All Experiments At Each Value Of ‘x’
pStatB_std = std(pStatB);
pStatB_SEM = std(pStatB)/sqrt(N);               % Compute ‘Standard Error Of The Mean’ Of All Experiments At Each Value Of ‘x’
pStatB_CI95 = tinv([0.025 0.975], N-1);         % Calculate 95% Probability Intervals Of t-Distribution
pStatB_yCI95 = bsxfun(@times, pStatB_SEM, pStatB_CI95(:));   % Calculate 95% Confidence Intervals Of All Experiments At Each Value Of ‘x’

ncA_mean = mean(ncA);                     % Mean Of All Experiments At Each Value Of ‘x’
ncA_std = std(ncA);
ncA_SEM = std(ncA)/sqrt(N);               % Compute ‘Standard Error Of The Mean’ Of All Experiments At Each Value Of ‘x’
ncA_CI95 = tinv([0.025 0.975], N-1);         % Calculate 95% Probability Intervals Of t-Distribution
ncA_yCI95 = bsxfun(@times, ncA_SEM, ncA_CI95(:));   % Calculate 95% Confidence Intervals Of All Experiments At Each Value Of ‘x’

ncB_mean = mean(ncB);                     % Mean Of All Experiments At Each Value Of ‘x’
ncB_std = std(ncB);
ncB_SEM = std(ncB)/sqrt(N);               % Compute ‘Standard Error Of The Mean’ Of All Experiments At Each Value Of ‘x’
ncB_CI95 = tinv([0.025 0.975], N-1);         % Calculate 95% Probability Intervals Of t-Distribution
ncB_yCI95 = bsxfun(@times, ncB_SEM, ncB_CI95(:));   % Calculate 95% Confidence Intervals Of All Experiments At Each Value Of ‘x’

Bcl_mean = mean(Bcl);                     % Mean Of All Experiments At Each Value Of ‘x’
Bcl_std = std(Bcl);
Bcl_SEM = std(Bcl)/sqrt(N);               % Compute ‘Standard Error Of The Mean’ Of All Experiments At Each Value Of ‘x’
Bcl_CI95 = tinv([0.025 0.975], N-1);         % Calculate 95% Probability Intervals Of t-Distribution
Bcl_yCI95 = bsxfun(@times, Bcl_SEM, Bcl_CI95(:));   % Calculate 95% Confidence Intervals Of All Experiments At Each Value Of ‘x’


% Plot results
cols = cbrewer('qual','Paired',10);
my_cols(3,:) = cols(10,:); % Purple

cols = cbrewer('seq','Blues',8);
my_cols(1,:) = cols(6,:); % Light blue
my_cols(2,:) = cols(8,:); % Dark blue


Data_time_minutes = Data_time./60;
predTime_minutes =predTime./60;
Data_time_hours = Data_time_minutes./60;
predTime_hours =predTime_minutes./60;
pStat_hours = predTime_hours(1:361);




%--- plot pStatA
subplot(2,2,1);
% [ph,msg]=jbfill(pStat_hours,pStatA_mean+pStatA_yCI95(2,:),pStatA_mean+pStatA_yCI95(1,:),my_cols(1,:),my_cols(1,:),1,0.2);
[ph,msg]=jbfill(pStat_hours,pStatA_mean+pStatA_std,pStatA_mean-pStatA_std,my_cols(1,:),my_cols(1,:),1,0.2);
hold on;
plot(pStat_hours,pStatA_mean,'-','color',my_cols(1,:),'LineWidth',2)
hold on;
% Experimental data
scatter([Data_time_hours(3) Data_time_hours(5) Data_time_hours(6) Data_time_hours(8) Data_time_hours(10) Data_time_hours(12)],Exp_data(1:6),48,'MarkerEdgeColor',my_cols(1,:),'Marker','s','Linewidth',1,'MarkerFaceColor',my_cols(1,:))

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

%title('STAT5A','FontSize',14,'FontWeight','bold','Color','k');
%  xlabel('Time (hours)','FontSize',10,'FontWeight','bold','Color','k')
ylabel('Phosph. STAT5A','FontSize',14,'FontWeight','bold','Color','k')
% legend('boxoff')


%--- plot pStatB
subplot(2,2,2);
%[ph,msg]=jbfill(pStat_hours,pStatB_mean+pStatB_yCI95(2,:),pStatB_mean+pStatB_yCI95(1,:),my_cols(2,:),my_cols(2,:),1,0.2);
[ph,msg]=jbfill(pStat_hours,pStatB_mean+pStatB_std,pStatB_mean-pStatB_std,my_cols(2,:),my_cols(2,:),1,0.2);
hold on;
plot(pStat_hours,pStatB_mean,'-','color',my_cols(2,:),'LineWidth',2)
hold on;

% Experimental data
Data_time2 = [Data_time_hours(3) Data_time_hours(5) Data_time_hours(6) Data_time_hours(8) Data_time_hours(10) Data_time_hours(12)]; 
scatter(Data_time2,Exp_data(7:12),48,'MarkerEdgeColor',my_cols(2,:),'Marker','s','Linewidth',1,'MarkerFaceColor',my_cols(2,:))

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

% title('STAT5B','FontSize',14,'FontWeight','bold','Color','k');
%  xlabel('Time (hours)','FontSize',10,'FontWeight','bold','Color','k')
ylabel('Phosph. STAT5B','FontSize',14,'FontWeight','bold','Color','k')
% legend('boxoff')



%--- plot translocation prediction A
subplot(2,2,3);
%[ph,msg]=jbfill(pStat_hours,ncA_mean+ncA_yCI95(2,:),ncA_mean+ncA_yCI95(1,:),my_cols(1,:),my_cols(1,:),1,0.2);
[ph,msg]=jbfill(pStat_hours,ncA_mean+ncA_std,ncA_mean-ncA_std,my_cols(1,:),my_cols(1,:),1,0.2);
hold on;
plot(pStat_hours,ncA_mean,'-','color',my_cols(1,:),'LineWidth',2)
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

% title('STAT5A','FontSize',18,'FontWeight','bold','Color','k');
% xlabel('Time (hours)','FontSize',14,'FontWeight','bold','Color','k')
% ylabel('nucleus/cytoplasm ratio','FontSize',14,'FontWeight','bold','Color','k')
% legend('boxoff')



%--- plot translocation prediction B
% subplot(2,2,4);
%[ph,msg]=jbfill(pStat_hours,ncB_mean+ncB_yCI95(2,:),ncB_mean+ncB_yCI95(1,:),my_cols(2,:),my_cols(2,:),1,0.2);
[ph,msg]=jbfill(pStat_hours,ncB_mean+ncB_std,ncB_mean-ncB_std,my_cols(2,:),my_cols(2,:),1,0.2);
hold on;
plot(pStat_hours,ncB_mean,'-','color',my_cols(2,:),'LineWidth',2)
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
ylabel('Nucleus/cyto. ratio','FontSize',14,'FontWeight','bold','Color','k')
% legend('boxoff')

% Plot Bcl
subplot(2,2,4)
% [ph,msg]=jbfill(predTime_hours,Bcl_mean+Bcl_yCI95(2,:),Bcl_mean+Bcl_yCI95(1,:),my_cols(3,:),my_cols(3,:),1,0.2);
[ph,msg]=jbfill(predTime_hours,Bcl_mean+Bcl_std,Bcl_mean-Bcl_std,my_cols(3,:),my_cols(3,:),1,0.2);
hold on;
plot(predTime_hours,Bcl_mean,'-','color',my_cols(3,:),'LineWidth',2)
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
% legend('boxoff')




% Set size of figure
width = 10;
height = 6;
set(gcf,'units','inches','position',[1,0.5,width,height])
