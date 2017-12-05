%% RUN prase_data.m BEFORE. THIS SCRIPT IS USED TO PLOT THE INITIAL BLEND AND THE TOTAL PERCETANGE ASSISTANCE PLOTS. 
%% PAY CLOSE ATTENTION TO HOW V1,V2,V3,V4 ARE BEING ASSIGNED. EACH ROW OF interfaces_cell IS FOR GROUPING WITH RESPECT TO INTERFACES AND GROUPING WITH RESEPCT TO TASK.
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
      
    y1 = 0.8; y2 = 1.2; y3 = 1.8; y4 = 2.2; % locations at which the box plots should be plotes
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
    
    %compute significance. 
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