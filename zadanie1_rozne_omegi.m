A = 1;
B = 1;
C = A + B;

G = tf(1, [1 1]);


% Konfiguracja czasu symulacji
t = 0:0.01:50;

omega0_values = [0.01, 0.1, 0.25, 0.5, 1, 5, 10];

% Inicjalizacja wykresu
figure('Position', [100, 100, 1200, 600]);
hold on;
grid on;

% Kolory linii na wykresie
colors = lines(length(omega0_values));
legendEntries = cell(1, length(omega0_values));

% Dla każdej wartości omega
for i = 1:length(omega0_values)
    omega0 = omega0_values(i);
    u = sin(omega0 * t);
    y = lsim(G, u, t);

    plot(t, y, '-', 'Color', colors(i,:), 'LineWidth', 1.5); 
    
    % Legenda
    legendEntries{i} = ['\omega_0 = ', num2str(omega0)];
end

% Formatowanie wykresu
title('Odpowiedź wyjściowa układu dla różnych \omega_0');
xlabel('Czas [s]');
ylabel('Amplituda');
legend(legendEntries, 'Location', 'eastoutside', 'FontSize', 9);
ylim([-1.2, 1.2]);
set(gca, 'FontSize', 10);
hold off;