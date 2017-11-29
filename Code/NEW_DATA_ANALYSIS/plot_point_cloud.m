clear all; clc ; close all;
% load('CONF3_91.mat');
% % 
% figure;
% hold on;grid on;
% colors = {'k','r','g','b','c','y','k'};
% x = conf3_cdim_list;
% for i=1:size(conf3_cdim_list,1)
%     scatter3(x(i,1), x(i,2), x(i,3), 'MarkerEdgeColor',colors{x(i,4) + 2}, 'LineWidth', 1.2);
% end
% xlabel('World X');
% ylabel('World Y');
% zlabel('World Z');
% set(gca, 'XDir', 'reverse');
% set(gca, 'YDir', 'reverse');
% scatter3(obj_positions(:,1), obj_positions(:,2), obj_positions(:,3), 700, 'filled', 'MarkerFaceColor', 'k' );
% title('Best Control Dimension Heat Map - uh.r + max(0, 1 - d/D)  - (90-10)');
% 
% load('CONF3_55.mat');
% figure;
% hold on;grid on;
% colors = {'k','r','g','b','c','y','k'};
% x = conf3_cdim_list;
% for i=1:size(conf3_cdim_list,1)
%     scatter3(x(i,1), x(i,2), x(i,3), 'MarkerEdgeColor',colors{x(i,4) + 2}, 'LineWidth', 1.2);
% end
% xlabel('World X');
% ylabel('World Y');
% zlabel('World Z');
% set(gca, 'XDir', 'reverse');
% set(gca, 'YDir', 'reverse');
% scatter3(obj_positions(:,1), obj_positions(:,2), obj_positions(:,3), 700, 'filled', 'MarkerFaceColor', 'k' );
% title('Best Control Dimension Heat Map - uh.r + max(0, 1 - d/D) - 50-50');

subplot(1,3,1);
load('CONF4_UNIFORM2_DIST.mat');
hold on;grid on;
colors = {'k','r','g','b','c','y','k'};
c_list = conf3_cdim_list;

xrows = find(c_list(:,4) == 0);
yrows = find(c_list(:,4) == 1);
zrows = find(c_list(:,4) == 2);

% for i=1:size(conf3_cdim_list,1)
%     scatter3(x(i,1), x(i,2), x(i,3), 'MarkerEdgeColor',colors{x(i,4) + 2}, 'LineWidth', 1.2);
% end
for i=1:size(xrows, 1)
    scatter3(c_list(xrows(i), 1),c_list(xrows(i), 2),c_list(xrows(i), 3),140, 'MarkerEdgeColor', 'r', 'MarkerFaceColor','r', 'MarkerFaceAlpha', 0.2, 'MarkerEdgeAlpha', 0.2,'LineWidth', 1.2 )
end

% CONF 1 labels
xlabel('\bf{X (m)}', 'FontSize', 12);
ylabel('\bf{Y (m)}','FontSize', 12);
% ylabel({2010;'Population';'in Years'})
zlabel({'\bf \fontsize{15} Uniform prior' ;' '; '\rm \bf \fontsize{12} Z (m)'});
% line([0,0], [0,0], [0, 0.3], 'LineWidth', 10.0);
set(gca, 'XDir', 'reverse');
% set(gca, 'YDir', 'reverse');
scatter3(obj_positions(:,1), obj_positions(:,2), obj_positions(:,3), 700, 'filled', 'MarkerFaceColor', 'm' );
% title('Heat map for X - u_{h}.(x_{g} - x)');
title('Best Control Dimension \it k^{*}:\rm \bf X', 'FontSize', 15);
xlim([-0.8, 0.8]); ylim([-0.7, 0]); zlim([0, 0.8])
%CONF 2
% xlabel('\bf{X (m)}', 'FontSize', 12);
% ylabel('\bf{Y (m)}','FontSize', 12);
% % ylabel({2010;'Population';'in Years'})
% zlabel({'\bf \fontsize{18} Confidence Function: C2' ;' '; '\rm \bf \fontsize{12} Z (m)'});
% % line([0,0], [0,0], [0, 0.3], 'LineWidth', 10.0);
% set(gca, 'XDir', 'reverse');
% % set(gca, 'YDir', 'reverse');
% scatter3(obj_positions(:,1), obj_positions(:,2), obj_positions(:,3), 700, 'filled', 'MarkerFaceColor', 'm' );
% % title('Heat map for X - u_{h}.(x_{g} - x)');
% % title('Best Control Dimension - \it k^{*}:\rm \bf X', 'FontSize', 16);



view([-15 -20]);
subplot(1,3,2); hold on; grid on;
for i=1:size(yrows, 1)
    scatter3(c_list(yrows(i), 1),c_list(yrows(i), 2),c_list(yrows(i), 3),140, 'Marker', 'o', 'MarkerEdgeColor', 'g', 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.5,'MarkerFaceColor','g', 'LineWidth', 1.2 )
end
%CONF1
xlabel('\bf{X (m)}', 'FontSize', 12);
ylabel('\bf{Y (m)}','FontSize', 12);
% ylabel({2010;'Population';'in Years'})
zlabel('\rm \bf \fontsize{12} Z (m)');
% line([0,0], [0,0], [0, 0.3], 'LineWidth', 10.0);
set(gca, 'XDir', 'reverse');
% set(gca, 'YDir', 'reverse');
scatter3(obj_positions(:,1), obj_positions(:,2), obj_positions(:,3), 700, 'filled', 'MarkerFaceColor', 'm' );
% title('Heat map for X - u_{h}.(x_{g} - x)');
title('Best Control Dimension \it k^{*}:\rm \bf Y', 'FontSize', 15);
view([-15 -20]);
xlim([-0.8, 0.8]); ylim([-0.7, 0]); zlim([0, 0.8])

%CONF2

% xlabel('\bf{X (m)}', 'FontSize', 12);
% ylabel('\bf{Y (m)}','FontSize', 12);
% % ylabel({2010;'Population';'in Years'})
% zlabel('\rm \bf \fontsize{12} Z (m)');
% % line([0,0], [0,0], [0, 0.3], 'LineWidth', 10.0);
% set(gca, 'XDir', 'reverse');
% % set(gca, 'YDir', 'reverse');
% scatter3(obj_positions(:,1), obj_positions(:,2), obj_positions(:,3), 700, 'filled', 'MarkerFaceColor', 'm' );
% % title('Heat map for X - u_{h}.(x_{g} - x)');
% % title('Best Control Dimension - \it k^{*}:\rm \bf Y', 'FontSize', 16);
% view([-15 -20]);

subplot(1,3,3); hold on; grid on;
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
title('Best Control Dimension \it k^{*}:\rm \bf Z', 'FontSize', 15);
view([-15 -20]);
xlim([-0.8, 0.8]); ylim([-0.7, 0]); zlim([0, 0.8])
