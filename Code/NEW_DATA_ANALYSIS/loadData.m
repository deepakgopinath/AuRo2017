% clear all; clc; close all;
% 
% %%
% subList = {'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9'};
% total_subjects = length(subList);
% trialList = (1:8)';
% phases = {'PH1','PH2'};
% interfaces = {'J2', 'HA'};
% tasks = {'RE','PO'};
% assis = {'wo', 'on'};
% task_order = {'PO','RE','RE','PO','RE','PO','PO','RE'}; %Phase 1 tasks. 
% trials_per_phase = 16;


%%

total_time_all = zeros(trials_per_phase, length(phases), total_subjects);

%user initiated modeswitches =  total_mode_switches - number of assistance
%requests. 
num_assis_req = zeros(trials_per_phase, length(phases), total_subjects); %onlty for trials with 'on' mode 
ar_norm_ts = cell(trials_per_phase, length(phases), total_subjects);
num_mode_switches = zeros(trials_per_phase, length(phases), total_subjects);
mode_switch_time_stamps = cell(trials_per_phase, length(phases), total_subjects);
current_mode_time_stamps = cell(trials_per_phase, length(phases), total_subjects);
mode_switches_all = cell(trials_per_phase, length(phases), total_subjects);
current_mode_all = cell(trials_per_phase, length(phases), total_subjects);

%cdim and cmode coming from ONLY mode switches
cdim_ar_time_stamps = cell(trials_per_phase, length(phases), total_subjects);
cmode_ar_time_stamps = cell(trials_per_phase, length(phases), total_subjects);
cdim_ar_conf_all = cell(trials_per_phase, length(phases), total_subjects);
cmode_ar_conf_all = cell(trials_per_phase, length(phases), total_subjects);

%FOR ONLY MODE SWITCHES DUE TO ASSIS REQ
assistance_req_time_stamps = cell(trials_per_phase, length(phases), total_subjects);
assistance_req_mode_switch_all = cell(trials_per_phase, length(phases), total_subjects);

%ALPHA TIME SERIES

alpha_all = zeros(trials_per_phase, length(phases), total_subjects);

%%

for i=1:total_subjects
    user = subList{i};
    trialId = trialList(i);
    fnames = dir(user);
    numfids = length(fnames);
    for j=3:numfids
        n = fnames(j).name;
        load(n);
        temp = n; n(end-3:end) = []; %remove .mat extension
        if length(n) == 12
            trialnum = str2double(n(end-1:end));
        else
            trialnum = str2double(n(end));
        end
        if strcmp(n(3:5), 'PH1')
            ph = 1;
        elseif strcmp(n(3:5), 'PH2')
            ph = 2;
        end
        subid = str2double(n(2)) - 1; %H1 gets 1 H2 gets 2 and so on and so forth
        total_time_all(trialnum, ph, subid) = total_time;
        alpha(1, :) = []; alpha(:, 2) = alpha(:, 2) - start_time;
        thread_times = alpha(:, 2);
        
        goal_probabilities(1, :) = [];
        if strcmp(n, 'H7PH2REJ2T5') || strcmp(n, 'H8PH2REHAT5') || strcmp(n, 'H9PH1REJ2T15')
            goal_probabilities(1:2, :) = [];
        end
        if strcmp(n, 'H8PH2REHAT8')
            goal_probabilities(1, :) = [];
        end
        goal_probabilities = [goal_probabilities thread_times(1:size(goal_probabilities, 1))];
        goal_probabilities = trim_data(goal_probabilities, false);
        goal_probabilities_all(trialnum, ph, subid) = {goal_probabilities};
        
        if strcmp(n(6:7), 'RE')
            alpha = trim_data(alpha, false);
