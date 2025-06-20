% MATLAB Code to plot Symbol Error Rate (SER) and Bit Error Rate (BER) vs Es/N0 for 8-PSK

% Define the SNR range (in dB and linear scale)
SNRdB = 0:0.1:12;               % SNR values in dB
SNR = 10.^(SNRdB/10);           % Convert SNR from dB to linear scale

% Calculate the Symbol Error Rate (SER) for 8-PSK
M = 8;                          % Number of 8-PSK symbols
k = log2(M);                    % Number of bits per symbol
SER = 2 * qfunc(sqrt(2*SNR) * sin(pi/M));   % Theoretical SER for 8-PSK

% Calculate the Bit Error Rate (BER) for 8-PSK
BER = SER / k;                  % For 8-PSK, BER is approximated as SER divided by k

% Plot SER and BER curves on a semilog-y scale
figure;
semilogy(SNRdB, SER, 'b', 'LineWidth', 1.5);   % SER curve
hold on;
semilogy(SNRdB, BER, 'r', 'LineWidth', 1.5);   % BER curve
grid on;
title('SER and BER vs Es/N0 (dB) for 8-PSK');
xlabel('\gamma_d [dB]');
ylabel('Error Probability');
legend('SER', 'BER');
axis([0 12 1e-4 1]);
