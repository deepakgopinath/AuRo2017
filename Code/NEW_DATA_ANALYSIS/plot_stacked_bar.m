close all;
parse_data;

%%
interfaces = {'j', 'h'};
interfaces_cell_ms = {'ms_po_jon','ms_po_jwo','ms_re_jon','ms_re_jwo';
                    'ms_po_hon','ms_po_hwo','ms_re_hon','ms_re_hwo'};
interfaces_cell_ar = {'na_po_jon','na_re_jon', 'na_po_hon', 'na_re_hon';
                    'na_po_jon', 'na_po_hon', 'na_re_jon','na_re_hon'};

                
%% sum of button presses
% bp_jon = [sum(ms_re_jon + ms_po_jon), sum(na_re_jon + na_po_jon)];
% bp_jwo = [sum(ms_re_jwo + ms_po_jwo), 0];
% 
% h1 = bar([0.8, 1.2], [bp_jon;bp_jwo], 'stacked'); grid on; hold on;
% set(h1(2), 'FaceColor', [1,0,0]);
% set(h1, 'EdgeColor', 'k', 'LineWidth', 1.2);
% bp_hon = [sum(ms_re_hon + ms_po_hon), sum(na_re_hon + na_po_hon)];
% bp_hwo = [sum(ms_re_hwo + ms_po_hwo), 0];
% 
% 
% h2 = bar([1.8, 2.2], [bp_hon;bp_hwo], 'stacked'); grid on; hold on;
% set(h2(2), 'FaceColor', [1,0,0]);
% set(h2, 'EdgeColor', 'k', 'LineWidth', 1.2);
% xlim([0,3]);
% 
%  set(gca,'fontWeight','bold','Xtick',1:1:2);
% %  set(gca, 'XTickLabel', {'Joystick', 'Headarray'});
% xlabel({'Disamb Manual Disamb Manual','Joystick HeadArray'})
%  ylabel('\bf \fontsize{11} Number of Button Presses');
 
 %% average of button presses
figure;
subplot(1,2,1);
bp_jon = [mean([ms_re_jon;ms_po_jon]), mean([na_re_jon;na_po_jon])];
bp_jwo = [mean([ms_re_jwo;ms_po_jwo]), 0];
dataL = [ms_re_jon+na_re_jon;ms_po_jon+na_po_jon]; 
dataR = [ms_re_jwo; ms_po_jwo];

h1 = bar([0.8, 1.2], [bp_jon;bp_jwo], 'stacked'); grid on; hold on;
errorbar([0.8, 1.2], [mean(dataL), mean(dataR)], [std(dataL)/sqrt(length(dataL)), std(dataR)/sqrt(length(dataR))], '.', 'LineWidth', 1.5, 'Color', 'k');
set(h1(2), 'FaceColor', [1,0,0]);
set(h1, 'EdgeColor', 'k', 'LineWidth', 1.2);


[p,h] = ranksum(dataL, dataR);
ypos = max(mean(dataL), mean(dataR)); yoffset = 1;
if p <= 0.05
        line([y1, y1], [ypos + yoffset, ypos+2*yoffset], 'LineWidth', 2.0);
        line([y2, y2], [ypos + yoffset, ypos+2*yoffset], 'LineWidth', 2.0);
        line([y1, y2], [ypos + 2*yoffset, ypos+2*yoffset], 'LineWidth', 2.0);
