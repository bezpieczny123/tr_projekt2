% Deklaracja k1 i k2 dla układu PI
k1 = linspace(3,5,400);
k2 = linspace(0, 0.2, 400); % Zmiana zakresu k2 na 0 do 0.2
[K1,K2] = meshgrid(k1,k2);
mask = K2 < (-K1.^2 + 8*K1 - 15)/8 & K2 > 0; % Dodanie warunku k2 > 0

% Tworzenie figury
figure; hold on
contourf(K1, K2, mask, [1 1], 'LineColor', 'none');
alpha(0.5) % Ustawienie przezroczystości wypełnienia
plot(k1, (-k1.^2 + 8*k1 - 15)/8, 'r-', 'LineWidth', 2) % Górna granica
plot([3, 5], [0, 0], 'b-', 'LineWidth', 2) % Dolna granica (k2=0)

% Tworzenie labeli (również z użyciem LaTeX dla spójności)
xlabel('$k_1$', 'Interpreter', 'latex')
ylabel('$k_2$', 'Interpreter', 'latex')

% Tytuł z użyciem interpretera LaTeX - UPEWNIJ SIĘ, ŻE SĄ POJEDYNCZE BACKSLASHE
title('$3 < k_1 < 5,\quad 0 < k_2 < \frac{-k_1^2 + 8k_1 - 15}{8}$', 'Interpreter', 'latex');

% Dodatkowe opcje wykresu
xlim([3 5])
ylim([0 0.2]) % Ograniczenie osi Y do zakresu 0-0.2
grid on
hold off