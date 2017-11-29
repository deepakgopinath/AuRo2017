clear all; clc; close all;

%%
subList = {'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9'};
total_subjects = length(subList);
trialList = (1:8)';
phases = {'PH1','PH2'};
interfaces = {'J2', 'HA'};
tasks = {'RE','PO'};
assis = {'wo', 'on'};
task_order = {'PO','RE','RE','PO','RE','PO','PO','RE'}; %Phase 1 tasks. 
trials_per_phase = 16;

loadData;

%%
load('trial_order_testing_8.mat');

%%
ms_re_jon = [];
ms_po_jon = [];
ms_re_jwo = [];
ms_po_jwo = [];

ms_re_hon = [];
ms_po_hon = [];
ms_re_hwo = [];
ms_po_hwo = [];

t_re_jon = [];
t_po_jon = [];
t_re_jwo = [];
t_po_jwo = [];

t_re_hon = [];
t_po_hon = [];
t_re_hwo = [];
t_po_hwo = [];


al_re_jon = [];
al_po_jon = [];
al_re_jwo = [];
al_po_jwo = [];

al_re_hon = [];
al_po_hon = [];
al_re_hwo = [];
al_po_hwo = [];


na_re_jon = [];
na_po_jon = [];

na_re_hon = [];
na_po_hon = [];

mean_ms_re_jwo = 2;%2.3750;
mean_ms_po_jwo = 6.5;%6.8750;
mean_ms_re_hwo = 15;%14.3040;
mean_ms_po_hwo = 32;%34.4783;


%%
for i=1:total_subjects
    user = subList{i};
    trialId = trialList(i);
    ph1_trial_list = ph1_trial_mat(:,:,trialId);
    ph2_trial_list = ph2_trial_mat(:,:,trialId);
    
    %fix human errors in trial conditions
    if strcmp(user, 'H9')
        ph2_trial_list{12, 4} = 4;
    elseif strcmp(user, 'H3')
        ph1_trial_list{11, 6} = 2;
    elseif strcmp(user, 'H2')
        ph1_trial_list{2, 5} = 3;
        ph1_trial_list{3, 5} = 1;
        ph2_trial_list{1, 6} = 3;
    end
    
    %index
    j_ph1_ind = find(strcmp(ph1_trial_list(:,2), 'j'));
    h_ph1_ind = find(strcmp(ph1_trial_list(:,2), 'h'));
    on_ph1_ind = find(strcmp(ph1_trial_list(:,3), 'on'));
    wo_ph1_ind = find(strcmp(ph1_trial_list(:,3), 'wo'));
   
    j_ph2_ind = find(strcmp(ph2_trial_list(:,2), 'j'));
    h_ph2_ind = find(strcmp(ph2_trial_list(:,2), 'h'));
    on_ph2_ind = find(strcmp(ph2_trial_list(:,3), 'on'));
    wo_ph2_ind = find(strcmp(ph2_trial_list(:,3), 'wo'));
     
    ph1_jon_ind = intersect(j_ph1_ind, on_ph1_ind);
    ph2_jon_ind = intersect(j_ph2_ind, on_ph2_ind);
    
    ph1_jwo_ind = intersect(j_ph1_ind, wo_ph1_ind);
    ph2_jwo_ind = intersect(j_ph2_ind, wo_ph2_ind);
    
    ph1_hon_ind = intersect(h_ph1_ind, on_ph1_ind);
    ph2_hon_ind = intersect(h_ph2_ind, on_ph2_ind);
    
    ph1_hwo_ind = intersect(h_ph1_ind, wo_ph1_ind);
    ph2_hwo_ind = intersect(h_ph2_ind, wo_ph2_ind);
    
    ph1id = 1; ph2id = 2; 
    subid = i;
    
    if strcmp(task_order{i},'PO')
        
        ms_po_jon = [ms_po_jon; num_mode_switches(ph1_jon_ind ,ph1id, subid)];
        ms_po_jwo = [ms_po_jwo ; num_mode_switches(ph1_jwo_ind, ph1id, subid)];
        ms_po_hon = [ms_po_hon; num_mode_switches(ph1_hon_ind, ph1id, subid)];
        ms_po_hwo = [ms_po_hwo ; num_mode_switches(ph1_hwo_ind, ph1id, subid)];
   
        %time for g4
        
        t_po_jon = [t_po_jon; total_time_all(ph1_jon_ind, ph1id, subid)];
        t_po_jwo = [t_po_jwo; total_time_all(ph1_jwo_ind, ph1id, subid)];
        t_po_hon = [t_po_hon; total_time_all(ph1_hon_ind, ph1id, subid)];
        t_po_hwo = [t_po_hwo; total_time_all(ph1_hwo_ind, ph1id, subid)];
        
        al_po_jon = [al_po_jon; alpha_all(ph1_jon_ind, ph1id, subid)];
        al_po_jwo = [al_po_jwo; alpha_all(ph1_jwo_ind, ph1id, subid)];
        al_po_hon = [al_po_hon; alpha_all(ph1_hon_ind, ph1id, subid)];
        al_po_hwo = [al_po_hwo; alpha_all(ph1_hwo_ind, ph1id, subid)];
        
