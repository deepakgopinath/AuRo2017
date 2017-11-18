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
     
                
%initial mode for on demand section
homes_1= {'h1', 'h2', 'h3', 'h4'};
assis = {'od'};
interfaces = {'j', 'h'};tasks = {'t1', 't2'};
tps = 8; %4 each per task
total_trials = tps*sub;
home_list_od = repmat((1:length(homes_1))', floor(total_trials/length(homes_1)) , 1);
home_list_od = home_list_od(randperm(length(home_list_od)), 1);
home_list_od = [home_list_od; randsample(length(homes_1),  total_trials - length(home_list_od))];
home_list_od = reshape(home_list_od, tps, sub);

%initial mode for on deman section - For all trials. 
init_mode_list_j2_od =  zeros(2+2,sub);%2 for j/od for t1 and 1 for j/od for t2
total_j2_trials_od = length(init_mode_list_j2_od(:));
init_mode_list_j2_od = repmat((1:length(j2modes))', floor(total_j2_trials_od/length(j2modes)), 1);
init_mode_list_j2_od = init_mode_list_j2_od(randperm(length(init_mode_list_j2_od)), 1);
init_mode_list_j2_od = [init_mode_list_j2_od; randsample(length(j2modes),  total_j2_trials_od - length(init_mode_list_j2_od))];
init_mode_list_j2_od = reshape(init_mode_list_j2_od, 2+2, sub);

init_mode_list_ha_od = zeros(2+2, sub);
total_ha_trials_od = length(init_mode_list_ha_od(:));
init_mode_list_ha_od = repmat((1:length(hamodes))', floor(total_ha_trials_od/length(hamodes)), 1);
init_mode_list_ha_od = init_mode_list_ha_od(randperm(length(init_mode_list_ha_od)), 1);
init_mode_list_ha_od = [init_mode_list_ha_od; randsample(length(hamodes), total_ha_trials_od - length(init_mode_list_ha_od))];
init_mode_list_ha_od = reshape(init_mode_list_ha_od, 2+2, sub);

%goal_order for on demand mode, 

combi = length(assis)*length(interfaces); %jw, hw, jwo, hwo
tpercombo = 2;
ngt1 = 4;
ngt2 = 5;

t1goal_od = zeros(combi,tpercombo, sub); %each row is for each combination
t2goal_od = zeros(combi,tpercombo, sub); 
for i=1:sub
    for j=1:size(t1goal_od, 1)
        t1goal_od(j, :, i) = randsample(ngt1, tpercombo);
        t2goal_od(j, :, i) = randsample(ngt2, tpercombo);
    end
end
goal_list_t1_od = zeros(4, sub);
goal_list_t2_od = zeros(4, sub);

for i=1:sub
    g = t1goal_od(:,:,i);
    goal_list_t1_od(:, i) = [g(1,:)' ; g(2,:)'];
    g = t2goal_od(:,:,i);
    goal_list_t2_od(:, i) = [g(1,:)' ; g(2,:)'];
end


%od trial generation
trials = 4;
ph1_trial_mat_od = cell(trials, 6, sub);
ph2_trial_mat_od = cell(trials, 6, sub);

for i=1:sub
    ti = task_array(i,1);
    ci = interfaces_array(i, 1:2);
    ph1_trial_mat_od(:,1,i) = repmat(ti, trials, 1);
    temp = repmat(ci, trials/2, 1);
    ph1_trial_mat_od(:,2,i) = temp(:);
    ph1_trial_mat_od(:,3,i) = repmat(assis, trials, 1);
    if strcmp(ti, 't1')
        ph1_trial_mat_od(:,4,i) = num2cell(goal_list_t1_od(:, i));
    else
        ph1_trial_mat_od(:,4,i) = num2cell(goal_list_t2_od(:, i));
    end
    ph1_trial_mat_od(:,5,i) = num2cell(home_list_od(1:4, i));
    
    j2modelist = init_mode_list_j2_od(1:2, :);
    hamodelist = init_mode_list_ha_od(1:2, :);
    
    ph1_trial_mat_od(:,6,i) = num2cell(zeros(trials,1));
    if ci{1} == 'j'
        ph1_trial_mat_od(1:2, 6, i) = num2cell(j2modelist(:,i));
        ph1_trial_mat_od(3:4, 6, i) = num2cell(hamodelist(:,i));
    else
        ph1_trial_mat_od(3:4, 6, i) = num2cell(j2modelist(:,i));
        ph1_trial_mat_od(1:2, 6, i) = num2cell(hamodelist(:,i));
    end
    
end

%phase 2 tasks

for i=1:sub
    ti = task_array(i,2);
    ci = interfaces_array(i, 3:4);
    ph2_trial_mat_od(:,1,i) = repmat(ti, trials, 1);
    temp = repmat(ci, trials/2, 1);
    ph2_trial_mat_od(:,2,i) = temp(:);
    ph2_trial_mat_od(:,3,i) = repmat(assis, trials, 1);
    if strcmp(ti, 't1')
        ph2_trial_mat_od(:,4,i) = num2cell(goal_list_t1_od(:, i));
    else
        ph2_trial_mat_od(:,4,i) = num2cell(goal_list_t2_od(:, i));
    end
    ph2_trial_mat_od(:,5,i) = num2cell(home_list_od(5:8, i));
    
    j2modelist = init_mode_list_j2_od(3:4, :);
    hamodelist = init_mode_list_ha_od(3:4, :);
    
    ph2_trial_mat_od(:,6,i) = num2cell(zeros(trials,1));
    if ci{1} == 'j'
        ph2_trial_mat_od(1:2, 6, i) = num2cell(j2modelist(:,i));
        ph2_trial_mat_od(3:4, 6, i) = num2cell(hamodelist(:,i));
    else
        ph2_trial_mat_od(3:4, 6, i) = num2cell(j2modelist(:,i));
        ph2_trial_mat_od(1:2, 6, i) = num2cell(hamodelist(:,i));
    end
end

save('trial_order_all_od_4.mat', 'ph1_trial_mat_od', 'ph2_trial_mat_od');
                