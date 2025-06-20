A_c = sqrt(20);                 % Carrier amplitude
T_s = 2.4e-3;                   % Symbol period
f_c = 20e3;                     % Carrier frequency (20 kHz)
f = linspace(-50e3, 50e3, 1000);% Frequency range for plotting

% Calculate the spectrum S_M(f)
sinc_func = @(x) sinc(x / pi);  % Define normalized sinc function
S_M_f = (A_c^2 * T_s / 4) .* ...
    (sinc_func(pi * T_s * (f - f_c)).^2 + sinc_func(pi * T_s * (f + f_c)).^2);

% Plot the spectrum
figure;
plot(f, S_M_f);
title('$S_M(f)$ Spectrum for $f_c = 20$ kHz', 'Interpreter', 'latex');
xlabel('Frequency (Hz)');
ylabel('$S_M(f)$', 'Interpreter', 'latex');
ylim([0 0.0008]);         % Limit Y-axis between 0 and 0.0008
grid on;
