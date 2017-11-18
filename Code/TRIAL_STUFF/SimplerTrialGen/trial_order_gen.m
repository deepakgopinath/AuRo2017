sub = 4;
task_array = [repmat(tasks, sub/2, 1); repmat(fliplr(tasks), sub/2, 1)];
interfaces_array = {'j','h','j','h';
                    'h','j','h','j';
                    'j','h','h','j';
                    'h','j','j', 'h';
                    'j','h','j','h';
                    'h','j','h','j';
                    'j','h','h','j';
                    'h','j','j', 'h'};

trials = 12;
%ph refers to the phase. phase 1 can have t1 or t2. similaryl ph2 can have
%t1 or t2. 
ph1_trial_mat = cell(trials, 6, sub); %task, interface, assistance, goal, init home, init mode
ph2_trial_mat = cell(trials, 6, sub);
%t1 trials:
for i=1:sub
    ti = task_array(i,1);
    ci = interfaces_array(i, 1:2);
    ph1_trial_mat(:,1,i) = repmat(ti, trials, 1);
    temp = repmat(ci, trials/2, 1);
    ph1_trial_mat(:,2,i) = temp(:);
    assis_list = tps_list(1:12, i);
    ph1_trial_mat(:,3,i) = num2cell(assis_list);
    if strcmp(ti, 't1')
        ph1_trial_mat(:,4,i) = num2cell(goal_list_t1(:, i));
    else
        ph1_trial_mat(:,4,i) = num2cell(goal_list_t2(:, i));
    end
    ph1_trial_mat(:,5,i) = num2cell(home_list(1:12, i));
    j2modelist = init_mode_list_j2(1:3, :);
    hamodelist = init_mode_list_ha(1:3, :);
    
    ph1_trial_mat(:,6,i) = num2cell(zeros(12,1));
    if ci{1} == 'j'
        ind = find(assis_list(1:6) == 2);
        ph1_trial_mat(ind, 6, i) = num2cell(j2modelist(:,i));
    else
        ind = find(assis_list(1:6) == 2);
        ph1_trial_mat(ind, 6, i) = num2cell(hamodelist(:,i));
    end
    if ci{2} == 'j'
        ind = find(assis_list(7:12) == 2) + 6;
        ph1_trial_mat(ind, 6, i) = num2cell(j2modelist(:,i));
    else
        ind = find(assis_list(7:12) == 2) + 6;
        ph1_trial_mat(ind, 6, i) = num2cell(hamodelist(:,i));
    end
end


for i=1:sub
    ti = task_array(i,2);
    ci = interfaces_array(i, 3:4);
    ph2_trial_mat(:,1,i) = repmat(ti, trials, 1);
    temp = repmat(ci, trials/2, 1);
    ph2_trial_mat(:,2,i) = temp(:);
    assis_list = tps_list(13:24, i);
    ph2_trial_mat(:,3,i) = num2cell(assis_list);
    if strcmp(ti, 't1')
        ph2_trial_mat(:,4,i) = num2cell(goal_list_t1(:, i));
    else
        ph2_trial_mat(:,4,i) = num2cell(goal_list_t2(:, i));
    end
    ph2_trial_mat(:,5,i) = num2cell(home_list(13:24, i));
    j2modelist = init_mode_list_j2(4:6, :);
    hamodelist = init_mode_list_ha(4:6, :);
    
    ph2_trial_mat(:,6,i) = num2cell(zeros(12,1));
    if ci{1} == 'j'
        ind = find(assis_list(1:6) == 2);
        ph2_trial_mat(ind, 6, i) = num2cell(j2modelist(:,i));
    else
        ind = find(assis_list(1:6) == 2);
        ph2_trial_mat(ind, 6, i) = num2cell(hamodelist(:,i));
    end
    if ci{2} == 'j'
        ind = find(assis_list(7:12) == 2) + 6;
        ph2_trial_mat(ind, 6, i) = num2cell(j2modelist(:,i));
    else
        ind = find(assis_list(7:12) == 2) + 6;
        ph2_trial_mat(ind, 6, i) = num2cell(hamodelist(:,i));
    end
end
save('trial_order_all_4.mat', 'ph1_trial_mat', 'ph2_trial_mat');
