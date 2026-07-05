function [t, out] = pwm(low, high, frequency, total_time, sample_time, noise_std)
    t = 0:sample_time:total_time;
    pwm_signal = square(2*pi*frequency*t);

    pwm_signal = (pwm_signal + 1)/2;
    pwm_signal = pwm_signal * (high - low) + low;

    noise = noise_std * randn(size(pwm_signal));
    out = (pwm_signal + noise)';
end