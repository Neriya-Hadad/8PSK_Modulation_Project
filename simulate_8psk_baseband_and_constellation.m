% Database of bit combinations for 8-PSK
Database = {"000","001","011","010","110","111","101","100"};

% Phase angles and corresponding complex values for 8-PSK
phase_angles = [0, pi/4, pi/2, 3*pi/4, 5*pi/4, pi, 7*pi/4, 3*pi/2];
complex_symbols = exp(1j * phase_angles);  % Complex values for each phase

% Create In-Phase and Quadrature vectors
in_phase = real(complex_symbols);
quadrature = imag(complex_symbols);

% Define time axis for each symbol
symbol_time = 1/2400;  % Symbol time (e.g., 0.3ms)
t = linspace(0, length(Database) * symbol_time, length(Database)+1);

% Generate the signals
in_phase_signal = repelem(in_phase, 1, 1);       % Repeat each value over symbol time
quadrature_signal = repelem(quadrature, 1, 1);

Ts = symbol_time; % Symbol duration
rect_filter = (1.4e-3) * ones(1, round(Ts * length(t) / max(t)));  % Rectangular filter

% Filter the signals using convolution
in_phase_filtered = conv(in_phase_signal, rect_filter, 'same');
quadrature_filtered = conv(quadrature_signal, rect_filter, 'same');

% Plot signals before filtering
figure;
hold on;
stairs(t, [in_phase_signal in_phase_signal(end)], 'r', 'LineWidth', 1.5);     % In Phase
stairs(t, [quadrature_signal quadrature_signal(end)], 'b', 'LineWidth', 1.5); % Quadrature
hold off;
title('Transmitted Signal - S_m(t) base band, First Data Set (Before Filtering)');
xlabel('Time (s)');
ylabel('Amplitude');
legend('In Phase', 'Quadrature');
grid on;

% Plot signals after filtering
figure;
hold on;
stairs(t, [in_phase_filtered in_phase_filtered(end)], 'r', 'LineWidth', 1.5);     % In Phase after filter
stairs(t, [quadrature_filtered quadrature_filtered(end)], 'b', 'LineWidth', 1.5); % Quadrature after filter
hold off;
title('Received Signal - S_m(t) after Rectangular Filter');
xlabel('Time (s)');
ylabel('Amplitude');
legend('In Phase', 'Quadrature');
grid on;

% Plot constellation before filtering
figure;
scatter(in_phase_signal, quadrature_signal, 'filled', 'r');
title('Constellation Before Filtering');
xlabel('In Phase');
ylabel('Quadrature');
grid on;
axis([-1.5 1.5 -1.5 1.5]);

% Plot constellation after filtering
figure;
scatter(in_phase_filtered, quadrature_filtered, 'filled', 'b');
title('Constellation After Filtering');
xlabel('In Phase');
ylabel('Quadrature');
grid on;
axis([-0.0015 0.0015 -0.0015 0.0015]);
