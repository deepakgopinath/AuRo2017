interfaces = {'j', 'h'};
interfaces_cell = {'al_po_jon','al_po_jwo','al_re_jon','al_re_jwo';
                    'al_po_hon','al_po_hwo','al_re_hon','al_re_hwo';
                    'al_re_hon','al_re_hwo','al_re_jon','al_re_jwo';
                    'al_po_hon','al_po_hwo','al_po_jon','al_po_jwo'};

ylims = [1,1,1,1];
y1 = 1.0; y2 = 2.0;

for kk=1:4
    
    %kk=1 joystick kk=2 = headarray kk=3, reaching, kk=4 pouring
    v1 = eval(interfaces_cell{kk,2}); %
    v2 = eval(interfaces_cell{kk,1}); %Dismab RsG
    v3 = eval(interfaces_cell{kk,4}); %Manual RdG
    v4 = eval(interfaces_cell{kk,3}); %Disamb RdG
    
    v1 = [v1;v3];
    v2 = [v2;v4];
    if kk == 1
        subplot(1,2,1); hold on; grid on;
    end
    if kk == 3
        subplot(1,2,2); hold on; grid on;
    end
      
    y1 = 0.8; y2 = 1.2; y3 = 1.8; y4 = 2.2;
    if kk == 1
        bh1 = boxplot(v1, 'positions', y1,'whisker', 50,'Widths', 0.3);set(bh1(:,1),'linewidth',2);
        bh2 = boxplot(v2, 'positions', y2,'whisker', 50,'Widths', 0.3);set(bh2(:,1),'linewidth',2);
    end
    if kk == 2
        bh3 = boxplot(v1, 'positions', y3,'whisker', 50,'Widths', 0.3);set(bh3(:,1),'linewidth',2);
        bh4 = boxplot(v2, 'positions', y4,'whisker', 50,'Widths', 0.3);set(bh4(:,1),'linewidth',2);
    end
    if kk == 3
        bh5 = boxplot(v1, 'positions', y1,'whisker', 50,'Widths', 0.3);set(bh5(:,1),'linewidth',2);
        bh6 = boxplot(v2, 'positions', y2,'whisker', 50,'Widths', 0.3);set(bh6(:,1),'linewidth',2);
    end
    if kk == 4
        bh7 = boxplot(v1, 'positions', y3,'whisker', 50,'Widths', 0.3);set(bh7(:,1),'linewidth',2);
        bh8 = boxplot(v2, 'positions', y4,'whisker', 50,'Widths', 0.3);set(bh8(:,1),'linewidth',2);
    end
    
   
    axis([0,3,0,ylims(kk)]);
    [p,h] = ranksum(v1, v2);
    ypos = max(max(v1), max(v2)); yoffset = 0.05;
    if kk == 1 || kk == 3
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
    if kk == 2 ||kk == 4
        if p <= 0.05
            line([y3, y3], [ypos + yoffset, ypos+2*yoffset], 'LineWidth', 2.0);
            line([y4, y4], [ypos + yoffset, ypos+2*yoffset], 'LineWidth', 2.0);
            line([y3, y4], [ypos + 2*yoffset, ypos+2*yoffset], 'LineWidth', 2.0);
        end
        if p <= 0.001
            text(0.5*(y3+y4), ypos+3*yoffset, '***', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
        elseif p <= 0.01
            text(0.5*(y3+y4), ypos+3*yoffset, '**', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
        elseif p <= 0.05
            text(0.5*(y3+y4), ypos+3*yoffset, '*', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
        end
    end
end
%%
% for kk=1:length(interfaces)
%     v1 = eval(interfaces_cell{kk,2}); %
%     v2 = eval(interfaces_cell{kk,1}); %Dismab RsG
%     v3 = eval(interfaces_cell{kk,4}); %Manual RdG
%     v4 = eval(interfaces_cell{kk,3}); %Disamb RdG
%     v1 = [v1;v3];
%     v2 = [v2;v4];
%     if kk == 1
%         subplot(2,2,1); hold on; grid on;
%     else
%         subplot(2,2,2); hold on; grid on;
%     end
%     
%     if kk==1
% %     bh1 = boxplot([v1,v2], 'whisker', 50);
%         bh1 = boxplot(v1, 'positions', y1,'whisker', 50,'Widths', 0.3);set(bh1(:,1),'linewidth',2);
%         bh2 = boxplot(v2, 'positions', y2,'whisker', 50,'Widths', 0.3);set(bh2(:,1),'linewidth',2);
%     else
%         bh3 = boxplot(v1, 'positions', y1,'whisker', 50,'Widths', 0.3);set(bh3(:,1),'linewidth',2);
%         bh4 = boxplot(v2, 'positions', y2,'whisker', 50,'Widths', 0.3);set(bh4(:,1),'linewidth',2);
%     end
%     
%     [p,h] = ranksum(v1, v2);
%     ypos = max(max(v1), max(v2)); yoffset = 0.2;
%     if p <= 0.05
%         line([y1, y1], [ypos + yoffset, ypos+2*yoffset], 'LineWidth', 2.0);
%         line([y2, y2], [ypos + yoffset, ypos+2*yoffset], 'LineWidth', 2.0);
%         line([y1, y2], [ypos + 2*yoffset, ypos+2*yoffset], 'LineWidth', 2.0);
%     end
%     if p <= 0.001
%         text(0.5*(y1+y2), ypos+3*yoffset, '***', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
%     elseif p <= 0.01
%         text(0.5*(y1+y2), ypos+3*yoffset, '**', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
%     elseif p <= 0.05
%         text(0.5*(y1+y2), ypos+3*yoffset, '*', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
%     end
%     
% %     
% %     
% %     %Dismabiguation data points
% %     uvals = unique(v1);
% %     distri = zeros(length(uvals),1);
% %     for i=1:length(uvals)
% %         distri(i) = sum(v1 == uvals(i));
% %     end
% % 
% % %     for i=1:length(v1)
% % %         if distri(uvals == v1(i)) > 1
% % %             scatter(y1, v1(i),'o','k', 'LineWidth', 1.5, 'jitter', 'on', 'jitterAmount', jit_factor(kk)*(distri(uvals == v1(i)) - 1));
% % %         else
% % %             scatter(y1, v1(i),'o','k', 'LineWidth', 1.5);
% % %         end
% % %     end
% %     alphalist = distri/max(distri);
% % %     alphalist(alphalist < 0.3) = 0.3;
% % %     for i=1:length(v1)
% % %         scatter(y1, v1(i), 'o', 'k', 'LineWidth', 1.5, 'MarkerEdgeAlpha', );
% % %     end
% %     for i=1:length(uvals)
% %         scatter(y1, uvals(i), 'o', 'k', 'LineWidth', 1.5, 'MarkerEdgeAlpha', alphalist(i));
% %     end
% %     
% %     %Manual Data points
% %     uvals = unique(v2);
% %     distri = zeros(length(uvals),1);
% %     for i=1:length(uvals)
% %         distri(i) = sum(v2 == uvals(i));
% %     end
% % 
% % %     for i=1:length(v2)
% % %         if distri(uvals == v2(i)) > 1
% % %             scatter(y2, v2(i),'o','r', 'LineWidth', 1.5, 'jitter', 'on', 'jitterAmount', jit_factor(kk)*(distri(uvals == v2(i)) - 1));
% % %             hold on;
% % %         else
% % %             scatter(y2, v2(i),'o','r', 'LineWidth', 1.5);
% % %         end
% % %     end
% %     alphalist = distri/max(distri);
% %     for i=1:length(uvals)
% %         scatter(y2, uvals(i), 'o', 'r', 'LineWidth', 1.5, 'MarkerEdgeAlpha', alphalist(i));
% %     end
% %     scatter(y1, median(v1), 100, 'X', 'b', 'LineWidth',4.5);
% %     scatter(y2, median(v2), 100, 'X', 'b', 'LineWidth',4.5);
% %     
%     axis([0,3,-1,ylims(kk)]);
%     grid on;
%     
%     if kk == 1
%         set(gca,  'fontWeight', 'normal', 'YTick', 0:10:ylims(kk));
%         title('\bf \fontsize{16} Joystick  ');
%         set(gca,'fontWeight','bold','Xtick',1:1:2);
% %         set(gca,'DefaultTextInterpreter', 'tex')
%         set(gca, 'XTickLabel', {'Manual','Disamb'});
%         ylabel('\bf \fontsize{11} Number of Mode Switches');
%     else
%         set(gca, 'fontWeight', 'normal',  'YTick', 0:10:ylims(kk));
%         title('\bf \fontsize{16} Headarray');
% %         set(gca,'DefaultTextInterpreter', 'tex')
%         set(gca,'fontWeight','bold','Xtick',1:1:2);
%         set(gca, 'XTickLabel', {'Manual','Disamb'});
%     end
%     
%     [p,h] = ranksum(v1, v2);
%     ypos = max(max(v1), max(v2)); yoffset = 0.2;
%     if p <= 0.05
%         line([y1, y1], [ypos + yoffset, ypos+2*yoffset], 'LineWidth', 2.0);
%         line([y2, y2], [ypos + yoffset, ypos+2*yoffset], 'LineWidth', 2.0);
%         line([y1, y2], [ypos + 2*yoffset, ypos+2*yoffset], 'LineWidth', 2.0);
%     end
%     if p <= 0.001
%         text(0.5*(y1+y2), ypos+3*yoffset, '***', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
%     elseif p <= 0.01
%         text(0.5*(y1+y2), ypos+3*yoffset, '**', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
%     elseif p <= 0.05
%         text(0.5*(y1+y2), ypos+3*yoffset, '*', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
%     end
% end
