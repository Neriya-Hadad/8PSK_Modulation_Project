clc

%% General parameter definitions for all sections
A_c = 1;                 % Signal amplitude
f_c = 1e3;               % Carrier frequency [Hz]
T = 0.001;               % Symbol duration
theta_0 = 0;             % Initial phase
noise_variance = deg2rad(5); % Phase noise variance (radians)
SNRbit = 5;              % SNR in dB
sigma_w = deg2rad(5);    % Phase noise (radians)
t = 0:T:1;               % Time axis

%% Section A - Decision Feedback Loop (DFL) Model
% Clean signal
s_clean = A_c * cos(2 * pi * f_c * t + theta_0);  % Signal without noise

% Generate phase noise
noise = noise_variance * randn(1, length(t));

% Signal with phase noise
s_noisy = A_c * cos(2 * pi * f_c * t + theta_0 + noise);

% Decision Feedback Loop
theta_estimated = zeros(size(t));  % Initialize estimated phase
decision_feedback = 0;
for i = 2:length(t)
    % Feedback update
    error = noise(i) - decision_feedback;
    theta_estimated(i) = theta_estimated(i-1) + error;
    decision_feedback = decision_feedback + 0.1 * error;  % Adaptation rate
end

% Plots
figure;
subplot(2,1,1);
plot(t, noise, 'r', 'DisplayName', 'Phase Noise'); hold on;
plot(t, theta_estimated, 'b--', 'DisplayName', 'DFL Estimated Phase');
xlabel('Time [s]');
ylabel('Phase [rad]');
title('Decision Feedback Loop on Previous Decisions');
legend;

subplot(2,1,2);
plot(t, s_clean, 'r', 'DisplayName', 'Clean Signal'); hold on;
plot(t, s_noisy, 'b--', 'DisplayName', 'Signal with Noise');
xlabel('Time [s]');
ylabel('Amplitude');
title('Clean Signal vs. Signal with Phase Noise');
legend;

%% Section B - Generation of s_M(t)
A_k_I = 1;  % In-phase component
A_k_Q = 1;  % Quadrature component

% Create rectangular window g(t) for T
g = ones(size(t));  % Instead of rectpuls, use a window with value 1 for all time

% Generate s_M(t) signal
s_M = A_c * (A_k_I * g .* cos(2 * pi * f_c * t + theta_0) - ...
             A_k_Q * g .* sin(2 * pi * f_c * t + theta_0));

% Plot s_M(t)
figure;
plot(t, s_M);
xlabel('Time [s]');
ylabel('Amplitude');
title('Signal s_M(t)');

%% Section C - PLL System with Transfer Function
% Transfer function parameters
tau_z = 0.5;    % Zero time constant
K = 1;          % System gain
T_1 = 1;        % System time constant

% PLL transfer function
s = tf('s');
H_s = (1 + tau_z * s) / (1 + (tau_z + 1) / K * s + T_1 / K * s^2);

% Step response plot
figure;
step(H_s);
title('Step Response of PLL');

%% Section D - DFL system with phase noise and estimated phase (already handled in Section A)

%% Section E - MATLAB Simulation with Phase Noise, SNRbit = 5
% Signal with phase noise
noise = sigma_w * randn(1, length(t));
s_noisy = A_c * cos(2 * pi * f_c * t + noise);

% PLL model
theta_hat = zeros(size(t));
for i = 2:length(t)
    theta_hat(i) = theta_hat(i-1) + (noise(i) - noise(i-1));
end

% Corrected plot #2 - Ensure match between time and carrier frequency
figure;
subplot(2,1,1);
plot(t, noise, 'r', 'DisplayName', 'Phase Noise'); hold on;
plot(t, theta_hat, 'b--', 'DisplayName', 'Estimated Phase');
xlabel('Time [s]');
ylabel('Phase [rad]');
title('Estimated Phase vs. Phase Noise');
legend;

subplot(2,1,2);
plot(t, s_noisy, 'r', 'DisplayName', 'Signal with Phase Noise'); hold on;
plot(t, A_c * cos(2 * pi * f_c * t), 'b--', 'DisplayName', 'Clean Signal');
xlabel('Time [s]');
ylabel('Amplitude');
title('Signal with Phase Noise vs. Clean Signal');
legend;
