function [] = custom_plot2(t,y,w,u,e,t1,y1,u1,e1,method,u_range,e_range,y_range,name_graf1,name_graf2)
    figure;
    
    subplot(3,1,1);
    plot(t, y, 'g', 'LineWidth', 4); hold on;
    plot(t, w, 'r', 'LineWidth', 1.5);
    plot(t1, y1, 'b', 'LineWidth', 2); hold off;
    if exist('y_range','var') && ~isempty(y_range)
        ylim(y_range);
    else
        ylim([0,60]);
    end
    ylabel('y(t)');
    title('System output y(t)');
    legend(["y(t) "+name_graf1, "w(t)", "y(t) "+name_graf2])
    grid on;
    
    % Plot u(t)
    subplot(3,1,2);
    plot(t, u, 'g', 'LineWidth', 2); hold on;
    plot(t1, u1, 'r--', 'LineWidth', 2);hold off;
    if exist('u_range','var') && ~isempty(u_range)
        ylim(u_range);
    end
    ylabel('u(t)');
    legend(["u(t) "+name_graf1, "u(t) "+name_graf2]);
    title('System input u(t)');
    grid on;
    
    % Plot e(t)
    subplot(3,1,3);
    plot(t, e, 'Color', [1 0.5 0], 'LineWidth', 2); hold on;
    plot(t1, e1, 'Color', 'y', 'LineWidth', 2);hold off;
    if exist('e_range','var') && ~isempty(e_range)
        ylim(e_range);
    else
        ylim([-50,50]);
    end
    ylabel('e(t)');
    legend(["e(t) "+name_graf1, "e(t) "+name_graf2]);
    xlabel('t');
    title('e(t)');
    grid on;
    
    sgtitle(method + ' method');
end