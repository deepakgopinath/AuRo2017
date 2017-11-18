clear all; clc; close all;
load('trial_order_all_4.mat');
load('trial_order_all_od_4.mat');
load('trial_order_all_ph0.mat');
assis = {'w','wo'};
sub = 4;
for i=1:sub
    fileID = fopen(strcat('SNEW4_', int2str(i), '.txt'),'w');
    fprintf(fileID, 'Tasks \t Inter \t Assis \t Goal \t Home \t InitM\n');
    fprintf(fileID, '\n');
    %ph1 protocol
    formatSpec = '%s\t\t %s\t\t %s\t\t %d\t\t %d\t\t %d\n';
    t = ph0_trial_mat(:,:,i);
    for j=1:size(t,1)
        fprintf(fileID,formatSpec,t{j,:});
    end
     fprintf(fileID, '################################\n');
    fprintf(fileID, '################################\n');
    t = ph1_trial_mat(:,:,i);
    for j=1:size(t,1)
        fprintf(fileID,formatSpec,t{j,1}, t{j,2}, assis{t{j,3}}, t{j, 4:6});
    end
    %ph1 on demand
    fprintf(fileID, '********************************\n');
    t = ph1_trial_mat_od(:,:,i);
    for j=1:size(t,1)
        fprintf(fileID,formatSpec,t{j,:});
    end
    %ph2 protocol
    fprintf(fileID, '################################\n');
    fprintf(fileID, '################################\n');
     t = ph2_trial_mat(:,:,i);
    for j=1:size(t,1)
        fprintf(fileID,formatSpec,t{j,1}, t{j,2}, assis{t{j,3}}, t{j, 4:6});
    end
    fprintf(fileID, '********************************\n');
    t = ph2_trial_mat_od(:,:,i);
    for j=1:size(t,1)
        fprintf(fileID,formatSpec,t{j,:});
    end
end