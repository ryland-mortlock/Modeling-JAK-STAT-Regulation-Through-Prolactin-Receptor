% Take MC sample and then pass it to the core file
% July 8th, 2019

clearvars
tic

numSim = 1E5;
num_free_var = 46;

% Pre allocate results matrix
result_mat = zeros(numSim,num_free_var+9+5*3+2*2);

predTime = 0:60:6*3600;

for i = 1:numSim    
   
    disp(i)
    
    % Sample free param values and init values
params(2,1) = find_param_value_log(5.6E-5,100);
params(3,1) = find_param_value_log(5.6E-3,100);
params(4,1) = find_param_value_log(0.04,100);
params(5,1) = find_param_value_log(0.2,100);
params(6,1) = find_param_value_log(0.005,100);
params(7,1) = find_param_value_log(0.008,100);
params(8,1) = find_param_value_log(0.8,100);
params(9,1) = find_param_value_log(0.4,100);
params(11,1) = find_param_value_log(10,10);
params(12,1) = find_param_value_log(0.005,100);
params(13,1) = find_param_value_log(0.5,100);
params(14,1) = find_param_value_log(0.02,100);
params(15,1) = find_param_value_log(0.1,100);
params(16,1) = find_param_value_log(0.001,100);
params(17,1) = find_param_value_log(0.2,100);
params(18,1) = find_param_value_log(0.003,100);
params(19,1) = find_param_value_log(0.001,100);
params(20,1) = find_param_value_log(0.2,100);
params(21,1) = find_param_value_log(0.003,100);
params(22,1) = find_param_value_log(0.0000002,100);
params(23,1) = find_param_value_log(0.2,100);
params(24,1) = find_param_value_log(0.005,100);
params(25,1) = find_param_value_log(0.001,100);
params(26,1) = find_param_value_log(0.2,100);
params(27,1) = find_param_value_log(0.005,100);
params(29,1) = find_param_value_log(0.05,100);

params(30,1) = 0;

params(31,1) = find_param_value_log(400,100);
params(32,1) = find_param_value_log(0.001,100);
params(33,1) = find_param_value_log(0.01,100);
params(34,1) = find_param_value_log(0.02,100);
params(35,1) = find_param_value_log(0.1,100);
params(36,1) = find_param_value_log(0.0005,100);
params(37,1) = find_param_value_log(0.0005,100);
params(38,1) = find_param_value_log(0.0005,100);

params(39,1) = 0;

params(40,1) = find_param_value_log(400,100);
params(41,1) = find_param_value_log(0.001,100);
params(42,1) = find_param_value_log(0.0005,100);
params(43,1) = find_param_value_log(0.01,100);
params(44,1) = find_param_value_log(0.01,100);
params(47,1) = find_param_value_log(1000,100);

initvalues(2,1) = find_param_value_log(12,100);
initvalues(4,1) = find_param_value_log(100,100);
initvalues(5,1) = find_param_value_log(50,100);
initvalues(6,1) = find_param_value_log(60,100);
    
% Assign fixed params and IVs
params(1,1) = 0.00308065413582198;
params(10,1) = 0.000256721177985165;
params(28,1) = 0.0355;
params(45,1) = 0.5;
params(46,1) = 1.42;
    
initvalues(1,1)= 9.09;
initvalues(3,1)= 0;
initvalues(7,1)= 0;
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
    
% Assign variables for calculated quantities
kdeg = params(10,1);
RJ = initvalues(2,1);
Vratio = params(45,1);
ncratio = params(46,1);
totalSTAT = params(47,1);
k17b = params(29,1);

% Calculate quantities
ksyn = kdeg*RJ; % syn rate of RJ
S5c = totalSTAT/(1 + ncratio*Vratio); % STAT5 in cytosol
S5n = (totalSTAT - S5c)/Vratio; %STAT5 in nucleus
k17a = S5n/S5c*(Vratio)*k17b;

%Assign them
params(1,1) = ksyn;
initvalues(3,1) = S5c;
initvalues(21,1) = S5n;
params(28,1) = k17a;
    
