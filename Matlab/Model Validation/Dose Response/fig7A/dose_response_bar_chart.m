% Ryland Mortlock
% July 24th, 2019

% Dose response bar chart
    % Plot dose response model predictions side by side with Brelje 2002
    % data
    
clearvars
close all
    
% Load model predictions
dr_mod1 = importdata('dr_model_pred1.csv');
dr_mod2 = importdata('dr_model_pred2.csv');
N = size(dr_mod1,1); % Number of fits

dr_mean1 = mean(dr_mod1);             % Mean Of All Experiments At Each Value Of ‘x’
dr_std1 = std(dr_mod1);                % Compute std

dr_mean2 = mean(dr_mod2);          
dr_std2 = std(dr_mod2); 

% Load experimental data
dr_exp = [1;
        1.061691617
        1.283773661
        1.398356699
        1.518058624
        1.659942096
        1.525408251]';

dr_err = [0.0186641;
        0.0276733
        0.0778617
        0.0399011
        0.0836608
        0.1023187
        0.0733621]';

% Structure for bar chart
y = [dr_exp' dr_mean1' dr_mean2'];
x = categorical({'0','50','100','200','500','1,000','5,000'});
x = reordercats(x,{'0','50','100','200','500','1,000','5,000'});

% Plot it
cols = cbrewer('qual','Set1',10);
my_cols(1,:) = cols(10,:); % Gray
cols = cbrewer('seq','Blues',10);
my_cols(2,:) = cols(8,:); % Blue
my_cols(3,:) = cols(10,:); % Dark blue

x = 1:7;
b = bar(x,y);
b(1).FaceColor = my_cols(1,:);
b(2).FaceColor = my_cols(2,:);
b(3).FaceColor = my_cols(3,:);
hold on

% Plot error bars
err = [dr_err' dr_std1' dr_std2'];
ngroups = size(y, 1);
nbars = size(y, 2);
% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, y(:,i), err(:,i),'LineStyle','none','Color','k');
end
hold on

% Format graph
xlabel('Dose (ng/mL)');
ylabel('STAT5B nucleus/cytoplasm');

box off;
ax = gca;
ax.LineWidth = 2;
ax.FontSize = 14;
set(gcf,'color','w');
ax.TickDir = 'out';
ax.XGrid = 'off';
ax.YGrid = 'off';
xt = get(gca, 'XTick');
set(gca, 'FontWeight', 'Bold')