%         na_po_jon = [na_po_jon; num_assis_req(ph1_jon_ind, ph1id, subid)./(realmin+num_assis_req(ph1_jon_ind, ph1id, subid)+num_mode_switches(ph1_jon_ind ,ph1id, subid))];
%         na_po_hon = [na_po_hon; num_assis_req(ph1_hon_ind, ph1id, subid)./(realmin+num_assis_req(ph1_hon_ind, ph1id, subid)+num_mode_switches(ph1_hon_ind, ph1id, subid))];
%         
        na_po_jon = [na_po_jon; num_assis_req(ph1_jon_ind, ph1id, subid)];
        na_po_hon = [na_po_hon; num_assis_req(ph1_hon_ind, ph1id, subid)];
        
    else
        ms_po_jon = [ms_po_jon; num_mode_switches(ph2_jon_ind ,ph2id, subid)];
        ms_po_jwo = [ms_po_jwo ; num_mode_switches(ph2_jwo_ind, ph2id, subid)];
        ms_po_hon = [ms_po_hon; num_mode_switches(ph2_hon_ind, ph2id, subid)];
        ms_po_hwo = [ms_po_hwo ; num_mode_switches(ph2_hwo_ind, ph2id, subid)];
   
        %time for g4
        
        t_po_jon = [t_po_jon; total_time_all(ph2_jon_ind, ph2id, subid)];
        t_po_jwo = [t_po_jwo; total_time_all(ph2_jwo_ind, ph2id, subid)];
        t_po_hon = [t_po_hon; total_time_all(ph2_hon_ind, ph2id, subid)];
        t_po_hwo = [t_po_hwo; total_time_all(ph2_hwo_ind, ph2id, subid)];
        
        al_po_jon = [al_po_jon; alpha_all(ph2_jon_ind, ph2id, subid)];
        al_po_jwo = [al_po_jwo; alpha_all(ph2_jwo_ind, ph2id, subid)];
        al_po_hon = [al_po_hon; alpha_all(ph2_hon_ind, ph2id, subid)];
        al_po_hwo = [al_po_hwo; alpha_all(ph2_hwo_ind, ph2id, subid)];
        
        na_po_jon = [na_po_jon; num_assis_req(ph2_jon_ind, ph2id, subid)];
        na_po_hon = [na_po_hon; num_assis_req(ph2_hon_ind, ph2id, subid)];
        
    end
    
    if strcmp(task_order{i},'RE')
        ms_re_jon = [ms_re_jon; num_mode_switches(ph1_jon_ind ,ph1id, subid)];
        ms_re_jwo = [ms_re_jwo ; num_mode_switches(ph1_jwo_ind, ph1id, subid)];
        ms_re_hon = [ms_re_hon; num_mode_switches(ph1_hon_ind, ph1id, subid)];
        ms_re_hwo = [ms_re_hwo ; num_mode_switches(ph1_hwo_ind, ph1id, subid)];
   
        %time for g4
        
        t_re_jon = [t_re_jon; total_time_all(ph1_jon_ind, ph1id, subid)];
        t_re_jwo = [t_re_jwo; total_time_all(ph1_jwo_ind, ph1id, subid)];
        t_re_hon = [t_re_hon; total_time_all(ph1_hon_ind, ph1id, subid)];
        t_re_hwo = [t_re_hwo; total_time_all(ph1_hwo_ind, ph1id, subid)];
        
        al_re_jon = [al_re_jon; alpha_all(ph1_jon_ind, ph1id, subid)];
        al_re_jwo = [al_re_jwo; alpha_all(ph1_jwo_ind, ph1id, subid)];
        al_re_hon = [al_re_hon; alpha_all(ph1_hon_ind, ph1id, subid)];
        al_re_hwo = [al_re_hwo; alpha_all(ph1_hwo_ind, ph1id, subid)];
        
        na_re_jon = [na_re_jon; num_assis_req(ph1_jon_ind, ph1id, subid)];
        na_re_hon = [na_re_hon; num_assis_req(ph1_hon_ind, ph1id, subid)];
    else
        ms_re_jon = [ms_re_jon; num_mode_switches(ph2_jon_ind ,ph2id, subid)];
        ms_re_jwo = [ms_re_jwo ; num_mode_switches(ph2_jwo_ind, ph2id, subid)];
        ms_re_hon = [ms_re_hon; num_mode_switches(ph2_hon_ind, ph2id, subid)];
        ms_re_hwo = [ms_re_hwo ; num_mode_switches(ph2_hwo_ind, ph2id, subid)];
   
        %time for g4
        
        t_re_jon = [t_re_jon; total_time_all(ph2_jon_ind, ph2id, subid)];
        t_re_jwo = [t_re_jwo; total_time_all(ph2_jwo_ind, ph2id, subid)];
        t_re_hon = [t_re_hon; total_time_all(ph2_hon_ind, ph2id, subid)];
        t_re_hwo = [t_re_hwo; total_time_all(ph2_hwo_ind, ph2id, subid)];
        
        al_re_jon = [al_re_jon; alpha_all(ph2_jon_ind, ph2id, subid)];
        al_re_jwo = [al_re_jwo; alpha_all(ph2_jwo_ind, ph2id, subid)];
        al_re_hon = [al_re_hon; alpha_all(ph2_hon_ind, ph2id, subid)];
        al_re_hwo = [al_re_hwo; alpha_all(ph2_hwo_ind, ph2id, subid)];
        
        na_re_jon = [na_re_jon; num_assis_req(ph2_jon_ind, ph2id, subid)];
        na_re_hon = [na_re_hon; num_assis_req(ph2_hon_ind, ph2id, subid)];
    end
    
