function T = tfresp(tfun)
    [y, t] = step(tfun);
    y_final = y(end);
    dy = diff(y) ./ diff(t);
    [max_slope, idx] = max(dy);
    
    Tu = t(idx) - y(idx) / max_slope;
    Tn = (y_final * 0.55 - y(idx)) / max_slope + t(idx);

    T.n = Tn;
    T.u = Tu;
end