A = 1;
B = 1;
G = tf(A, [B 1]);

% Wykres Nyquista
figure(1);
nyquist(G);
grid on;
hold on;

% Lista wartości omega
omega0_values = [0.01, 0.1, 0.25, 0.5, 1, 5, 10];
Re_points = zeros(size(omega0_values));
Im_points = zeros(size(omega0_values));

% 3. Symulacja dla każdego omega0 i odczyt punktów
for i = 1:length(omega0_values)
    omega0 = omega0_values(i);
    T = 2*pi / omega0; 
    t = 0:0.01:20*T;   
    u = sin(omega0 * t);
    y = lsim(G, u, t);
    [A_measured, phi_measured] = measure_amplitude_and_phase(t, u, y, omega0);
    
    Re_points(i) = A_measured * cosd(phi_measured);
    Im_points(i) = A_measured * sind(phi_measured);

end

% Nanoszenie punktów i podpisanie wartościami omega
valid_indices = Re_points & Im_points;
plot(Re_points(valid_indices), Im_points(valid_indices), 'ro', 'MarkerSize', 10, 'LineWidth', 2);

% Podpisywanie punktów do wykresu
for i = 1:length(omega0_values)
    if valid_indices(i)
        text_offset_x = 0.02;
        text_offset_y = 0.02;
        
        text(Re_points(i) + text_offset_x, Im_points(i) + text_offset_y, ...
            ['\omega_0 = ', num2str(omega0_values(i))], ...
            'FontSize', 9, 'Color', 'k');
    end
end

title('Charakterystyka Nyquista z naniesionymi punktami');
legend('Teoretyczna krzywa Nyquista', 'Punkty z symulacji', 'Location', 'best');
hold off;

% Funkcja pomocnicza
function [A, phi_deg] = measure_amplitude_and_phase(t, u, y, omega0)
    t_steady = t > 0.1 * max(t);
    y_steady = y(t_steady);
    u_steady = u(t_steady);
    A = (max(y_steady) - min(y_steady)) / 2;
    [~, u_peaks] = findpeaks(u_steady, 'MinPeakProminence', 0.1);
    [~, y_peaks] = findpeaks(y_steady, 'MinPeakProminence', 0.1);
    
    delta_t = mean(t(y_peaks(2:end))) - mean(t(u_peaks(2:end)))
    phi_deg = -omega0 * delta_t * (180/pi)
end