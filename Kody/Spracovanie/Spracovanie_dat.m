function Data_casova_tabulka = Spracovanie_dat(Cesta, Nazov, varargin) % Funkcia na načítanie dát
% Načítanie a spracovanie dát
% Načíta a spracuje dáta, poprípade vykreslí graf ich časového vývoja

% Pre správnu funkciu kódu treba zmeniť cestu kam sa majú ukladať obrázky!

% Vstupy:
% Cesta - cesta k súboru s dátami
% Názov - pomenovanie dát
% (varargin) - popis dát v grafoch / časť nadpisu do grafov popisujúca dáta / časť názvu uloženého súboru s obrázkom popisujúca dáta (ak je viacero premenných)

% Výstupy:
% Data_casova_tabulka - načítané dáta spolu s dátumami

%  Načítanie dát:
Data = readtable(Cesta); % Načítanie dát do MATLABU
Data = Data(:, 1:2); % Výber iba prvých 2 stĺpcov

% Zmena názvov vybraných premenných:
Data.Properties.VariableNames{1} = 'Datum'; % Názov prvej premennej 
Data.Properties.VariableNames{2} = Nazov; % Názov druhej premennej

% Úprava dát:
if contains(Nazov, "SAP") % Ak obsahuje názov slovo SAP 
   % ️Úprava dátumu:
   Data.Datum = datetime(Data.Datum, 'InputFormat', 'MM/dd/yyyy'); % Prevod dátumu na typ datetime
   Data.Datum.Format = 'yyyy-MM-dd'; % Zmena štýlu dátumu
   Data = sortrows(Data, 'Datum'); % Usporiadanie dát od najstarších po najnovšie

  % ️Úprava hodnôt:
  Data.(Nazov) = str2double(erase(string(Data.(Nazov)), "," )); % Prevod hodnôt na typ double
end

if contains(Nazov, "NAWI") % Ak obsahuje názov slovo NAWI
   Data.Datum = datetime(Data.Datum, 1, 1); % Nastavenie dátumu na 1.1 v každom roku
end

% Konverzia dát na timetable:
Data_casova_tabulka = table2timetable(removevars(Data, "Datum"), 'RowTimes', Data.Datum); % Vytvorenie časovej tabuľky

% Časový vývoj:
if contains(Nazov, "hodnota") || contains(Nazov, "Hodnota") || contains(Nazov, "CPI") || contains(Nazov, "NAWI") % Ak obsahuje názov slovo hodnota alebo Hodnota alebo CPI alebo NAWI
   Cesta_obrazky = 'C:\Users\IgorM\Documents\DP\Obrazky_final'; % Cesta, kam sa majú ukladať obrázky
   
   % Vývoj v čase: 
   figure; % Nové grafické okno
   plot(Data.Datum, Data{:, 2}, ... % Vykreslenie vývoja
        'b-', ... % Farba a štýl čiary
        'LineWidth', 1.5); % Šírka čiary
   title(['Vývoj ' varargin{2}], ... % Názov grafu
          'FontSize', 14); % Veľkosť písma  
   xlabel('Rok', ... % Názov x-ovej osi
          'FontSize', 12); % Veľkosť písma  
   ylabel(varargin{1}, ... % Názov y-ovej osi
          'FontSize', 12); % Veľkosť písma
   set(gca, 'FontSize', 12); % Veľkosť písma v grafe
   grid on; % Mriežka
   xticks(min(Data.Datum):calyears(2):max(Data.Datum)); % Nastavenie rozsahu x-ovej osi
   
   if contains(Nazov, "SAP")  % Ak obsahuje názov slovo SAP
      yticks(0:500:7000); % Nastavenie rozsahu y-ovej osi
   end

   if contains(Nazov, "NAWI")  % Ak obsahuje názov slovo NAWI
      yticks(10000:5000:70000); % Nastavenie rozsahu y-ovej osi
   end

   ax = gca; ax.XAxis.TickLabelFormat = 'yyyy'; % Vypísanie iba rokov na x-ovej osi
    
   % Uloženie obrázku:
   Nazov_vyvoja = ['Vyvoj_' varargin{3} '.png']; % Názov súboru s časovým vývojom
   Cesta_vyvoj = fullfile(Cesta_obrazky, Nazov_vyvoja); % Cesta k súboru s časovým vývojom
   imwrite(frame2im(getframe(gcf)), Cesta_vyvoj); % Uloženie súboru s časovým vývojom

end % Koniec funkcie