%             alpha_all(trialnum, ph, subid) = sum(alpha(:, 1) > 0.0)/length(alpha(:, 1));
            alpha_all(trialnum, ph, subid) = alpha(min(find(alpha(:, 1) > 0)), end)/total_time;
        else
            if ph == 1
                taskid = ph1_trial_mat{trialnum, 4 ,subid};  
            else
                taskid = ph2_trial_mat{trialnum, 4 ,subid};
            end
            if taskid == 1 || taskid == 2
                gmarker = 2;
            elseif taskid == 3 || taskid == 4
                gmarker = 4;
            end
            [m, ind] = max(goal_probabilities(:, 1:end-1), [], 2);
            %find all ind which is equal gmarker. 
            gm_ind = find(ind == gmarker);
            m_gm = m(gm_ind);
            m_gm_max = find(m_gm == max(m_gm)); 
            if isempty(m_gm_max)
                continue;
            end
            m_gm_max = m_gm_max(1);
            seg_break = gm_ind(m_gm_max);
            alpha_seg = alpha(seg_break:end, 1);
            
            %find where gp rise and passes threshold right after the seg
            %break
            tempg = goal_probabilities(seg_break:end, 1:end-1);
            tempg = max(tempg, [], 2);
%             coeff = ones(1, 5)/5;
%             smoothtempg = filter(coeff, 1, tempg); smoothtempg(1:3) = []; smoothtempg = [smoothtempg;smoothtempg(end)*ones(3,1)];
            deltat = min(intersect(find(diff(tempg) > 0), find(tempg > 0.25))); %max goal probability above 0.25 means alpha > 0
            frac = (goal_probabilities(seg_break+deltat, end) - goal_probabilities(seg_break, end))/(goal_probabilities(end, end) - goal_probabilities(seg_break, end));
%             plot(goal_probabilities(:, 1:end-1));
            alpha = trim_data(alpha, false);
%             disp(alpha(min(find(alpha(:, 1) > 0)), end)/total_time);
          
            alpha_all(trialnum, ph, subid) = mean([alpha(min(find(alpha(:, 1) > 0)), end)/total_time, frac]);
            
            
%             close all;
        end
        disp(alpha_all(trialnum, ph, subid));
        %alpha's time stamp is shared by all the ones 
        
%         alpha(1, :) = []; alpha(:, 2) = alpha(:, 2) - start_time;
%         thread_times = alpha(:, 2);
%         
% %         goal_probabilities(1, :) = []; 
% %         goal_probabilities = [goal_probabilities thread_times(1:size(goal_probabilities, 1))];
%         
%         alpha = trim_data(alpha, false);
% %         alpha_all(trialnum, ph, subid) = sum(alpha(:, 1) > 0.0)/length(alpha(:, 1));
%         alpha_all(trialnum, ph, subid) = alpha(min(find(alpha(:, 1) > 0)), end)/total_time;
% %         goal_probabilities = trim_data(goal_probabilities, false);
        
%         close all; figure;
%         plot(goal_probabilities(:, end), goal_probabilities(:, 1:end-1)); hold on; grid on;  
        disp(n);
        %remove 0's and initial mode
        assistance_requested(1, :) = [];
        cdim_conf_disamb(1, :) = [];
        cmode_conf_disamb(1, :) = [];
