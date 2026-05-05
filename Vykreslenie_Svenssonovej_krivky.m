function Vykreslenie_Svenssonovej_krivky(Data, Roky, Nadpis, Popis, Nazov_subor) % Funkcia na vykreslenie Svenssonovej krivky
% Vykreslenie Svenssonovej krivky
% Vykreslí Svenssonovu krivku pre dané dáta v jednotlivých splatnostiach pre zadaný dátum

% Pre správnu funkciu kódu treba zmeniť cestu kam sa majú ukladať obrázky!

% Vstupy:
% Dáta - kalibrované dáta, ktoré sa vykresľujú
% Roky - pre aké splatnosti sa majú dané dáta vykresliť
% Nadpis - nadpis charakterizujúci dáta v grafe
% Popis - popis charakterizujúci dáta v grafe
% Názov súboru - časť názvu uloženého súboru s obrázkom charakterizujúca dáta

figure; % Nové grafické okno
plot(Roky, Data * 100, ... % Vykreslenie kalibrovaných dát
     'bo-', ... % Farba a štýl čiary
     'LineWidth', 1.5) % Šírka čiary
xlabel('Splatnosť (roky)', ... % Názov x-ovej osi
       'FontSize', 12); % Veľkosť písma
ylabel([Nadpis ' (%)'], ... % Názov y-ovej osi
       'FontSize', 12); % Veľkosť písma
title(['Svenssonova krivka ' Popis ' k dátumu 1.12.2025'], ... % Nadpis grafu
      'FontSize', 14); % Veľkosť písma
set(gca, 'FontSize', 12); % Veľkosť písma v grafe
xticks(0:3:60) % Rozsah x-ovej osi
grid on % Mriežka

% Uloženie obrázku:
Nazov_Svensson = ['Svensson_' Nazov_subor '.png']; % Názov súboru so Svenssonovou krivkou 
Cesta_Svensson = fullfile('C:\Users\IgorM\Documents\DP\Obrazky_final', Nazov_Svensson); % Cesta k súboru so Svenssonovou krivkou
imwrite(frame2im(getframe(gcf)), Cesta_Svensson); % Uloženie súboru so Svenssonovou krivkou

end % Koniec funkcie