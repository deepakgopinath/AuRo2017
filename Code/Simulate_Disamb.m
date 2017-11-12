clear all; clc; close all;
%%
global ng delta_t xg;
num_dof = 3;
ng = 3;
nd = 3;
nm = 2; %2-D interface in 3D world
cm = {[1,2], [3]};
w1 = 0.5;
w2 = 0.5;
delta_t = 0.05;
%CONFIDENCE ARRAYS 
conf_p = zeros(ng, 1);
conf_n = zeros(ng, 1);
conf_pp = zeros(ng, 1);
conf_nn = zeros(ng, 1);

Dkjp_c1 = zeros(nd, 1);
Dkjn_c1 = zeros(nd, 1);
Dkjp_c2 = zeros(nd, 1);
Dkjn_c2 = zeros(nd, 1);

Dkjp = zeros(nd, 1);
Dkjn = zeros(nd, 1);
Dkj = zeros(nd, 1);
Dcm = zeros(nm, 1);
kstar = 0;
cmstar = 0;
maxR = 0.5;
minR = -0.5;
minR  + (maxR - minR)*rand(1, ng);
xg = [minR  + (maxR - minR)*rand(1, ng); -rand(1, ng) - 0.02; 0.5*rand(1, ng) + 0.1] + rand(nd,1)*0.2 - rand(nd,1)*0.2; %random goal positions. These will be treated as fixed parameters.
pg0 = (1/ng)*ones(ng, 1);
pg = (1/ng)*ones(ng, 1);
project_time_list = [1,1,2,2]';
projected_pg_list = zeros(nd*ng, length(project_time_list));
xr = [0.405, -0.128, 0.287]';
%%
%PLOT GOALS AND ROBOT and UH
figure;
scatter3(xg(1,1:ng), xg(2,1:ng), xg(3,1:ng), 180, 'k', 'filled'); grid on; hold on;
xlabel('X'); ylabel('Y'); zlabel('Z');
scatter3(xr(1), xr(2), xr(3), 140, 'r', 'filled');
% quiver3(xr(1), xr(2), xr(3), uh(1), uh(2), uh(3), 0, 'LineWidth', 2, 'MaxHeadSize', 2); %current robot velocity arrow
for i=1:ng %vectors connecting robot and goals.
    quiver3(xr(1), xr(2), xr(3), xg(1,i) - xr(1), xg(2,i) - xr(2), xg(3,i) - xr(3), 'LineWidth', 1.5, 'LineStyle', '-.');
end
xrange = [-1,1]; %set axis limits
yrange = [-1,1];
zrange = [-1,1];
line(xrange, [0,0], [0,0], 'Color', 'k', 'LineWidth', 1.5); %draw x and y axes.
line([0,0], yrange, [0,0], 'Color', 'k','LineWidth', 1.5);
line([0,0], [0,0], zrange, 'Color', 'k','LineWidth', 1.5);
axis([xrange, yrange, zrange]);
axis square;
view([210,21]);
%%
total_time = 1;
T = 0:delta_t:total_time;
cell_pgs = cell(nm, 1); %for each dimension
cell_trajs = cell(nm, 1); %to collect trajectories for each. 
pgs = zeros(ng, length(T), ng); %probabilities for each goal (row), at each time step (column) for each uh towards each goal(3rd)
traj = zeros(nd, length(T), ng);
for i=1:ng
    pgs(:, 1, i) = (1/ng)*ones(ng, 1); %initialize pg0
    traj(:, 1, i) = xr;
end

%in each control mode, towards each goal, probabilities of ng goals. 
% for i=1:nm
%     for j=1:ng %for each goal compute uh from xr that would take it towards it 
%         uh = xg(:, j) - xr;
% %         uh = uh/norm(uh); %control command towards ith goal, unit magnitude. 
%         uh(uh ~= uh(i)) = 0; %extract the component along the allowable control dimension
% %         uh(uh == setdiff(uh, uh(cm{i))) = 0
%         uh = 0.2*(uh/norm(uh));
%         %apply the control command for T time and simulate dynamics and compute
%         %probabilities for each goal. 
%         traj = zeros(3, length(T));
%         traj(:, 1) = xr;
%         for k=1:length(T)-1
%              traj(:, k+1) = sim_dyn(traj(:, k), uh); %sim_dyn intenrally updates global robot state
%              pgs(:, k+1, j) = compute_p_of_g_dft(uh, traj(:,k), pgs(:, k, j));
%         end
%     end
%     cell_pgs{i} = pgs;
% end

for i=1:nm %for each mode
    for j=1:ng %for control commands towards each goal
        uh = xg(:, j) - xr;
        zero_dim = setdiff(1:nd,cm{i});
        for jj=1:length(zero_dim)
            uh(zero_dim(jj)) = 0;
        end
        uh = 0.2*(uh/norm(uh));
        for k=1:length(T)-1
             traj(:, k+1, j) = sim_dyn(traj(:, k, j), uh); %sim_dyn intenrally updates global robot state
             pgs(:, k+1, j) = compute_p_of_g_dft(uh, traj(:,k,j), pgs(:, k, j));
        end
    end
    cell_pgs{i} = pgs;
    cell_trajs{i} = traj;
end

%% plot trajectories
for i=1:nm
    for ii = 1:ng
        traj = cell_trajs{i}(:,:,ii);
        figure;
        for j=1:length(T)
            scatter3(traj(1, j), traj(2, j), traj(3, j), 'b', 'filled'); hold on;
        end
        xrange = [-1,1]; %set axis limits
        yrange = [-1,1];
        zrange = [-1,1];
        line(xrange, [0,0], [0,0], 'Color', 'k', 'LineWidth', 1.5); %draw x and y axes.
        line([0,0], yrange, [0,0], 'Color', 'k','LineWidth', 1.5);
        line([0,0], [0,0], zrange, 'Color', 'k','LineWidth', 1.5);
        axis([xrange, yrange, zrange]);
        axis square;
        view([210,21]);
    end
end
%%

for i=1:nm
    figure;
    
end
%%
min_ws = -0.5;
max_ws = 0.5;
num_steps = 8;
step_size = (max_ws - min_ws)/num_steps;
ax_p = (min_ws:step_size:max_ws)' +0.001;
[X,Y,Z] = meshgrid(ax_p);
ws_points = [X(:) Y(:) Z(:)];
disamb_modes = zeros(size(ws_points, 1), 1);
% xr = ws_points(i, :)';