% Store MC samples params and IVs to results matrix
result_mat(i,1) = params(2,1);
result_mat(i,2) = params(3,1);
result_mat(i,3) = params(4,1);
result_mat(i,4) = params(5,1);
result_mat(i,5) = params(6,1);
result_mat(i,6) = params(7,1);
result_mat(i,7) = params(8,1);
result_mat(i,8) = params(9,1);
result_mat(i,9) = params(11,1);
result_mat(i,10) = params(12,1);
result_mat(i,11) = params(13,1);
result_mat(i,12) = params(14,1);
result_mat(i,13) = params(15,1);
result_mat(i,14) = params(16,1);
result_mat(i,15) = params(17,1);
result_mat(i,16) = params(18,1);
result_mat(i,17) = params(19,1);
result_mat(i,18) = params(20,1);
result_mat(i,19) = params(21,1);
result_mat(i,20) = params(22,1);
result_mat(i,21) = params(23,1);
result_mat(i,22) = params(24,1);
result_mat(i,23) = params(25,1);
result_mat(i,24) = params(26,1);
result_mat(i,25) = params(27,1);
result_mat(i,26) = params(29,1);
result_mat(i,27) = params(30,1);
result_mat(i,28) = params(31,1);
result_mat(i,29) = params(32,1);
result_mat(i,30) = params(33,1);
result_mat(i,31) = params(34,1);
result_mat(i,32) = params(35,1);
result_mat(i,33) = params(36,1);
result_mat(i,34) = params(37,1);
result_mat(i,35) = params(38,1);
result_mat(i,36) = params(39,1);
result_mat(i,37) = params(40,1);
result_mat(i,38) = params(41,1);
result_mat(i,39) = params(42,1);
result_mat(i,40) = params(43,1);
result_mat(i,41) = params(44,1);
result_mat(i,42) = params(47,1);

result_mat(i,43) = initvalues(2,1);
result_mat(i,44) = initvalues(4,1);
result_mat(i,45) = initvalues(5,1);
result_mat(i,46) = initvalues(6,1);

    
    % Set options
    options = odeset('RelTol',1e-9,'AbsTol',1e-12,'NonNegative',[1:length(initvalues)]);
    
    % simulate the model
    [~, predConc] = ode15s(@core_file_master,predTime,initvalues,options,params);

    % Calculated quantities
    total_pStat = predConc(:,11) + predConc(:,12) +2.*predConc(:,13) + predConc(:,15) + 2*predConc(:,16) + predConc(:,17) + 2*predConc(:,18) + predConc(:,19) + predConc(:,20) + 2*predConc(:,22) + predConc(:,23);
    total_pStat_norm = total_pStat./max(total_pStat);
    total_pStat_inverted = max(total_pStat_norm)-total_pStat_norm;
     
    Stat_cyto = predConc(:,3) + predConc(:,10) + predConc(:,11) + predConc(:,12) + 2*predConc(:,13) + predConc(:,15) + 2*predConc(:,16) + 2*predConc(:,17) + predConc(:,28);
    Stat_nucleus = 2*predConc(:,18) + predConc(:,19) + predConc(:,20) + predConc(:,21) + 2*predConc(:,22) + 2*predConc(:,23);
    fraction_translocated = Stat_nucleus./Stat_cyto;

    rec_total = predConc(:,2) + predConc(:,7) + 2*predConc(:,8) + 2*predConc(:,9) + 2*predConc(:,10) + 2*predConc(:,12) + 2*predConc(:,14) + 2*(predConc(:,27) + predConc(:,28) + predConc(:,29));

    
