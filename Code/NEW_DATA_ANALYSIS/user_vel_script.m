clear all; clc; close all;

%%
subList = {'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9'};
total_subjects = length(subList);
trialList = (1:8)';
phases = {'PH1','PH2'};
interfaces = {'J2', 'HA'};
tasks = {'RE','PO'}; %REACHING AND POURING. 
assis = {'wo', 'on'};
task_order = {'PO','RE','RE','PO','RE','PO','PO','RE'}; %Phase 1 tasks FOR EACH SUBJECTS. 
trials_per_phase = 16;

load('trial_order_testing_8.mat'); % LOAD THE TRIAL ORDER. THIS IS FOR loadData TO CHECK FOR SOME CRITERION. 
drop_rate = [];
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
            interface_type = n(end-4:end-3);
        else
            trialnum = str2double(n(end));
            interface_type = n(end-3:end-2);
        end
        if strcmp(interface_type, 'HA')
            a = 10;
        end
        
    end
end