end

%downsample

ms_po_hon(ms_po_hon < 0) = [];
ms_po_hwo(ms_po_hwo < 0) = [];
ms_po_jon(ms_po_jon < 0) = [];
ms_po_jwo(ms_po_jwo < 0) = [];
ms_re_hon(ms_re_hon < 0) = [];
ms_re_hwo(ms_re_hwo < 0) = [];
ms_re_jon(ms_re_jon < 0) = [];
ms_re_jwo(ms_re_jwo < 0) = [];


al_po_hon(al_po_hon < 0) = [];
al_po_hwo(al_po_hwo < 0) = [];
al_po_jon(al_po_jon < 0) = [];
al_po_jwo(al_po_jwo < 0) = [];
al_re_hon(al_re_hon < 0) = [];
al_re_hwo(al_re_hwo < 0) = [];
al_re_jon(al_re_jon < 0) = [];
al_re_jwo(al_re_jwo < 0) = [];

t_po_hon(t_po_hon < 0) = [];
t_po_hwo(t_po_hwo < 0) = [];
t_po_jon(t_po_jon < 0) = [];
t_po_jwo(t_po_jwo < 0) = [];
t_re_hon(t_re_hon < 0) = [];
t_re_hwo(t_re_hwo < 0) = [];
t_re_jon(t_re_jon < 0) = [];
t_re_jwo(t_re_jwo < 0) = [];

na_po_hon(na_po_hon < 0) = [];
na_po_jon(na_po_jon < 0) = [];
na_re_jon(na_re_jon < 0) = [];
na_re_hon(na_re_hon < 0) = [];
 

randind = randsample(length(ms_po_hon), length(ms_po_hwo));
ms_po_hon = ms_po_hon(randind);
t_po_hon = t_po_hon(randind);
al_po_hon = al_po_hon(randind);
na_po_hon = na_po_hon(randind);

randind = randsample(length(ms_po_jon), length(ms_po_jwo));
ms_po_jon = ms_po_jon(randind);
t_po_jon = t_po_jon(randind);
al_po_jon = al_po_jon(randind);
na_po_jon = na_po_jon(randind);

randind = randsample(length(ms_re_hon), length(ms_re_hwo));
ms_re_hon = ms_re_hon(randind);
t_re_hon = t_re_hon(randind);
al_re_hon = al_re_hon(randind);
na_re_hon = na_re_hon(randind);

randind = randsample(length(ms_re_jon), length(ms_re_jwo));
ms_re_jon = ms_re_jon(randind);
t_re_jon = t_re_jon(randind);
al_re_jon = al_re_jon(randind);
na_re_jon = na_re_jon(randind);


