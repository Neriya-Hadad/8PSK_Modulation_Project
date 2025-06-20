% Parameters
M = 8;                            % Number of 8PSK symbols
num_symbols = 1000;               % Number of symbols to simulate
SNR_dBs = 0:2:6;                  % SNR values from 0 dB to 6 dB in 2 dB steps
scale_factor = 1e-3;              % Scale factor to fit constellation within axis limits

% Generate 8PSK constellation points (scaled)
constellation_points = scale_factor * exp(1i * (0:M-1) * 2*pi/M);

% Loop through SNR values
for snr_idx = 1:length(SNR_dBs)
    SNR_dB = SNR_dBs(snr_idx);
    SNR = 10^(SNR_dB / 10);                       % Convert SNR from dB to linear
    noise_var = 1 / (2 * SNR);                    % Noise variance

    % Generate random data symbols
    data = randi([0 M-1], 1, num_symbols);

    % Map symbols to constellation points
    tx_signal = constellation_points(data + 1);

    % Add complex Gaussian noise (AWGN)
    noise = sqrt(noise_var) * scale_factor * ...
            (randn(1, num_symbols) + 1i * randn(1, num_symbols));

    % Received signal after noise
    rx_signal = tx_signal + noise;

    % Plot constellation at the receiver
    figure;
    scatter(real(rx_signal), imag(rx_signal), 'r+');    % Noisy received symbols
    hold on;
    scatter(real(constellation_points), imag(constellation_points), 'go', 'LineWidth', 2); % Ideal points
    title(sprintf('8PSK Constellation at Receiver with %d dB SNR', SNR_dB));
    xlabel('In-Phase (I)');
    ylabel('Quadrature (Q)');

    % Focus on region near origin (where noise spreads symbols)
    axis equal;
    xlim([-0.0025 0.0025]);
    ylim([-0.0025 0.0025]);
    grid on;
    legend('Received Signal with Noise', 'Ideal 8PSK Constellation Points');
end
