function [] = custom_plot(t,y,w,u,e,method,u_range,e_range,y_range)
    figure;
    
    subplot(3,1,1);
    plot(t, y, 'g', 'LineWidth', 2); hold on;
    plot(t, w, 'r', 'LineWidth', 1.5);
    if exist('y_range','var') && ~isempty(y_range)
        ylim(y_range);
    else
        ylim([0,60]);
    end
    ylabel('y(t)');
    title('System output y(t)');
    legend(["y(t)", "w(t)"], "Position", [0.7681 0.7866 0.1214, 0.0631]);
    grid on;
    
    % Plot u(t)
    subplot(3,1,2);
    plot(t, u, 'p', 'LineWidth', 2);
    if exist('u_range','var') && ~isempty(u_range)
        ylim(u_range);
    end
    ylabel('u(t)');
    title('System input u(t)');
    grid on;
    
    % Plot e(t)
    subplot(3,1,3);
    plot(t, e, 'Color', [1 0.5 0], 'LineWidth', 2);
    if exist('e_range','var') && ~isempty(e_range)
        ylim(e_range);
    else
        ylim([-50,50]);
    end
    ylabel('e(t)');
    xlabel('t');
    title('e(t)');
    grid on;
    
    sgtitle(method + ' method');
end

