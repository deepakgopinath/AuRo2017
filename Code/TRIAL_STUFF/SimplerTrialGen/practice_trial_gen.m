sub = 4;
trials_per_interface = 4;
interfaces = {'j','h'};
task = {'t0'};
assis = {'w','wo'};
trials = trials_per_interface*length(interfaces);



ph0_trial_mat = cell(trials,6,sub);
total_trials = trials*sub;

for i=1:sub
    ph0_trial_mat(:,1,i) = repmat(task, trials, 1);
    if mod(i,2) == 0
        temp = repmat(interfaces, trials/2, 1);
    else
        temp = repmat(fliplr(interfaces), trials/2, 1);
    end
    ph0_trial_mat(:,2,i) = temp(:);
    
    assis_list = [randsample(4,4); randsample(4,4)];
    assis_list(assis_list == 3) = 1;
    assis_list(assis_list == 4) = 2;
    for j=1:size(assis_list, 1)
        ph0_trial_mat(j,3,i) = {assis{assis_list(j)}};
    end
    goal_list = [randsample(3,3); randi(3,1);randsample(3,3); randi(3,1)];
    ph0_trial_mat(:,4,i) = num2cell(goal_list);
    home_list = [randsample(4,4); randsample(4,4)];
    ph0_trial_mat(:,5,i) = num2cell(home_list);
    ph0_trial_mat(:,6,i) = num2cell(zeros(trials, 1));
    if mode(i,2) == 0
        wo_j_ind = find(assis_list(1:4) == 2);
        wo_h_ind = find(assis_list(5:8) == 2) + 4;
        ph0_trial_mat(wo_j_ind, 6, i) = num2cell(randsample(4,2));
        ph0_trial_mat(wo_h_ind, 6, i) = num2cell(randsample(6,2));
    else
        wo_j_ind = find(assis_list(5:8) == 2) + 4;
        wo_h_ind = find(assis_list(1:4) == 2);
        ph0_trial_mat(wo_j_ind, 6, i) = num2cell(randsample(4,2));
        ph0_trial_mat(wo_h_ind, 6, i) = num2cell(randsample(6,2));
    end
end

save('trial_order_all_ph0.mat', 'ph0_trial_mat', 'ph0_trial_mat');