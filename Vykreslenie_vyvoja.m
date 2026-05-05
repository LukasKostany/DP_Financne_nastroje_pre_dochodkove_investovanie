function Vykreslenie_vyvoja(Data, Casy, Nazov, Popis, Nazov_subor, varargin) % Funkcia na vykreslenie časového vývoja
% Vykreslenie časového vývoja premennej
% Vykreslí časový vývoj pre dané premenné v zadaných časoch

% Pre správnu funkciu kódu treba zmeniť cestu kam sa majú ukladať obrázky!

% Vstupy:
% Dáta - vývoj akých dát sa má vykresliť
% Časy - v ktorých dátumoch sa má vykresliť vývoj dát 
% Názov - názov daných dát v grafe
% Popis - popis daných dát v grafe
% Názov súboru - časť názvu uloženého súboru s obrázkom popisujúca dáta
% (varargin) - názvy premenných v legende (ak je viacero premenných)

% Farby do grafu:
if contains(Popis, "AFS") || contains(Popis, "S&P") || contains(Popis, "počiatočnej") % Ak obsahuje popis slová AFS alebo SAP alebo počiatočnej
   farby = [0.94 0.50 0.50; % Ružová
            0.64 0.08 0.18; % Tmavo červená
            0.00 0.45 0.74; % Modrá
            0.47 0.67 0.19; % Zelená
            0.25 0.25 0.25]; % Tmavo sivá

else % Ak neobsahuje popis slová AFS alebo SAP alebo počiatočnej
     farby = [0.94 0.50 0.50; % Ružová
              0.85 0.33 0.10; % Oranžová
              0.93 0.69 0.13; % Žltá
              0.64 0.08 0.18; % Tmavo červená
              0.49 0.18 0.56; % Fialová
              0.30 0.75 0.93; % Azúrová
              0.00 0.45 0.74; % Modrá
              0.47 0.67 0.19; % Zelená
              0.75 0.75 0.00; % Olivová
              0.00 0.50 0.00; % Tmavo zelená
              0.25 0.25 0.25]; % Tmavo sivá
end

% Vývoj v čase: 
figure; % Nové grafické okno
hold on; % Kreslenie do rovnakého grafického okna
for Premenna = 1:width(Data) % Pre každú jednu premennú
    plot(Casy, Data(:, Premenna), ... % Vykreslenie časového vývoja
         'Color', farby(Premenna, :), ... % Farba čiary
         'LineWidth', 1.5); % Šírka čiary
end
hold off; % Prerušenie kreslenia do rovnakého grafického okna
title(['Vývoj ' Popis], ... % Názov grafu
       'FontSize', 14); % Veľkosť písma  
xlabel('Rok', ... % Názov x-ovej osi
       'FontSize', 12); % Veľkosť písma 
if contains(Popis, "hodnoty") % Ak obsahuje popis slovo hodnoty
   ylabel(Nazov, ... % Názov y-ovej osi
          'FontSize', 12); % Veľkosť písma
   yticks(0:10:120); % Nastavenie rozsahu y-ovej osi
else % Ak neobsahuje popis slovo hodnoty
     ylabel([Nazov ' (%)'], ... % Názov y-ovej osi
            'FontSize', 12); % Veľkosť písma
     if contains(Nazov, "AFS") || contains(Nazov, "S&P 500")% Ak obsahuje názov slovo AFS alebo S&P 500
        yticks(0:10:max(max(Data))); % Nastavenie rozsahu y-ovej osi
     else % Ak neobsahuje názov slovo AFS alebo S&P 500
          yticks(min(min(Data)):1:max(max(Data))); % Nastavenie rozsahu y-ovej osi
     end    
     if contains(Nazov, "TIPS") % Ak obsahuje názov slovo TIPS
        yticks(-2:1:4); % Nastavenie rozsahu y-ovej osi
     end
     if contains(Nazov, "inflácia") % Ak obsahuje názov slovo inflácia
        yticks(-1:1:7); % Nastavenie rozsahu y-ovej osi
     end
     if contains(Nazov, "Reálna") % Ak obsahuje názov slovo Reálna
        yticks(-3:1:9); % Nastavenie rozsahu y-ovej osi
     end
end
set(gca, 'FontSize', 12); % Veľkosť písma v grafe
grid on; % Mriežka
xticks(min(Casy):calyears(2):max(Casy)); % Nastavenie rozsahu x-ovej osi
ax = gca; ax.XAxis.TickLabelFormat = 'yyyy'; % Vypísanie iba rokov na x-ovej osi
if numel(varargin) >= 1 % Ak je viacej premenných
   nazvy_legenda = varargin{1}; % Priradenie názvov premenných do legendy
   legend(nazvy_legenda, ... % Legenda
          'Location', 'best', ... % Poloha legendy
          'FontSize', 12); % Veľkosť písma v legende
end

% Uloženie obrázku:
Nazov_casovy_vyvoj = ['Vyvoj_' Nazov_subor '.png']; % Názov súboru s časovým vývojom
Cesta_casovy_vyvoj = fullfile('C:\Users\IgorM\Documents\DP\Obrazky_final', Nazov_casovy_vyvoj); % Cesta k súboru s časovým vývojom
imwrite(frame2im(getframe(gcf)), Cesta_casovy_vyvoj); % Uloženie súboru s časovým vývojom

end % Koniec funkcie