%     % Store percent translocated
%     result_mat(i,num_free_var+1) = percent_translocated(30+1);
    
    % Run find peaks
    [pks, loc] = findpeaks(total_pStat_norm,predTime,'MinPeakDistance',20*60,'MinPeakProminence',0.01);
    
    %Find valleys
    [vls, loc_vls] = findpeaks(total_pStat_inverted,predTime,'MinPeakDistance',20*60,'MinPeakProminence',0.01);
    
    % Classification
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Weak activation (decision 7)
    if max(total_pStat) <= 0.01*Stat_cyto(1)
        result_mat(i,num_free_var+7) = 1; % Weak activation
    else
        result_mat(i,num_free_var+7) = 2; % Normal
    end
    
    % Store abs max, abs min, final value
    result_mat(i,num_free_var+29) = max(total_pStat); % abs max
    if length(pks) > 0
        result_mat(i,num_free_var+30) = min(total_pStat(loc(1)./60+2:end)); % abs min
    end
    result_mat(i,num_free_var+31) = total_pStat(end); % Final value
    
    % Store shape
    if length(pks) > 2
        
        result_mat(i,num_free_var+1) = 4; % More than 2 peaks
        
        % Store data for first peak
        result_mat(i,num_free_var+10) = total_pStat(loc(1)/60+1); % peak height
        result_mat(i,num_free_var+11) = loc(1); %peak timepoint
        result_mat(i,num_free_var+12) = Stat_nucleus(loc(1)/60+1); 
        result_mat(i,num_free_var+13) = Stat_cyto(loc(1)/60+1);
        result_mat(i,num_free_var+14) = rec_total(loc(1)/60+1);
        
        % Store data for second peak
        result_mat(i,num_free_var+15) = total_pStat(loc(2)/60+1); % peak height
        result_mat(i,num_free_var+16) = loc(2); %peak timepoint
        result_mat(i,num_free_var+17) = Stat_nucleus(loc(2)/60+1); 
        result_mat(i,num_free_var+18) = Stat_cyto(loc(2)/60+1);
        result_mat(i,num_free_var+19) = rec_total(loc(2)/60+1);
        
        % Store data for third peak
        result_mat(i,num_free_var+20) = total_pStat(loc(3)/60+1); % peak height
        result_mat(i,num_free_var+21) = loc(3); %peak timepoint
        result_mat(i,num_free_var+22) = Stat_nucleus(loc(3)/60+1); 
        result_mat(i,num_free_var+23) = Stat_cyto(loc(3)/60+1);
        result_mat(i,num_free_var+24) = rec_total(loc(3)/60+1);

        % Store data for first valley if it exists
        if length(vls) > 0
            result_mat(i,num_free_var+25) = total_pStat(loc_vls(1)/60+1); % peak height
            result_mat(i,num_free_var+26) = loc_vls(1); %peak timepoint
        end
        
        % Store data for second valley if it exists
        if length(vls) > 1
            result_mat(i,num_free_var+27) = total_pStat(loc_vls(2)/60+1); % peak height
            result_mat(i,num_free_var+28) = loc_vls(2); %peak timepoint
        end
        
    end
    
    if length(pks) == 2
        
        result_mat(i,num_free_var+1) = 3; % Two peaks
        
        % Store data for first peak
        result_mat(i,num_free_var+10) = total_pStat(loc(1)/60+1); % peak height
        result_mat(i,num_free_var+11) = loc(1); %peak timepoint
        result_mat(i,num_free_var+12) = Stat_nucleus(loc(1)/60+1); 
        result_mat(i,num_free_var+13) = Stat_cyto(loc(1)/60+1);
        result_mat(i,num_free_var+14) = rec_total(loc(1)/60+1);
        
        % Store data for second peak
        result_mat(i,num_free_var+15) = total_pStat(loc(2)/60+1); % peak height
        result_mat(i,num_free_var+16) = loc(2); %peak timepoint
        result_mat(i,num_free_var+17) = Stat_nucleus(loc(2)/60+1); 
        result_mat(i,num_free_var+18) = Stat_cyto(loc(2)/60+1);
        result_mat(i,num_free_var+19) = rec_total(loc(2)/60+1);
        
        % Store data for first valley if it exists
        if length(vls) > 0
            result_mat(i,num_free_var+25) = total_pStat(loc_vls(1)/60+1); % peak height
            result_mat(i,num_free_var+26) = loc_vls(1); %peak timepoint
        end

        % Decision 2
        if loc(1) <= 3600
           result_mat(i,num_free_var+2) = 1; % Early peak
        elseif loc(1) > 3600
            result_mat(i,num_free_var+2) = 2; % Late peak
        end
        
        %Decision 3
        if total_pStat(loc_vls(1)/60+1) > 0.7*total_pStat(loc(1)/60+1)
            result_mat(i,num_free_var+3) = 1; % FB weak
        elseif total_pStat(loc_vls(1)/60+1) <= 0.7*total_pStat(loc(1)/60+1)
            result_mat(i,num_free_var+3) = 2; % FB strong
        end
        
        % Decision 4
        if total_pStat(end) >= total_pStat(loc(1)/60+1)
            result_mat(i,num_free_var+4) = 2; % prolonged activation
        elseif total_pStat(end) < total_pStat(loc(1)/60+1)
            result_mat(i,num_free_var+4) = 1; % normal
        elseif total_pStat(end) < total_pStat(loc(1)/60+1) && total_pStat(end) >= 0.75*total_pStat(loc(1)/60+1) 
            result_mat(i,num_free_var+4) = 3; % 75% of prolonged activation
        end
        
        % Decision 5
        if loc_vls(1) < 3600
            result_mat(i,num_free_var+5) = 1; % FB too fast
        elseif loc_vls(1) > 3600*3
            result_mat(i,num_free_var+5) = 3; % FB too slow
        else
            result_mat(i,num_free_var+5) = 2; % normal
        end
        
        % Decision 6
        if pks(2) < pks(1)
           result_mat(i,num_free_var+6) = 1; % Smaller second peak
        elseif pks(2) >= pks(1)
           result_mat(i,num_free_var+6) = 2; % Larger second peak
        end
        
        % Decision 8
        if max(total_pStat_norm) > 2.5*pks(1)
            result_mat(i,num_free_var+8) = 1; % Pos FB too strong
        elseif max(total_pStat_norm) <= 2.5*pks(1)
            result_mat(i,num_free_var+8) = 2; % Normal
        end
        
        % Decision 9
        if loc(2) < 3600*3
            result_mat(i,num_free_var+9) = 1; % 2nd peak too early
        elseif loc(2) >= 3600*3
            result_mat(i,num_free_var+9) = 2; % normal
        end
    
    end
    
        
    if length(pks) == 1
        
        result_mat(i,num_free_var+1) = 2; % Single peak
        
        % Store data for first peak
        result_mat(i,num_free_var+10) = total_pStat(loc(1)/60+1); % peak height
        result_mat(i,num_free_var+11) = loc(1); %peak timepoint
        result_mat(i,num_free_var+12) = Stat_nucleus(loc(1)/60+1); 
        result_mat(i,num_free_var+13) = Stat_cyto(loc(1)/60+1);
        result_mat(i,num_free_var+14) = rec_total(loc(1)/60+1);
        
        % Store data for first valley if it exists
        if length(vls) > 0
            result_mat(i,num_free_var+25) = total_pStat(loc_vls(1)/60+1); % peak height
            result_mat(i,num_free_var+26) = loc_vls(1); %peak timepoint
        end
        
        % Decision 2
        if loc(1) <= 3600
           result_mat(i,num_free_var+2) = 1; % Early peak
        elseif loc(1) > 3600
            result_mat(i,num_free_var+2) = 2; % Late peak
        end
        
        %Decision 3
        if min(total_pStat(loc/60+2:end)) > 0.7*total_pStat(loc/60+1)
            result_mat(i,num_free_var+3) = 1; % FB weak
        elseif min(total_pStat(loc/60+2:end)) <= 0.7*total_pStat(loc/60+1)
            result_mat(i,num_free_var+3) = 2; % FB strong
        end
        
        % Decision 4
        if total_pStat(end) >= total_pStat(loc(1)/60+1)
            result_mat(i,num_free_var+4) = 2; % prolonged activation
        
            % Decision 5
            if loc_vls(1) < 3600
                result_mat(i,num_free_var+5) = 1; % FB too fast
            elseif loc_vls(1) > 3600*3
                result_mat(i,num_free_var+5) = 3; % FB too slow
            else
                result_mat(i,num_free_var+5) = 2; % normal
            end
        
        elseif total_pStat(end) < total_pStat(loc(1)/60+1)
            result_mat(i,num_free_var+4) = 1; % normal
        end
        
        % Decision 8
        if max(total_pStat_norm) > 2.5*pks(1)
            result_mat(i,num_free_var+8) = 1; % Pos FB too strong
        elseif max(total_pStat_norm) <= 2.5*pks(1)
            result_mat(i,num_free_var+8) = 2; % Normal
        end
        
    end
        
   if length(pks) == 0 
        result_mat(i,num_free_var+1) = 1; % No peak
   end
    
    % Reset values
    predConc = [];
    pks = [];
    loc = []; 
    
end


save('result4.mat','result_mat')

toc
