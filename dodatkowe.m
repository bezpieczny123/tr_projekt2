function [kp_opt, ki_opt, IAE_min] = tunePI
    G = tf(2, conv(conv([1 2],[1 3]), [1 -1]));
    t = linspace(0, 100, 1001);
    obj = @(p) iaeCost(p, G, t);
    init = [4, 0.1];
    options = optimset('Display','iter');
    [opt, IAE_min] = fminsearch(obj, init, options);
    kp_opt = opt(1);
    ki_opt = opt(2);
    fprintf('Optimal kp = %.4f\n', kp_opt);
    fprintf('Optimal ki = %.4f\n', ki_opt);
    fprintf('Minimum IAE = %.4f\n', IAE_min);
end

function iae = iaeCost(p, G, t)
    kp = p(1); 
    ki = p(2);
    C = tf([kp, ki], [1, 0]);
    sys_cl = feedback(C*G, 1);
    r = 10*(t>=1);
    y = lsim(sys_cl, r, t)';
    e = r - y;
    iae = trapz(t, abs(e));
end
