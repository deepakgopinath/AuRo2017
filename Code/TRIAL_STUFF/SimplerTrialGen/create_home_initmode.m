

% 
% 
% [X, Y] = meshgrid(1:length(homes_1), 1:length(j2modes));
% hci_list_j2_t1 = [X(:) Y(:)];
% [X, Y] = meshgrid(1:length(homes_1), 1:length(hamodes));
% hci_list_ha_t1 = [X(:) Y(:)];
% [X, Y] = meshgrid(1:length(homes_1), 1:length(j2modes));
% hci_list_j2_t2 = [X(:) Y(:)];
% [X, Y] = meshgrid(1:length(homes_1), 1:length(hamodes));
% hci_list_ha_t2 = [X(:) Y(:)];
% %for t1
% mult = 3; %number of trials per interface per task. Only needed for without assistance. 
% total_trials = sub * mult; %total trials per interface for all ubsjects per tasks
% 
% %For 4 goal task - T1
% home_init_mode_j2_t1 = repmat((1:length(j2modes)*length(homes_1))', floor(total_trials/(length(j2modes)*length(homes_1))) , 1);
% home_init_mode_j2_t1 = home_init_mode_j2_t1(randperm(length(home_init_mode_j2_t1)), 1);
% home_init_mode_j2_t1 = [home_init_mode_j2_t1; randsample(length(j2modes)*length(homes_1),  total_trials - length(home_init_mode_j2_t1))];
% home_init_mode_j2_t1 = reshape(home_init_mode_j2_t1, mult, sub);
% % 
% home_init_mode_ha_t1 = repmat((1:length(hamodes)*length(homes_1))', floor(total_trials/(length(hamodes)*length(homes_1))) , 1);
% home_init_mode_ha_t1 = home_init_mode_ha_t1(randperm(length(home_init_mode_ha_t1)), 1);
% home_init_mode_ha_t1 = [home_init_mode_ha_t1; randsample(length(hamodes)*length(homes_1),  total_trials - length(home_init_mode_ha_t1))];
% home_init_mode_ha_t1 = reshape(home_init_mode_ha_t1, mult, sub);
% 
% 
% %For 4 goal task - T2
% home_init_mode_j2_t2 = repmat((1:length(j2modes)*length(homes_1))', floor(total_trials/(length(j2modes)*length(homes_1))) , 1);
% home_init_mode_j2_t2 = home_init_mode_j2_t2(randperm(length(home_init_mode_j2_t2)), 1);
% home_init_mode_j2_t2 = [home_init_mode_j2_t2; randsample(length(j2modes)*length(homes_1),  total_trials - length(home_init_mode_j2_t2))];
% home_init_mode_j2_t2 = reshape(home_init_mode_j2_t2, mult, sub);
% % 
% home_init_mode_ha_t2 = repmat((1:length(hamodes)*length(homes_1))', floor(total_trials/(length(hamodes)*length(homes_1))) , 1);
% home_init_mode_ha_t2 = home_init_mode_ha_t2(randperm(length(home_init_mode_ha_t2)), 1);
% home_init_mode_ha_t2 = [home_init_mode_ha_t2; randsample(length(hamodes)*length(homes_1),  total_trials - length(home_init_mode_ha_t2))];
% home_init_mode_ha_t2 = reshape(home_init_mode_ha_t2, mult, sub);
% figure;
% histogram(home_init_mode_j2(:));
% figure;
% histogram(home_init_mode_ha(:));


%only home
clear all; clc; close all;
tasks = {'t1', 't2'};
assis = {'w', 'wo'};
interfaces = {'j', 'h'};
trials_per_assis = 3;
trials_per_interface = length(assis)*trials_per_assis;
trials_per_task = length(interfaces)*trials_per_interface;
trials_per_sub = trials_per_task*length(tasks);

load('trial_list_2.mat');
homes_1= {'h1', 'h2', 'h3', 'h4'};
sub = 4;
tps = 24;
total_trials = sub*tps;
%3 goal tasks
home_list = repmat((1:length(homes_1))', floor(total_trials/length(homes_1)) , 1);
home_list = home_list(randperm(length(home_list)), 1);
home_list = [home_list; randsample(length(homes_1),  total_trials - length(home_list))];
home_list = reshape(home_list, tps, sub);

%init mode list = only for those cases where assis is wo.

j2modes = {'xy','xz','rp','y'};
hamodes = {'x','yt','z','r','p','yr'};

%top half rows is for t1, bottom half is for t2
init_mode_list_j2 = zeros(3+3,sub); %3 for j2/wo for t1 and 3 for j2/wo for t2
total_j2_trials = length(init_mode_list_j2(:));
init_mode_list_j2 = repmat((1:length(j2modes))', floor(total_j2_trials/length(j2modes)), 1);
init_mode_list_j2 = init_mode_list_j2(randperm(length(init_mode_list_j2)), 1);
init_mode_list_j2 = [init_mode_list_j2; randsample(length(j2modes),  total_j2_trials - length(init_mode_list_j2))];
init_mode_list_j2 = reshape(init_mode_list_j2, 3+3, sub);

%3+3 for ha/wo for t1 and 3 for ha/wo for t2
init_mode_list_ha = zeros(3+3, sub);
total_ha_trials = length(init_mode_list_ha(:));
init_mode_list_ha = repmat((1:length(hamodes))', floor(total_ha_trials/length(hamodes)), 1);
init_mode_list_ha = init_mode_list_ha(randperm(length(init_mode_list_ha)), 1);
init_mode_list_ha = [init_mode_list_ha; randsample(length(hamodes), total_ha_trials - length(init_mode_list_ha))];
init_mode_list_ha = reshape(init_mode_list_ha, 3+3, sub);