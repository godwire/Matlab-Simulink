function [] = custom_plot3(k, w, y, u, e, method, u_range, e_range, y_range)

    figure;

    % Plot reference and output
    subplot(3,1,1);
    stairs(k, y, 'r-', 'LineWidth', 2);
    hold on;
    stairs(k, w, 'g-', 'LineWidth', 2);
    if exist('y_range','var') && ~isempty(y_range)
        ylim(y_range);
    end
    ylabel('y(k)');
    legend(["y(k)", "w(k)"]);
    title('Response');
    grid on;

    % Plot control action
    subplot(3,1,2);
    stairs(k, u, 'b-', 'LineWidth', 2);
    if exist('u_range','var') && ~isempty(u_range)
        ylim(u_range);
    end
    ylabel('u(k)');
    title('Control action');
    grid on;

    % Plot error
    subplot(3,1,3);
    stairs(k, e, 'Color', [1 0.5 0], 'LineWidth', 2);
    if exist('e_range','var') && ~isempty(e_range)
        ylim(e_range);
    end
    ylabel('e(k)');
    xlabel('k');
    title('Tracking chyba');
    grid on;

    sgtitle(method, 'FontWeight', 'Bold');
end
