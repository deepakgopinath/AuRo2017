clear all; close all; clc;
%%
subplot(2,3,1);
load('CONF1.mat');
hold on;grid on;
colors = {'k','r','g','b','c','y','k'};
c_list = conf1_cdim_list;

xrows = find(c_list(:,4) == 0);
yrows = find(c_list(:,4) == 1);
zrows = find(c_list(:,4) == 2);

for i=1:size(xrows, 1)
    scatter3(c_list(xrows(i), 1),c_list(xrows(i), 2),c_list(xrows(i), 3),140, 'MarkerEdgeColor', 'r', 'MarkerFaceColor','r', 'MarkerFaceAlpha', 0.2, 'MarkerEdgeAlpha', 0.2,'LineWidth', 1.2 )
end

% CONF 1 labels
xlabel('\bf{X (m)}', 'FontSize', 12);
ylabel('\bf{Y (m)}','FontSize', 12);
ylabel({2010;'Population';'in Years'})
zlabel({'\bf \fontsize{18} Confidence Function: C1' ;' '; '\rm \bf \fontsize{12} Z (m)'});
set(gca, 'XDir', 'reverse');
% set(gca, 'YDir', 'reverse');
scatter3(obj_positions(:,1), obj_positions(:,2), obj_positions(:,3), 700, 'filled', 'MarkerFaceColor', 'm' );
title('Best Control Dimension \it k^{*}:\rm \bf X', 'FontSize', 18);
view([-15 -20]);
axis([-0.8, 0.6, -0.6, 0, 0, 0.7]);
set(gca, 'XTick', [-0.8:0.2:0.6]);
set(gca, 'YTick', [-0.6:0.3:0.0]);
set(gca, 'ZTick', [0:0.2:0.7]);

subplot(2,3,2);hold on; grid on;
for i=1:size(yrows, 1)
    scatter3(c_list(yrows(i), 1),c_list(yrows(i), 2),c_list(yrows(i), 3),140, 'Marker', 'o', 'MarkerEdgeColor', 'g', 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.5,'MarkerFaceColor','g', 'LineWidth', 1.2 )
end
% CONF1
xlabel('\bf{X (m)}', 'FontSize', 12);
ylabel('\bf{Y (m)}','FontSize', 12);
% ylabel({2010;'Population';'in Years'})
zlabel('\rm \bf \fontsize{12} Z (m)');
% line([0,0], [0,0], [0, 0.3], 'LineWidth', 10.0);
set(gca, 'XDir', 'reverse');
% set(gca, 'YDir', 'reverse');
scatter3(obj_positions(:,1), obj_positions(:,2), obj_positions(:,3), 700, 'filled', 'MarkerFaceColor', 'm' );
title('Best Control Dimension \it k^{*}:\rm \bf Y', 'FontSize', 18);
view([-15 -20]);
axis([-0.8, 0.6, -0.6, 0, 0, 0.7]);
set(gca, 'XTick', [-0.8:0.2:0.6]);
set(gca, 'YTick', [-0.6:0.3:0.0]);
set(gca, 'ZTick', [0:0.2:0.7]);

subplot(2,3,3); hold on; grid on;
for i=1:size(zrows, 1)
    scatter3(c_list(zrows(i), 1),c_list(zrows(i), 2),c_list(zrows(i), 3),130, 'MarkerEdgeColor', 'b', 'MarkerFaceColor','b', 'MarkerFaceAlpha', 0.3, 'MarkerEdgeAlpha', 0.3, 'LineWidth', 1.2 )