end
if p <= 0.001
    text(0.5*(y1+y2), ypos+2*yoffset, '***', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
elseif p <= 0.01
    text(0.5*(y1+y2), ypos+2*yoffset, '**', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
elseif p <= 0.05
    text(0.5*(y1+y2), ypos+2*yoffset, '*', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
end
%HEADARRAY
bp_hon = [mean([ms_re_hon; ms_po_hon]), mean([na_re_hon; na_po_hon])];
bp_hwo = [mean([ms_re_hwo; ms_po_hwo]), 0];
dataL = [ms_re_hon+na_re_hon;ms_po_hon+na_po_hon]; 
dataR = [ms_re_hwo; ms_po_hwo];

h2 = bar([1.8, 2.2], [bp_hon;bp_hwo], 'stacked'); grid on; hold on;
errorbar([1.8, 2.2], [mean(dataL), mean(dataR)], [std(dataL)/sqrt(length(dataL)), std(dataR)/sqrt(length(dataR))], '.', 'LineWidth', 1.5, 'Color', 'k');
set(h2(2), 'FaceColor', [1,0,0]);
set(h2, 'EdgeColor', 'k', 'LineWidth', 1.2);


[p,h] = ranksum(dataL, dataR);
ypos = max(mean(dataL), mean(dataR)); yoffset = 3;
y1 = 1.8; y2 = 2.2;
if p <= 0.05
        line([y1, y1], [ypos + 0.8*yoffset, ypos+1*yoffset], 'LineWidth', 2.0);
        line([y2, y2], [ypos + 0.8*yoffset, ypos+1*yoffset], 'LineWidth', 2.0);
        line([y1, y2], [ypos + 1*yoffset, ypos+1*yoffset], 'LineWidth', 2.0);
end
if p <= 0.001
    text(0.5*(y1+y2), ypos+1.2*yoffset, '***', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
elseif p <= 0.01
    text(0.5*(y1+y2), ypos+1.2*yoffset, '**', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
elseif p <= 0.05
    text(0.5*(y1+y2), ypos+1.2*yoffset, '*', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
end
xlim([0,3]);

 set(gca,'fontWeight','bold','Xtick',1:1:2);
%  set(gca, 'XTickLabel', {'Joystick', 'Headarray'});
xlabel({'Disamb Manual Disamb Manual','Joystick HeadArray'})
 ylabel('\bf \fontsize{11} Number of Button Presses');
 legend('Mode Switch','Assistance Request', 'Location', 'north');
 
 %%
 
 
 
 
 
 %% average of button presses by task
subplot(1,2,2);
bp_ron = [mean([ms_re_jon ; ms_re_hon]), mean([na_re_jon ;na_re_hon])];
bp_rwo = [mean([ms_re_jwo;ms_re_hwo]), 0];
dataL = [ms_re_jon+na_re_jon;ms_re_hon+na_re_hon]; 
dataR = [ms_re_jwo; ms_re_hwo];

h1 = bar([0.8, 1.2], [bp_ron;bp_rwo], 'stacked'); grid on; hold on;
errorbar([0.8, 1.2], [mean(dataL), mean(dataR)], [std(dataL)/sqrt(length(dataL)), std(dataR)/sqrt(length(dataR))], '.', 'LineWidth', 1.5, 'Color', 'k');
set(h1(2), 'FaceColor', [1,0,0]);
set(h1, 'EdgeColor', 'k', 'LineWidth', 1.2);
[p,h] = ranksum(dataL, dataR);
ypos = max(mean(dataL), mean(dataR)); yoffset = 1;
if p <= 0.05
        line([y1, y1], [ypos + yoffset, ypos+2*yoffset], 'LineWidth', 2.0);
        line([y2, y2], [ypos + yoffset, ypos+2*yoffset], 'LineWidth', 2.0);
        line([y1, y2], [ypos + 2*yoffset, ypos+2*yoffset], 'LineWidth', 2.0);
end
if p <= 0.001
    text(0.5*(y1+y2), ypos+2*yoffset, '***', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
elseif p <= 0.01
    text(0.5*(y1+y2), ypos+2*yoffset, '**', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
elseif p <= 0.05
    text(0.5*(y1+y2), ypos+2*yoffset, '*', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
end



bp_pon = [mean([ms_po_jon;ms_po_hon]), mean([na_po_jon; na_po_hon])];
bp_pwo = [mean([ms_po_jwo;ms_po_hwo]), 0];
dataL = [ms_po_jon+na_po_jon;ms_po_hon+na_po_hon]; 
dataR = [ms_po_jwo; ms_po_hwo];


h2 = bar([1.8, 2.2], [bp_pon;bp_pwo], 'stacked'); grid on; hold on;
errorbar([1.8, 2.2], [mean(dataL), mean(dataR)], [std(dataL)/sqrt(length(dataL)), std(dataR)/sqrt(length(dataR))], '.', 'LineWidth', 1.5, 'Color', 'k');

set(h2(2), 'FaceColor', [1,0,0]);
set(h2, 'EdgeColor', 'k', 'LineWidth', 1.2);

[p,h] = ranksum(dataL, dataR);
ypos = max(mean(dataL), mean(dataR)); yoffset = 3;
y1 = 1.8; y2 = 2.2;
if p <= 0.05
        line([y1, y1], [ypos + 0.8*yoffset, ypos+1*yoffset], 'LineWidth', 2.0);
        line([y2, y2], [ypos + 0.8*yoffset, ypos+1*yoffset], 'LineWidth', 2.0);
        line([y1, y2], [ypos + 1*yoffset, ypos+1*yoffset], 'LineWidth', 2.0);
end
if p <= 0.001
    text(0.5*(y1+y2), ypos+1.2*yoffset, '***', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
elseif p <= 0.01
    text(0.5*(y1+y2), ypos+1.2*yoffset, '**', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
elseif p <= 0.05
    text(0.5*(y1+y2), ypos+1.2*yoffset, '*', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
end
xlim([0,3]);

 set(gca,'fontWeight','bold','Xtick',1:1:2);
%  set(gca, 'XTickLabel', {'Joystick', 'Headarray'});
xlabel({'Disamb Manual Disamb Manual','SingleStep Multistep'})
 ylabel('\bf \fontsize{11} Number of Button Presses');
 legend('Mode Switch','Assistance Request', 'Location', 'north');
 