
combi = length(assis)*length(interfaces); %jw, hw, jwo, hwo
tpercombo = 3;

ngt1 = 4;
ngt2 = 5;

t1goal = zeros(combi,tpercombo, sub); %each row is for each combination
t2goal = zeros(combi,tpercombo, sub); 
for i=1:sub
    for j=1:size(t1goal, 1)
        t1goal(j, :, i) = randsample(ngt1, tpercombo);
        t2goal(j, :, i) = randsample(ngt2, tpercombo);
    end
end

goal_list_t1 = zeros(trials_per_task, sub);
goal_list_t2 = zeros(trials_per_task, sub);

for i=1:sub
    t = tps_list(1:12, i);
    g = t1goal(:,:,i);
    ind1 = find(t == 1);
    ind2 = find(t == 2);
    goal_list_t1(ind1, i) = [g(1, :)' ; g(2, :)'];
    goal_list_t1(ind2, i) = [g(3, :)' ; g(4, :)'];
end

for i=1:sub
    t = tps_list(13:24, i);
    g = t2goal(:,:,i);
    ind1 = find(t == 1);
    ind2 = find(t == 2);
    goal_list_t2(ind1, i) = [g(1, :)' ; g(2, :)'];
    goal_list_t2(ind2, i) = [g(3, :)' ; g(4, :)'];
end