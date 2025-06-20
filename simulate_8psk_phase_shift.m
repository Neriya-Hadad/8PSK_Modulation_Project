% Apply a phase shift of 30 degrees (π/6 radians)
phase_shift = pi / 6;
in_phase_shifted = in_phase_filtered * cos(phase_shift) - quadrature_filtered * sin(phase_shift);
quadrature_shifted = in_phase_filtered * sin(phase_shift) + quadrature_filtered * cos(phase_shift);

% Plot the constellation after filtering and phase shift
figure;
scatter(in_phase_shifted, quadrature_shifted, 'filled', 'b');  % Constellation after phase shift
title('Constellation After Filtering and Phase Shift of 30 Degrees');
xlabel('In Phase');
ylabel('Quadrature');
grid on;
axis([-0.0015 0.0015 -0.0015 0.0015]);  % Set axis limits for better visualization
