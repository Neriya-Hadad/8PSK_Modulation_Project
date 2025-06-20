clc
% Define 8PSK symbols and corresponding Gray code mapping
gray_codes = ["000", "001", "011", "010", "110", "111", "101", "100"];
complex_symbols = [1 + 1j*0, ...
                   sqrt(2)/2 + 1j*sqrt(2)/2, ...
                   0 + 1j*1, ...
                   -sqrt(2)/2 + 1j*sqrt(2)/2, ...
                   -1 + 1j*0, ...
                   -sqrt(2)/2 - 1j*sqrt(2)/2, ...
                   0 - 1j*1, ...
                   sqrt(2)/2 - 1j*sqrt(2)/2];

% Input: 3-bit vector as a string (example)
bits = "111";

% Find the index of the matching Gray code
index = 0;
for i = 1:length(gray_codes)
    if bits == gray_codes(i)
        index = i;
        break;
    end
end

% Compute a_n and b_n (real and imaginary parts)
if index ~= 0
    An = complex_symbols(index); % Corresponding complex symbol
    an = real(An); % Real part (in-phase)
    bn = imag(An); % Imaginary part (quadrature)
    disp(['a_n = ', num2str(an), ', b_n = ', num2str(bn)]);
else
    disp('Code not found in the Gray code table');
end
