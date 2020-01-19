% Ryland Mortlock

% June 19th, 2019

% Script to run MC for each model structure 
% To run 100,000 for one structure should take ~5 hours
% To run all 8 should take about 40 hours

% parfor i=1:8
%    
%     
%  

clearvars
base_filepath = '/Users/Ryland/Dropbox/Ryland Project Folder/July 2019/Ensemble Modeling Try 3/';

for i = 1:7
    
    disp('Structure')
    disp(i)
    
    my_number = sprintf('%i',i);
    my_folder = ['Structure ' my_number];
    
    new_filepath = [base_filepath my_folder];
    cd(new_filepath);
    
    MC_script;
    
    base_filepath = '/Users/Ryland/Dropbox/Ryland Project Folder/July 2019/Ensemble Modeling Try 3/';
end
