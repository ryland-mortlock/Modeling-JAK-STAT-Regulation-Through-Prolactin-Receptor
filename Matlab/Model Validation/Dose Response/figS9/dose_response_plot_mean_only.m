% Ryland Mortlock
% 7/22/19

% Calculate mean and 95% CI of model predictions

% Model prediction timepoints
predTime = [0:60:1*3600];

% Load model predictions
dr50 = importdata('dr_50.mat')';
dr100 = importdata('dr_100.mat')';
dr200 = importdata('dr_200.mat')';
dr500 = importdata('dr_500.mat')';
dr1000 = importdata('dr_1000.mat')';
dr5000 = importdata('dr_5000.mat')';

% Take predictions through 6 hours only
dr50 = dr50(:,1:61);
dr100 = dr100(:,1:61);
dr200 = dr200(:,1:61);
dr500 = dr500(:,1:61);
dr1000 = dr1000(:,1:61);
dr5000 = dr5000(:,1:61);


N = size(dr50,1); % Number of fits

dr50_mean = mean(dr50);                     
dr50_std = std(dr50);

dr100_mean = mean(dr100);                    
dr100_std = std(dr100);

dr200_mean = mean(dr200);                    
dr200_std = std(dr200);

dr500_mean = mean(dr500);                    
dr500_std = std(dr500);

dr1000_mean = mean(dr1000);                    
dr1000_std = std(dr1000);

dr5000_mean = mean(dr5000);                    
dr5000_std = std(dr5000);


% Plot results
cols = cbrewer('seq','Blues',8);
my_cols(1,:) = cols(3,:); 
my_cols(2,:) = cols(4,:);
my_cols(3,:) = cols(5,:);
my_cols(4,:) = cols(6,:);
my_cols(5,:) = cols(7,:);
my_cols(6,:) = cols(8,:); 


predTime_minutes =predTime./60;
predTime_hours =predTime_minutes./60;



%--- plot translocation prediction B
% subplot(2,2,4);
%[ph,msg]=jbfill(pStat_hours,ncB_mean+ncB_yCI95(2,:),ncB_mean+ncB_yCI95(1,:),my_cols(2,:),my_cols(2,:),1,0.2);
% [ph,msg]=jbfill(predTime_hours,dr50_mean+dr50_std,dr50_mean-dr50_std,my_cols(1,:),my_cols(1,:),1,0.2);
hold on;
plot(predTime_minutes,dr50_mean,'-','color',my_cols(1,:),'LineWidth',3)
hold on;

% [ph,msg]=jbfill(predTime_minutes,dr100_mean+dr100_std,dr100_mean-dr100_std,my_cols(2,:),my_cols(2,:),1,0.2);
hold on;
plot(predTime_minutes,dr100_mean,'-','color',my_cols(2,:),'LineWidth',3)
hold on;

% [ph,msg]=jbfill(predTime_minutes,dr200_mean+dr200_std,dr200_mean-dr200_std,my_cols(3,:),my_cols(3,:),1,0.2);
hold on;
plot(predTime_minutes,dr200_mean,'-','color',my_cols(3,:),'LineWidth',3)
hold on;

% [ph,msg]=jbfill(predTime_minutes,dr500_mean+dr500_std,dr500_mean-dr500_std,my_cols(4,:),my_cols(4,:),1,0.2);
hold on;
plot(predTime_minutes,dr500_mean,'-','color',my_cols(4,:),'LineWidth',3)
hold on;

% [ph,msg]=jbfill(predTime_minutes,dr1000_mean+dr1000_std,dr1000_mean-dr1000_std,my_cols(5,:),my_cols(5,:),1,0.2);
hold on;
plot(predTime_minutes,dr1000_mean,'-','color',my_cols(5,:),'LineWidth',3)
hold on;

% [ph,msg]=jbfill(predTime_minutes,dr5000_mean+dr5000_std,dr5000_mean-dr5000_std,my_cols(6,:),my_cols(6,:),1,0.2);
hold on;
plot(predTime_minutes,dr5000_mean,'-','color',my_cols(6,:),'LineWidth',3)
hold on;


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
xlabel('Time (minutes)','FontSize',12,'FontWeight','bold','Color','k')
ylabel('STAT5B nucleus/cyto ratio','FontSize',12,'FontWeight','bold','Color','k')
% legend('boxoff')
yticks(0:1:4)

legend('50 ng/mL','100 ng/mL','200 ng/mL','500 ng/mL','1,000 ng/mL','5,000 ng/mL')
legend('boxoff')

% Set size of figure
width = 5;
height = 3;
set(gcf,'units','inches','position',[1,0.5,width,height])
