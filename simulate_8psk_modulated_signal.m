% Basic parameters
Ac = sqrt(20);                   % Carrier amplitude
fc = 20000;                      % Carrier frequency (Hz)
omega_c = 2 * pi * fc;           % Angular frequency
theta_0 = 0;                     % Initial carrier phase
symbol_duration = 0.0001;        % Duration of each symbol (10 kHz symbol rate)
t = 0.0008:0.000001:0.0017;      % Time vector (1 microsecond sampling)

% Gray code mapping
gray_codes = ["000", "001", "011", "010", "110", "111", "101", "100"];

% Complex values for 8PSK
complex_symbols = [1 + 1j*0, ...
                   sqrt(2)/2 + 1j*sqrt(2)/2, ...
                   0 + 1j*1, ...
                   -sqrt(2)/2 + 1j*sqrt(2)/2, ...
                   -1 + 1j*0, ...
                   -sqrt(2)/2 - 1j*sqrt(2)/2, ...
                   0 - 1j*1, ...
                   sqrt(2)/2 - 1j*sqrt(2)/2];

% Predefined symbol sequence (corresponds to indices in gray_codes)
symbol_sequence = [1, 3, 5, 7, 2, 4, 6, 8];

% Generate the modulated signal
s_M_t = zeros(1, length(t));

for i = 1:length(t)
    % Determine current symbol based on time index
    symbol_index = symbol_sequence(ceil(i / (length(t)/length(symbol_sequence))));
    
    % a_n and b_n for the current symbol
    an = real(complex_symbols(symbol_index));
    bn = imag(complex_symbols(symbol_index));
    
    % Calculate s_M(t)
    s_M_t(i) = an * Ac * cos(omega_c * t(i) + theta_0) - bn * Ac * sin(omega_c * t(i) + theta_0);
end

% Plot the modulated signal
plot(t, s_M_t);
title('s_M(t) Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
