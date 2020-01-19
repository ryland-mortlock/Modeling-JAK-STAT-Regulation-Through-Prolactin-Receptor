% Ryland Mortlock
% July 19th, 2019

close all
clearvars

% Load Bayes fitting result
bayes = load('bayes_estimates_v2.mat');
err = bayes.err;
estimates = bayes.estimates;
numFits = length(err);
numParams = size(estimates{1},1);

ref = 5; % Parameter 5


param_names = ["k3",
"k5",
"deg-ratio",
"k8A",
"mult8B",
"mult8AB",
"k9",
"k11",
"k-13",
"k14A",
"mult14B",
"mult14AB",
"k15",
"k16",
"k17outA",
"mult17B",
"k19",
"k21",
"k22",
"k23",
"k24",
"k25a",
"k27",
"k28",
"totalSTAT",
"k30a",
"RJ",
"SHP2",
"PPX",
"PPN"];


for j = 1:numParams

% Make scatter plot of first four runs for chosen parameter
figure()
for i = [7,25,10,19]
    scatter(estimates{i}(j,2001:end),err{i}(2001:end),14,'filled')
    hold on
end
ylabel('Sum of Squared Error','FontSize',16,'FontWeight','bold','Color','k')
xlabel(param_names(j),'FontSize',16,'FontWeight','bold','Color','k')

box off;
ax = gca;
ax.LineWidth = 2;
ax.FontSize = 16;
ax.FontWeight = 'bold';
set(gcf,'color','w');
ax.TickDir = 'out';

saveas(gcf,strcat('scatter_',num2str(j),'.png'))

end