%         disp(alpha_all(trialnum, ph, subid)
       
        mode_switches(1:2, :) = []; %remove 0 and initial mode;
        current_mode(1:2, :) = []; %remove 0 and initial mode;
        
        if strcmp(n(8:9), 'HA') %fix the double message for headarray. 
            repeated_index = find(diff(current_mode(:, 2) - start_time) < 0.001) + 1;
            current_mode(repeated_index, :) = [];
        end
        current_mode(:,2) = current_mode(:,2) - start_time;
        num_mode_switches(trialnum, ph, subid) = size(mode_switches,1) - size(assistance_requested, 1); % and assistance requests also triggers mode switch publisher. 
        num_assis_req(trialnum, ph, subid) = size(assistance_requested, 1);
        
        if size(mode_switches, 1) > 0 %if user didn't press any, and there was no assistance, can happen when it is wo and the initial mode happened to be a good one.
            normalized_mode_switch_times = mode_switches(:, end) - start_time;
            normalized_current_mode_times = current_mode(:, end) - start_time;
            normalized_cdim_times = cdim_conf_disamb(:, end) - start_time;
            normalized_cmode_times = cmode_conf_disamb(:, end) - start_time;
            normalized_assistance_times = assistance_requested(:, end) - start_time;
            
             %Identify ONLY those mode switch time stamps that DID NOT come
            %from assistance requested. THese are the ones which are
            %user-initiated mode switches.
            mode_switch_ignore_list = zeros(length(normalized_assistance_times), 1);
            for kk = 1:size(normalized_assistance_times, 1)
                diff_list = normalized_mode_switch_times - normalized_assistance_times(kk);
                diff_list(diff_list < 0) = -999; %make negative really large negative so that when abs is taken does not play a role. 
                mode_switch_ignore_list(kk) = find(abs(diff_list) == min(abs(diff_list)));
            end
            
            if num_mode_switches(trialnum, ph, subid) > 0 %if there are user initiated mode switches
                mode_switch_time_stamps(trialnum, ph, subid) = {normalized_mode_switch_times((setdiff(1:length(normalized_mode_switch_times), mode_switch_ignore_list)))};
                current_mode_time_stamps(trialnum, ph, subid) = {normalized_current_mode_times((setdiff(1:length(normalized_mode_switch_times), mode_switch_ignore_list)))};
                mode_switches_all(trialnum, ph, subid) = {mode_switches(setdiff(1:size(mode_switches,1), mode_switch_ignore_list), 1)};
                current_mode_all(trialnum, ph, subid) = {current_mode(setdiff(1:size(current_mode,1), mode_switch_ignore_list), 1)};
                %clean up repetetive user activated mode switches for
                %joystick.
                 if strcmp(n(8:9), 'J2')
                    cm_t = current_mode_time_stamps{trialnum, ph, subid};
                    cm = current_mode_all{trialnum, ph, subid};
                    ms_t = mode_switch_time_stamps{trialnum, ph, subid};
                    ms = mode_switches_all{trialnum, ph, subid}; 
                    if ~isempty(find(diff(cm) == 0))
                        ind_cm = find(diff(cm) == 0);
                        ind_cmt = find(diff(cm_t) < 2);
                        if ~isempty(intersect(ind_cm, ind_cmt))
                            cm(intersect(ind_cm, ind_cmt) + 1,:) = [];
                            cm_t(intersect(ind_cm, ind_cmt) + 1,:) = [];
                            ms(intersect(ind_cm, ind_cmt) + 1,:) = [];
                            ms_t(intersect(ind_cm, ind_cmt) + 1,:) = [];
                            
                            current_mode_all(trialnum, ph, subid) = {cm};
                            current_mode_time_stamps(trialnum, ph, subid) = {cm_t};
                            mode_switches_all(trialnum, ph, subid) = {ms};
                            mode_switch_time_stamps(trialnum, ph, subid) = {ms_t};
                            num_mode_switches(trialnum, ph, subid) = num_mode_switches(trialnum, ph, subid) - length(ind);
                            
                            
                        end
                    end
                 end
%                 scatter(mode_switch_time_stamps{trialnum, ph, subid}, 0.2*ones(length(mode_switch_time_stamps{trialnum, ph, subid}), 1), 30, 'k', 'filled');
                
            else
                mode_switch_time_stamps(trialnum, ph, subid) = {-1};
                mode_switches_all(trialnum, ph, subid) = {-1};
                current_mode_time_stamps(trialnum, ph, subid) = {-1};
                current_mode_all(trialnum, ph, subid) = {-1};
            end
            
            if num_assis_req(trialnum, ph, subid) > 0
                assistance_req_time_stamps(trialnum, ph, subid) = {normalized_assistance_times};
                assistance_req_mode_switch_all(trialnum, ph, subid) = {mode_switches(mode_switch_ignore_list, 1)};
                cdim_ar_time_stamps(trialnum, ph, subid) = {normalized_cdim_times};
                cmode_ar_time_stamps(trialnum, ph, subid) = {normalized_cmode_times};
                cdim_ar_conf_all(trialnum, ph, subid) = {cdim_conf_disamb(:, 1:end-1)};
                cmode_ar_conf_all(trialnum, ph, subid) = {cmode_conf_disamb(:,1:end-1)};
                total_time_all(trialnum, ph, subid) = total_time_all(trialnum, ph, subid) - 0*length(normalized_assistance_times);
                 ar_norm_ts(trialnum, ph, subid) = {assistance_req_time_stamps{trialnum, ph, subid}/total_time};
                 
                 %remove duplicate assistance requests for both interfaces
                if ~isempty(diff(normalized_assistance_times))
                    diff_ar_t = diff(normalized_assistance_times);
                    if ~isempty(find(diff_ar_t < 3))
                        ind = find(diff_ar_t < 3) + 1;
                        normalized_assistance_times(ind) = [];
                        ar_ms = assistance_req_mode_switch_all{trialnum, ph, subid};
                        ar_ms(ind) = [];
                        assistance_req_time_stamps(trialnum, ph, subid) = {normalized_assistance_times};
                        assistance_req_mode_switch_all(trialnum, ph, subid) = {ar_ms};
                        num_assis_req(trialnum, ph, subid) = num_assis_req(trialnum, ph, subid) - length(ind); %correct number of assistance request. 
                        ar_norm_ts(trialnum, ph, subid) = {assistance_req_time_stamps{trialnum, ph, subid}/total_time};
                    end
                end


            else
                assistance_req_time_stamps(trialnum, ph, subid) = {-1};
                assistance_req_mode_switch_all(trialnum, ph, subid) = {-1};
                cdim_ar_time_stamps(trialnum, ph, subid) = {-1};
                cmode_ar_time_stamps(trialnum, ph, subid) = {-1};
                cdim_ar_conf_all(trialnum, ph, subid) = {-1};
                cmode_ar_conf_all(trialnum, ph, subid) = {-1};
                ar_norm_ts(trialnum, ph, subid) = {-1};
            end
        else
                mode_switch_time_stamps(trialnum, ph, subid) = {-1};
                mode_switches_all(trialnum, ph, subid) = {-1};
                assistance_req_time_stamps(trialnum, ph, subid) = {-1};
                assistance_req_mode_switch_all(trialnum, ph, subid) = {-1};
                cdim_ar_time_stamps(trialnum, ph, subid) = {-1};
                cmode_ar_time_stamps(trialnum, ph, subid) = {-1};
                cdim_ar_conf_all(trialnum, ph, subid) = {-1};
                cmode_ar_conf_all(trialnum, ph, subid) = {-1};
                cmode_ar_conf_all(trialnum, ph, subid) = {-1};
                current_mode_time_stamps(trialnum, ph, subid) = {-1};
                current_mode_all(trialnum, ph, subid) = {-1};
                ar_norm_ts(trialnum, ph, subid) = {-1};
        end
        
        
    end
end

%%  FIX DATA POINTS. ALL INVALID ONES ARE GIVEN NEGATIVE VALUES. AT THE END OF PARSE DATA REMOVE THEM. 

%H2

%H3

num_mode_switches(12, 2, 2) = -999;
total_time_all(12,2,2) = -999;
alpha_all(12,2,2) = -999;
num_assis_req(12,2,2) = -999;
%H4
num_mode_switches([9,12],2,3) = -999;
total_time_all([9,12],2,3) = -999;
alpha_all([9,12],2,3) = -999;
num_assis_req([9,12],2,3) = -999;
%H5
num_mode_switches([3,4,11,14, 16],1,4) = -999;
total_time_all([3,4,11,14, 16],1,4) = -999;
alpha_all([3,4,11,14, 16],1,4) = -999;
num_assis_req([3,4,11,14, 16],1,4) = -999;
%H6
%ph1
num_mode_switches(8,1,5) = -999;
total_time_all(8,1,5) = -999;
alpha_all(8,1,5) = -999;
num_assis_req(8,1,5) = -999;
%ph2
num_mode_switches(6,2,5) = -999;
total_time_all(6,2,5) = -999;
alpha_all(6,2,5) = -999;
num_assis_req(6,2,5) = -999;
%H7
num_mode_switches([3,13], 1,6) = -999;
total_time_all([3,13], 1, 6) = -999;
alpha_all([3,13], 1, 6) = -999;
num_assis_req([3,13], 1, 6) = -999;
%H8
num_mode_switches([13, 15], 1,7) = -999;
total_time_all([13,15], 1, 7) = -999;
alpha_all([13,15], 1, 7) = -999;
num_assis_req([13,15], 1, 7) = -999;


function [td] = trim_data(d, isrow)
    if isrow
        ts = d(end, :);
    else
        ts = d(:, end);
    end
    first_t = find(ts < 0);
    first_t = first_t(end);
    if isrow()
        d(:, 1:first_t) = [];
    else
        d(1:first_t, :) = [];
    end
    td = d;
end




