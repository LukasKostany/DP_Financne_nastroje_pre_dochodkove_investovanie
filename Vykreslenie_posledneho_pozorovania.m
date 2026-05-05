function Vykreslenie_posledneho_pozorovania(Data, Splatnost, Nazov, Popis, Nazov_subor) % Funkcia na vykreslenie pozorovaní zadaných premenných v poslednom možnom dátume
% Vykreslenie pozorovaní daných premenných v poslednom zaznamenanom dátume
% Vykreslí pozorovania určených premenných v poslednom možnom čase

% Pre správnu funkciu kódu treba zmeniť cestu kam sa majú ukladať obrázky!

% Vstupy:
% Dáta - aké dáta sa majú vykresliť
% Splatnosť - v akých splatnostiach sa majú dáta vykresliť
% Názov - názov daných dát v grafe
% Popis - popis daných dát v grafe
% Názov súboru - časť názvu uloženého súboru s obrázkom popisujúca dáta
         
if contains(Popis, "SeLFIES") % Ak obsahuje popis slovo SeLFIES
   Indexy = Splatnost * 12; % Aké indexy premennej sa majú brať
elseif contains(Popis, "TS") % Ak obsahuje popis slovo TS
       Indexy = 1:6; % Aké indexy premennej sa majú brať
elseif contains(Popis, "TIPS") % Ak obsahuje popis slovo TIPS
       Indexy = 1:5; % Aké indexy premennej sa majú brať       
else % Ak neobsahuje popis slovo SeLFIES, TS alebo TIPS
     Indexy = Splatnost * 12; % Aké indexy premennej sa majú brať
end

% Vykreslenie dát: 
figure; % Nové grafické okno
plot(Splatnost, Data(end, Indexy), ... % Vykreslenie danej premennej pre jednotlivé splatnosti v poslednom dátume
     'bo-', ... % Farba a štýl čiary
     'LineWidth', 1.5) % Šírka čiary
if contains(Popis, "SeLFIES") % Ak obsahuje popis slovo SeLFIES
   xlabel('Konverzia (roky)', ... % Názov x-ovej osi
          'FontSize', 12); % Veľkosť písma
else % Ak neobsahuje popis slovo SeLFIES  
     xlabel('Splatnosť (roky)', ... % Názov x-ovej osi
            'FontSize', 12); % Veľkosť písma
end     
ylabel(Nazov, ... % Názov y-ovej osi
       'FontSize', 12); % Veľkosť písma
title([Popis  ' k dátumu 1.12.2025'], ... % Názov grafu
      'FontSize', 14); % Veľkosť písma
set(gca, 'FontSize', 12); % Veľkosť písma v grafe
xticks(1:3:max(Splatnost)) % Rozsah x-ovej osi
if contains(Popis, "SeLFIES") % Ak obsahuje popis slovo SeLFIES
   yticks(50:25:200) % Rozsah y-ovej osi
end   
if contains(Popis, "počiatočnej investície do SeLFIES") % Ak obsahuje popis slovo počiatočnej investície do SeLFIES
   yticks(0:2:20) % Rozsah y-ovej osi
end
if contains(Popis, "počiatočnej investície do TS") % Ak obsahuje popis slovo počiatočnej investície do TS
   yticks(0:1:5) % Rozsah y-ovej osi
end 
grid on % Mriežka

% Uloženie obrázku:
Nazov_pozorovanie = ['Pozorovanie_' Nazov_subor '.png']; % Názov súboru s pozorovaniami v poslednom možnom dátume
Cesta_pozorovanie = fullfile('C:\Users\IgorM\Documents\DP\Obrazky_final', Nazov_pozorovanie); % Cesta k súboru s pozorovaniami v poslednom možnom dátume
imwrite(frame2im(getframe(gcf)), Cesta_pozorovanie); % Uloženie súboru s pozorovaniami v poslednom možnom dátume

end % Koniec funkcie