function T = tfresp(tfun)
    [y, t] = step(tfun);
    
    y_final = y(end);
    dy = diff(y) ./ diff(t);
    [max_slope, idx] = max(dy);
    
    Tu = t(idx) - y(idx) / max_slope;
    Tn = (y_final * 0.066 - y(idx)) / max_slope + t(idx);
    
    % figure;
    % plot(t, y, 'b', 'LineWidth', 2); hold on;
    % plot([Tu Tu], [0 y(idx)], 'k--', 'LineWidth', 1.5);
    % plot([Tn Tn], [0 y_final*0.63], 'k--', 'LineWidth', 1.5);
    % 
    % tangent_line = y(idx) + max_slope * (t - t(idx));
    % plot(t, tangent_line, 'LineWidth', 2, Color=[1 0.5 0.5], LineStyle='--');
    % 
    % xlabel('t');
    % ylabel('y(t)');
    % title('Prechodová charakteristika elektrickej pece');
    % legend('Step Response', 'T_u', 'T_n', 'Tangent Line', 'Location', 'Southeast');
    % 
    % ylim([0 max(y) + 0.1 * max(y)]);
    % xlim([0 t(end)]);

    T.n = Tn;
    T.u = Tu;
end