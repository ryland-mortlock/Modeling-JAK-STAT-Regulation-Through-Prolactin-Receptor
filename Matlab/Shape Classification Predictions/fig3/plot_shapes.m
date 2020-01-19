% Ryland Mortlock
% July 28th

clearvars
close all
clc

% Plot simuations from each shape with CI and std


% Loop through all shapes
for j = 2:14 %14


% Model prediction timepoints
predTime = [0:60:6*3600];

filename = strcat('pStat_shape',string(j),'.mat');

% Load model predictions
pStat = importdata(filename)';

N = size(pStat,1); % Number of fits

pStat_mean = mean(pStat);                     % Mean Of All Experiments At Each Value Of ‘x’
pStat_std = std(pStat);
pStat_SEM = std(pStat)/sqrt(N);               % Compute ‘Standard Error Of The Mean’ Of All Experiments At Each Value Of ‘x’
pStat_CI95 = tinv([0.025 0.975], N-1);         % Calculate 95% Probability Intervals Of t-Distribution
pStat_yCI95 = bsxfun(@times, pStat_SEM, pStat_CI95(:));   % Calculate 95% Confidence Intervals Of All Experiments At Each Value Of ‘x’

% Plot results
my_cols = cbrewer('qual','Set1',4);

% Data_time_minutes = Data_time./60;
predTime_minutes =predTime./60;
% Data_time_hours = Data_time_minutes./60;
predTime_hours =predTime_minutes./60;


%% --- plot pStat +/- 95% CI
figure()
[ph,msg]=jbfill(predTime_hours,pStat_mean+pStat_yCI95(2,:),pStat_mean+pStat_yCI95(1,:),my_cols(2,:),my_cols(2,:),1,0.2);
hold on;
plot(predTime_hours,pStat_mean,'-','color',my_cols(2,:),'LineWidth',2)
hold on;

box off;
ax = gca;
ax.LineWidth = 3;
ax.FontSize = 14;
set(gcf,'color','w');
ax.TickDir = 'out';
ax.XGrid = 'off';
ax.YGrid = 'off';
xt = get(gca, 'XTick');
set(gca, 'FontWeight', 'Bold')


% title('STAT5A','FontSize',14,'FontWeight','bold','Color','k');
xlabel('Time (hours)','FontSize',18,'FontWeight','bold','Color','k')
% ylabel('pStatA norm to 30min','FontSize',10,'FontWeight','bold','Color','k')

% y bounds
if j <= 7
ylim([0 1])

elseif j == 11
ylim([0 15])

else
ylim([0 2])

end

% % Set size of figure
width = 4;
height = 2.5;
set(gcf,'units','inches','position',[1,0.5,width,height])

fig_name = strcat('shape',string(j),'_ci.png');
saveas(gcf,fig_name)


%% --- plot pStat +/- std
figure()
[ph,msg]=jbfill(predTime_hours,pStat_mean+pStat_std,pStat_mean-pStat_std,my_cols(2,:),my_cols(2,:),1,0.2);
hold on;
plot(predTime_hours,pStat_mean,'-','color',my_cols(2,:),'LineWidth',2)
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

% title('STAT5A','FontSize',14,'FontWeight','bold','Color','k');
xlabel('Time (hours)','FontSize',10,'FontWeight','bold','Color','k')
% ylabel('pStatA norm to 30min','FontSize',10,'FontWeight','bold','Color','k')

% y bounds
if j <= 7
ylim([0 1])

elseif j == 11
ylim([0 15])

else
ylim([0 2])

end


% % Set size of figure
width = 4;
height = 2.5;
set(gcf,'units','inches','position',[1,0.5,width,height])

fig_name = strcat('shape',string(j),'_std.png');
saveas(gcf,fig_name)

% clearvars

end