end
xlabel('\bf{X (m)}', 'FontSize', 12);
ylabel('\bf{Y (m)}','FontSize', 12);
zlabel('\rm \bf \fontsize{12} Z (m)');
set(gca, 'XDir', 'reverse');
% set(gca, 'YDir', 'reverse');
scatter3(obj_positions(:,1), obj_positions(:,2), obj_positions(:,3), 700, 'filled', 'MarkerFaceColor', 'm' );
title('Best Control Dimension \it k^{*}:\rm \bf Z', 'FontSize', 18);
view([-15 -20]);
axis([-0.8, 0.6, -0.6, 0, 0, 0.7]);
set(gca, 'XTick', [-0.8:0.2:0.6]);
set(gca, 'YTick', [-0.6:0.3:0.0]);
set(gca, 'ZTick', [0:0.2:0.7]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% BOTTOM ROW.


subplot(2,3,4);
load('CONF2.mat');
hold on;grid on;
colors = {'k','r','g','b','c','y','k'};
c_list = conf2_cdim_list;

xrows = find(c_list(:,4) == 0);
yrows = find(c_list(:,4) == 1);
zrows = find(c_list(:,4) == 2);

% for i=1:size(conf3_cdim_list,1)
%     scatter3(x(i,1), x(i,2), x(i,3), 'MarkerEdgeColor',colors{x(i,4) + 2}, 'LineWidth', 1.2);
% end
for i=1:size(xrows, 1)
    scatter3(c_list(xrows(i), 1),c_list(xrows(i), 2),c_list(xrows(i), 3),140, 'MarkerEdgeColor', 'r', 'MarkerFaceColor','r', 'MarkerFaceAlpha', 0.2, 'MarkerEdgeAlpha', 0.2,'LineWidth', 1.2 )
end

% CONF 2
xlabel('\bf{X (m)}', 'FontSize', 12);
ylabel('\bf{Y (m)}','FontSize', 12);
% ylabel({2010;'Population';'in Years'})
zlabel({'\bf \fontsize{18} Confidence Function: C2' ;' '; '\rm \bf \fontsize{12} Z (m)'});
% line([0,0], [0,0], [0, 0.3], 'LineWidth', 10.0);
set(gca, 'XDir', 'reverse');
% set(gca, 'YDir', 'reverse');
scatter3(obj_positions(:,1), obj_positions(:,2), obj_positions(:,3), 700, 'filled', 'MarkerFaceColor', 'm' );
% title('Heat map for X - u_{h}.(x_{g} - x)');
% title('Best Control Dimension - \it k^{*}:\rm \bf X', 'FontSize', 16);
view([-15 -20]);
axis([-0.8, 0.6, -0.6, 0, 0, 0.7]);
set(gca, 'XTick', [-0.8:0.2:0.6]);
set(gca, 'YTick', [-0.6:0.3:0.0]);
set(gca, 'ZTick', [0:0.2:0.7]);

subplot(2,3,5);hold on; grid on;
for i=1:size(yrows, 1)
    scatter3(c_list(yrows(i), 1),c_list(yrows(i), 2),c_list(yrows(i), 3),140, 'Marker', 'o', 'MarkerEdgeColor', 'g', 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.5,'MarkerFaceColor','g', 'LineWidth', 1.2 )
end

%CONF2

xlabel('\bf{X (m)}', 'FontSize', 12);
ylabel('\bf{Y (m)}','FontSize', 12);
% ylabel({2010;'Population';'in Years'})
zlabel('\rm \bf \fontsize{12} Z (m)');
% line([0,0], [0,0], [0, 0.3], 'LineWidth', 10.0);
set(gca, 'XDir', 'reverse');
% set(gca, 'YDir', 'reverse');
scatter3(obj_positions(:,1), obj_positions(:,2), obj_positions(:,3), 700, 'filled', 'MarkerFaceColor', 'm' );
% title('Heat map for X - u_{h}.(x_{g} - x)');
% title('Best Control Dimension - \it k^{*}:\rm \bf Y', 'FontSize', 16);
view([-15 -20]);
axis([-0.8, 0.6, -0.6, 0, 0, 0.7]);
set(gca, 'XTick', [-0.8:0.2:0.6]);
set(gca, 'YTick', [-0.6:0.3:0.0]);
set(gca, 'ZTick', [0:0.2:0.7]);

subplot(2,3,6); hold on; grid on;
for i=1:size(zrows, 1)
    scatter3(c_list(zrows(i), 1),c_list(zrows(i), 2),c_list(zrows(i), 3),130, 'MarkerEdgeColor', 'b', 'MarkerFaceColor','b', 'MarkerFaceAlpha', 0.3, 'MarkerEdgeAlpha', 0.3, 'LineWidth', 1.2 )
end


xlabel('\bf{X (m)}', 'FontSize', 12);
ylabel('\bf{Y (m)}','FontSize', 12);
% ylabel({2010;'Population';'in Years'})
zlabel('\rm \bf \fontsize{12} Z (m)');
% line([0,0], [0,0], [0, 0.3], 'LineWidth', 10.0);
set(gca, 'XDir', 'reverse');
% set(gca, 'YDir', 'reverse');
scatter3(obj_positions(:,1), obj_positions(:,2), obj_positions(:,3), 700, 'filled', 'MarkerFaceColor', 'm' );
% title('Heat map for X - u_{h}.(x_{g} - x)');
% title('Best Control Dimension - \it k^{*}:\rm \bf Y', 'FontSize', 16);
view([-15 -20]);
axis([-0.8, 0.6, -0.6, 0, 0, 0.7]);
set(gca, 'XTick', [-0.8:0.2:0.6]);
set(gca, 'YTick', [-0.6:0.3:0.0]);
set(gca, 'ZTick', [0:0.2:0.7]);