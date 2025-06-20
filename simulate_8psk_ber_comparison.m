% Parameters
M = 8;                           % Number of 8PSK symbols
num_symbols = 1e6;               % Large number of symbols for accurate simulation
SNR_dBs = linspace(0, 12, 8);    % 8 SNR values between 0dB and 12dB
k = log2(M);                     % Number of bits per symbol

% Generate ideal 8PSK constellation points
constellation_points = exp(1i * (0:M-1) * 2*pi/M);

% Preallocate BER result arrays
BER_simulated = zeros(1, length(SNR_dBs));
BER_theoretical = zeros(1, length(SNR_dBs));

% Loop through SNR values
for snr_idx = 1:length(SNR_dBs)
    SNR_dB = SNR_dBs(snr_idx);
    SNR = 10^(SNR_dB / 10);                  % Convert SNR from dB to linear scale
    noise_var = 1 / (2 * SNR);               % Noise variance for each SNR

    % Generate random data symbols
    data = randi([0 M-1], 1, num_symbols);

    % Map data symbols to constellation points
    tx_signal = constellation_points(data + 1);

    % Add AWGN (complex Gaussian noise)
    noise = sqrt(noise_var) * (randn(1, num_symbols) + 1i * randn(1, num_symbols));

    % Received signal after noise
    rx_signal = tx_signal + noise;

    % Demodulate: Find closest constellation point to each received symbol
    [~, demod_data] = min(abs(rx_signal.' - constellation_points), [], 2);
    demod_data = demod_data.' - 1; % Indices back to 0-based

    % Count bit errors (comparing transmitted and demodulated symbols)
    num_errors = sum(de2bi(data, k) ~= de2bi(demod_data, k), 'all');

    % Calculate simulated BER for this SNR
    BER_simulated(snr_idx) = num_errors / (num_symbols * k);

    % Theoretical BER (union bound approximation)
    BER_theoretical(snr_idx) = 2 * qfunc(sqrt(2 * SNR) * sin(pi/M));
end

% Plot Simulated and Theoretical BER vs. SNR
figure;
semilogy(SNR_dBs, BER_theoretical, 'r-o', 'LineWidth', 2);
hold on;
semilogy(SNR_dBs, BER_simulated, 'b--s', 'LineWidth', 2);
title('BER vs SNR for 8PSK with Full Synchronization');
xlabel('SNR (dB)');
ylabel('Bit Error Rate (BER)');
grid on;
xlim([0 12]);
legend('Theoretical', 'Simulated');

% Display results in command window
disp('BER simulated values:');
disp(BER_simulated);
