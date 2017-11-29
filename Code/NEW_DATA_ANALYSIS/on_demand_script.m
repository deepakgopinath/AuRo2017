plotting_script_time_new;
interfaces = {'j', 'h'};
interfaces_cell = {'na_po_jon','na_re_jon', 'na_po_hon', 'na_re_hon';
                    'na_po_jon', 'na_po_hon', 'na_re_jon','na_re_hon'};
                
ylims = [2.5, 2.5];
y1 = 1.0; y2 = 2.0;

figure;
for kk=1:2
    v1 = eval(interfaces_cell{kk,1}); 
    v2 = eval(interfaces_cell{kk,3}); 
    v3 = eval(interfaces_cell{kk,2}); 
    v4 = eval(interfaces_cell{kk,4}); 
    v1 = [v1;v3];
    v2 = [v2;v4];
    if kk == 1
        subplot(1,2,1); hold on; grid on;
    else
        subplot(1,2,2); hold on; grid on;
    end
    if kk==1
%         bh3 = boxplot([v1,v2], 'whisker', 200);
%         set(bh3(:,2),'linewidth',2);
        
        bh5 = boxplot(v1, 'positions', y1, 'whisker', 200,'Widths', 0.3);set(bh5(:,1),'linewidth',2);
        bh6 = boxplot(v2, 'positions', y2,'whisker', 200,'Widths', 0.3);set(bh6(:,1),'linewidth',2);
    else
%         v1(v1 == 0) = [];
%         v1 = [v1;median(v1)];
        bh7 = boxplot(v1, 'positions', y1,'whisker', 200,'Widths', 0.3);set(bh7(:,1),'linewidth',2);
        bh8 = boxplot(v2, 'positions', y2,'whisker', 200,'Widths', 0.3);set(bh8(:,1),'linewidth',2);
    end
%     
%     scatter(y1*ones(length(v1),1), v1, 'o', 'k', 'LineWidth', 1.5);
%     scatter(y2*ones(length(v2),1), v2, 'o', 'r', 'LineWidth', 1.5);
%     scatter(2.8*ones(length(v3),1), v3, 'o', 'r', 'LineWidth', 1.5);
%     scatter(3.2*ones(length(v4),1), v4, 'o', 'k', 'LineWidth', 1.5);
%     scatter(y1, median(v1), 100, 'X', 'b', 'LineWidth',4.5);
%     scatter(y2, median(v2), 100, 'X', 'b', 'LineWidth',4.5);
    axis([0,3,0,ylims(kk)]);
    if kk == 1
        set(gca, 'fontWeight', 'normal', 'YTick', 0:0.4:ylims(kk));
        ylabel('\bf \fontsize{10} Assistance Request/Mode Switch');
    else
        set(gca,  'fontWeight', 'normal', 'YTick', 0:0.4:ylims(kk));
    end
%     set(gca, 'XTick', 1:1:2);
    set(gca,'fontWeight','bold','Xtick',1:1:2);
    if kk == 1
        set(gca, 'XTickLabel', {'Joystick', 'Headarray'});
    else
        set(gca, 'XTickLabel', {'MultiStep', 'SingleStep'});
    end
    [p,h] = ranksum(v1, v2);
    ypos = max(max(v1), max(v2)); yoffset = 0.05;
    if p <= 0.05
        line([y1, y1], [ypos + yoffset, ypos+2*yoffset], 'LineWidth', 2.0);
        line([y2, y2], [ypos + yoffset, ypos+2*yoffset], 'LineWidth', 2.0);
        line([y1, y2], [ypos + 2*yoffset, ypos+2*yoffset], 'LineWidth', 2.0);
    end
    if p <= 0.001
        text(0.5*(y1+y2), ypos+3*yoffset, '***', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
    elseif p <= 0.01
        text(0.5*(y1+y2), ypos+3*yoffset, '**', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
    elseif p <= 0.05
        text(0.5*(y1+y2), ypos+3*yoffset, '*', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
    end
    
end