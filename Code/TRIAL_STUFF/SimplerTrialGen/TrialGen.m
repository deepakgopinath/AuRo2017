clear; clc; close all;
% 
tasks = {'t1', 't2'};
% assis = {'pr', 'od'};
assis = {'w', 'wo'};
interfaces = {'j', 'h'};
% 
% ind = zeros(length(tasks)*length(assis)*length(interface_order), 1);
% for i=1:length(ind)
%     val =  i-1;
%     ind(i) = str2num((dec2bin(val)));
% end
% 
% sub = 16;
% groups = floor(sub/length(ind));
% 
% total_num_order = repmat(ind, groups, 1);
% total_num_order = total_num_order(randperm(length(total_num_order)),1);
% total_num_order = [total_num_order; ind(randsample(length(ind), sub - groups*length(ind)))];

[M, R] = latin_square(length(interfaces));
sub = 4;
interface_order = zeros(length(tasks)*length(interfaces), sub);
for i=1:sub
    R_ind = datasample(1:size(R,1), length(tasks))';
    for j=1:length(R_ind)
        io = R(R_ind(j), :)';
        interface_order((j-1)*length(io) + 1:(j)*length(io) ,i) = io;
    end
end

trials_per_assis = 3;
trials_per_interface = length(assis)*trials_per_assis;
trials_per_task = length(interfaces)*trials_per_interface;
trials_per_sub = trials_per_task*length(tasks);

% [M, R] = latin_square(trials_per_interface);
[M, R] = latin_square(length(assis));
% tpi_list = zeros(trials_per_interface, sub);
tpi_list = [];
tpt_list = zeros(trials_per_task, sub);
tps_list = [];
for i=1:2
    for i=1:sub
        for k=1:length(interfaces)
            tpi_list = [];
            for j=1:trials_per_assis
                tpi_list = [tpi_list; R(randsample(length(assis), 1), :)'];
            end
            tpt_list(trials_per_interface*(k-1) + 1:trials_per_interface*k, i) = tpi_list;
        end
    end
    tps_list = [tps_list; tpt_list];
    tpt_list = zeros(trials_per_task, sub);
end
disp(tps_list)
disp(histc(tps_list', unique(tps_list')))



