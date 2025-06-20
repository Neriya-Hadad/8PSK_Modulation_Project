clc

% Given parameters
p_error = 1e-2;      % Desired Bit Error Rate (BER)
theta = pi / 4;      % Phase offset (radians) for unsynchronized case
M = 8;               % Number of PSK symbols (8PSK)

% Define a function to calculate BER for PSK modulation
ber_psk = @(SNR) qfunc(sqrt(2 * SNR));

% Calculate the SNR required for the target BER in the ideal (synchronized) case
SNR_ideal = fzero(@(SNR) ber_psk(SNR) - p_error, 10);   % Find SNR such that BER = p_error

% Calculate SNR required in the unsynchronized (phase-offset) case
SNR_unsynced = SNR_ideal / cos(theta)^2;

% Calculate the power penalty in dB due to lack of synchronization
power_penalty_dB = 10 * log10(SNR_unsynced / SNR_ideal);

% Display the results
fprintf('SNR required in the ideal case: %.2f dB\n', 10 * log10(SNR_ideal));
fprintf('SNR required in the unsynchronized case: %.2f dB\n', 10 * log10(SNR_unsynced));
fprintf('Power penalty due to unsynchronization: %.2f dB\n', power_penalty_dB);
