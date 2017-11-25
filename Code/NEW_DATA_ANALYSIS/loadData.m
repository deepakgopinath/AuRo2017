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
num_mode_switches = zeros(trials_per_phase, length(phases), total_subjects);
mode_switch_time_stamps = cell(trials_per_phase, length(phases), total_subjects);
mode_switches_all = cell(trials_per_phase, length(phases), total_subjects);

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
        
        %alpha
        alpha(1, :) = []; alpha(:, 2) = alpha(:, 2) - start_time;
        alpha = trim_data(alpha, false);
        alpha_all(trialnum, ph, subid) = sum(alpha(:, 1) > 0.6)/length(alpha(:, 1));
%         disp(alpha_all(trialnum, ph, subid));
        
        %remove 0's and initial mode
        assistance_requested(1, :) = [];
        cdim_conf_disamb(1, :) = [];
        cmode_conf_disamb(1, :) = [];
        goal_probabilities(1, :) = [];
        
       
        mode_switches(1:2, :) = []; %remove 0 and initial mode;
        current_mode(1:2, :) = []; %remove 0 and initial mode;
        
        if strcmp(n(8:9), 'HA') %fix the double message for headarray. 
            repeated_index = find(diff(current_mode(:, 2) - start_time) < 0.001) + 1;
            current_mode(repeated_index, :) = [];
        end
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
                mode_switches_all(trialnum, ph, subid) = {mode_switches(setdiff(1:size(mode_switches,1), mode_switch_ignore_list), 1)};
            else
                mode_switch_time_stamps(trialnum, ph, subid) = {-1};
                mode_switches_all(trialnum, ph, subid) = {-1};
            end
            
            if num_assis_req(trialnum, ph, subid) > 0
                assistance_req_time_stamps(trialnum, ph, subid) = {normalized_assistance_times};
                assistance_req_mode_switch_all(trialnum, ph, subid) = {mode_switches(mode_switch_ignore_list, 1)};
                cdim_ar_time_stamps(trialnum, ph, subid) = {normalized_cdim_times};
                cmode_ar_time_stamps(trialnum, ph, subid) = {normalized_cmode_times};
                cdim_ar_conf_all(trialnum, ph, subid) = {cdim_conf_disamb(:, 1:end-1)};
                cmode_ar_conf_all(trialnum, ph, subid) = {cmode_conf_disamb(:,1:end-1)};
                total_time_all(trialnum, ph, subid) = total_time_all(trialnum, ph, subid) - 0*length(normalized_assistance_times);
            else
                assistance_req_time_stamps(trialnum, ph, subid) = {-1};
                assistance_req_mode_switch_all(trialnum, ph, subid) = {-1};
                cdim_ar_time_stamps(trialnum, ph, subid) = {-1};
                cmode_ar_time_stamps(trialnum, ph, subid) = {-1};
                cdim_ar_conf_all(trialnum, ph, subid) = {-1};
                cmode_ar_conf_all(trialnum, ph, subid) = {-1};
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
        end
        
        
    end
end

%%  FIX DATA POINTS. ALL INVALID ONES ARE GIVEN NEGATIVE VALUES. AT THE END OF PARSE DATA REMOVE THEM. 

%H2

%H3

num_mode_switches(12, 2, 2) = -999;
total_time_all(12,2,2) = -999;
alpha_all(12,2,2) = -999;
%H4
num_mode_switches([9,12],2,3) = -999;
total_time_all([9,12],2,3) = -999;
alpha_all([9,12],2,3) = -999;
%H5
num_mode_switches([3,4,11,14, 16],1,4) = -999;
total_time_all([3,4,11,14, 16],1,4) = -999;
alpha_all([3,4,11,14, 16],1,4) = -999;
%H6
%ph1
num_mode_switches(8,1,5) = -999;
total_time_all(8,1,5) = -999;
alpha_all(8,1,5) = -999;
%ph2
num_mode_switches(6,2,5) = -999;
total_time_all(6,2,5) = -999;
alpha_all(6,2,5) = -999;
%H7
num_mode_switches([3,13], 1,6) = -999;
total_time_all([3,13], 1, 6) = -999;
alpha_all([3,13], 1, 6) = -999;
%H8
num_mode_switches([13, 15], 1,7) = -999;
total_time_all([13,15], 1, 7) = -999;
alpha_all([13,15], 1, 7) = -999;


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



