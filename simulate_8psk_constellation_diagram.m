% Parameters
A = 1;  % Amplitude
angles = [0 45 90 135 180 225 270 315];  % Angles in degrees (for 8-PSK)
bits = {'000', '001', '011', '010', '110', '111', '101', '100'};  % Gray code mapping

% Convert angles to radians
angles_rad = deg2rad(angles);

% Calculate constellation points (I/Q components)
x = A * cos(angles_rad); % In-phase (I)
y = A * sin(angles_rad); % Quadrature (Q)

% Plot the 8-PSK constellation diagram
figure;
plot(x, y, 'bo', 'MarkerFaceColor', 'b');
hold on;

% Annotate the constellation points with bit labels
for i = 1:length(x)
    text(x(i) + 0.05, y(i), bits{i}, ...
        'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle');
end

% Format the plot
title('8-PSK Constellation with Gray Code');
xlabel('In-phase');
ylabel('Quadrature');
axis equal;
grid on;
hold off;
