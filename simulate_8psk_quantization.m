% Parameter definition
M = 8; % 8PSK modulation: 8 possible symbol levels
NQ = 64; % Number of quantization levels
N_bits_required = log2(M) * 10000; % Total number of bits required

% Calculate number of samples needed
N_samples = N_bits_required / log2(NQ);

% Generate a continuous random signal
signal_continuous = randn(1, N_samples);

% Quantize the continuous signal
quantizer_levels = linspace(min(signal_continuous), max(signal_continuous), NQ);
[~, quantized_signal] = min(abs(signal_continuous' - quantizer_levels), [], 2);
quantized_signal = quantized_signal - 1; % Indices start from 0

% Convert quantized values to binary data
binary_data = de2bi(quantized_signal, log2(NQ), 'left-msb');
binary_data = binary_data(:)'; % Convert matrix to vector

% Count number of 0s and 1s in the bitstream
bit_count = [sum(binary_data == 0), sum(binary_data == 1)];

% Display bar graph: X-axis = bit value, Y-axis = number of occurrences
figure;
bar([0 1], bit_count);
title('Frequency of 0s and 1s in Binary Data');
xlabel('Bit Value');
ylabel('Frequency');
grid on;
