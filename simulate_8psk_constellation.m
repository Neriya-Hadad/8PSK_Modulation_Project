% Parameters setup
M = 8;                      % Number of 8PSK symbols (modulation order)
num_symbols = 1000;         % Number of symbols to simulate
SNR_dBs = 10;               % SNR in dB for noise addition
phase_offset_deg = 5;       % Phase offset in degrees
phase_offset_rad = deg2rad(phase_offset_deg); % Convert phase offset to radians
scale_factor = 1e-3;        % Scaling factor to fit the constellation within axis limits

% Carrier and sampling settings
fc = 1e3;                   % Carrier frequency (1 kHz)
fs = 1e4;                   % Sampling frequency (10 times the carrier frequency)
t = (0:num_symbols-1) / fs; % Time vector for symbol simulation

% Generate ideal 8PSK constellation points (including phase offset and scaling)
constellation_points = scale_factor * exp(1i * ((0:M-1) * 2*pi/M + phase_offset_rad)); 

% SNR and noise setup
SNR = 10^(SNR_dBs / 10);                % Convert SNR from dB to linear scale
noise_var = 1 / (2 * SNR);              % Calculate noise variance (assuming unit energy per symbol)

% Generate random transmitted data
data = randi([0 M-1], 1, num_symbols);  % Random symbol indices

% Map symbols to constellation points
tx_signal = constellation_points(data + 1); % Transmitted ideal symbols

% Create modulated I/Q signals for each symbol
I_mod = real(tx_signal) .* cos(2*pi*fc*t); % In-phase (I) component
Q_mod = imag(tx_signal) .* sin(2*pi*fc*t); % Quadrature (Q) component

% Combine I/Q for overall modulated signal
tx_modulated_signal = I_mod + Q_mod;    % Complete transmitted waveform

% Add Gaussian noise to each symbol (AWGN)
noise = sqrt(noise_var) * scale_factor * (randn(1, num_symbols) + 1i * randn(1, num_symbols));

% Simulate received signal (after noise)
rx_signal = tx_signal + noise;

% Plot the noisy received constellation vs. the ideal points
figure;
scatter(real(rx_signal), imag(rx_signal), 'r+');                        % Noisy received symbols
hold on;
scatter(real(constellation_points), imag(constellation_points), 'go', 'LineWidth', 2); % Ideal constellation
title(sprintf('8PSK Constellation with Phase Offset of %d Degrees and SNR = %d dB', phase_offset_deg, SNR_dBs));
xlabel('In-Phase (I)');
ylabel('Quadrature (Q)');

% Adjust plot to focus on relevant area (tight axis)
axis equal;
xlim([-0.0025 0.0025]);
ylim([-0.0025 0.0025]);
grid on;
legend('Received Signal with Noise', 'Ideal 8PSK Constellation Points');
