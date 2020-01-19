% Ryland Mortlock
% 7/24/19

% Calculate mean and 95% CI of model predictions

% Model prediction timepoints
predTime = [0:60:48*3600];

% Load model predictions
cont = importdata('Bcl_cont.mat')';
pulse = importdata('Bcl_pulse.mat')';


% pStatA = [pStatA(1:my_num,1:361); pStatA(95,1:361)];
% pStatB = [pStatB(1:my_num,1:361); pStatB(95,1:361)];
% ncA = [ncA(1:my_num,1:361); ncA(95,1:361)];
% ncB = [ncB(1:my_num,1:361); ncB(95,1:361)];
% Bcl = [Bcl(1:my_num,:); Bcl(95,:)];

N = size(cont,1); % Number of fits

cont_mean = mean(cont);                    % Mean Of All Experiments At Each Value Of ‘x’
cont_std = std(cont);
cont_SEM = std(cont)/sqrt(N);               % Compute ‘Standard Error Of The Mean’ Of All Experiments At Each Value Of ‘x’
cont_CI95 = tinv([0.025 0.975], N-1);         % Calculate 95% Probability Intervals Of t-Distribution
cont_yCI95 = bsxfun(@times, cont_SEM, cont_CI95(:));   % Calculate 95% Confidence Intervals Of All Experiments At Each Value Of ‘x’

pulse_mean = mean(pulse);                     % Mean Of All Experiments At Each Value Of ‘x’
pulse_std = std(pulse);
pulse_SEM = std(pulse)/sqrt(N);               % Compute ‘Standard Error Of The Mean’ Of All Experiments At Each Value Of ‘x’
pulse_CI95 = tinv([0.025 0.975], N-1);         % Calculate 95% Probability Intervals Of t-Distribution
pulse_yCI95 = bsxfun(@times, pulse_SEM, pulse_CI95(:));   % Calculate 95% Confidence Intervals Of All Experiments At Each Value Of ‘x’

FC = cont./pulse;
FC_mean = mean(FC);
FC_std = std(FC);

% Plot results
cols = cbrewer('qual','Paired',10);
my_cols(2,:) = cols(10,:); % Purple
% FigAColor = [0.4940    0.1840    0.5560];
% leftgraphCIcolor = [0 0.4470 0.7410];

% Data_time_minutes = Data_time./60;
predTime_minutes =predTime./60;
% Data_time_hours = Data_time_minutes./60;
predTime_hours =predTime_minutes./60;
pStat_hours = predTime_hours(1:361);




%--- plot Bcl cont
% [ph,msg]=jbfill(predTime_hours,cont_mean+cont_yCI95(2,:),cont_mean+cont_yCI95(1,:),my_cols(2,:),my_cols(2,:),1,0.2);
% hold on;
% plot(predTime_hours,cont_mean,'-','color',my_cols(2,:),'LineWidth',3)
% hold on;
% 
% % plot Bcl pulse
% [ph,msg]=jbfill(predTime_hours,pulse_mean+pulse_yCI95(2,:),pulse_mean+pulse_yCI95(1,:),my_cols(2,:),my_cols(2,:),1,0.2);
% hold on;
% plot(predTime_hours,pulse_mean,'-','color',my_cols(2,:),'LineWidth',3)
% hold on;

[ph,msg]=jbfill(predTime_hours,cont_mean+cont_std,cont_mean-cont_std,my_cols(2,:),my_cols(2,:),1,0.2);
hold on;
plot(predTime_hours,cont_mean,'-','color',my_cols(2,:),'LineWidth',2)
hold on;

% plot Bcl pulse
[ph,msg]=jbfill(predTime_hours,pulse_mean+pulse_std,pulse_mean-pulse_std,my_cols(2,:),my_cols(2,:),1,0.2);
hold on;
plot(predTime_hours,pulse_mean,'-.','color',my_cols(2,:),'LineWidth',2)
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
xlabel('Time (hours)','FontSize',14,'FontWeight','bold','Color','k')
% title('Bcl-xL','FontSize',14,'FontWeight','bold','Color','k')
ylabel('Bcl-xL Fold Change','FontSize',14,'FontWeight','bold','Color','k')
% legend('boxoff')




% % Set size of figure
 width = 5;
 height = 3;
set(gcf,'units','inches','position',[1,0.5,width,height])
