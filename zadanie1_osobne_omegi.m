% Definicja transmitancji
A = 1;
B = 1;
G = tf([A], [B 1]);

% Wartości omega
omega0_values = [0.25, 0.5, 1, 5];

% Konfiguracja czasu symulacji
t = 0:0.01:35;

% Inicjalizacja okna z subplotami (4xq)
figure('Position', [100, 100, 1400, 800]);
set(gcf, 'Color', 'w');

% Dla każdej wartości omega
for i = 1:length(omega0_values)
    omega0 = omega0_values(i);
    u = sin(omega0 * t);
    y = lsim(G, u, t);
    
    % Subplot w układzie 4x1
    subplot(4, 1, i);
    
    % Rysuj wejście i wyjście
    plot(t, u, 'b--', 'LineWidth', 1.2);
    hold on;
    plot(t, y, 'r', 'LineWidth', 1.5);
    hold off;
    
    % Formatowanie
    title(['\omega_0 = ', num2str(omega0), ' rad/s']);
    xlabel('Czas [s]');
    ylabel('Amplituda');
    legend('Wejście', 'Wyjście', 'Location', 'southeast');
    grid on;
    ylim([-1.2, 1.2]);
    set(gca, 'FontSize', 10);
end

% Tytuł główny
sgtitle('Odpowiedź układu na sygnał sinusoidalny', 'FontSize', 14);