%% Diplomová práca
% Finančné nástroje pre dôchodkové investovanie
% Lukáš Košťany
% 2.mEMM

%%  Pre správnu funkciu kódu je potrebné zmeniť cesty k využívaným dátam a mať prístup k potrebným knižniciam!

%% Nastavenie vlastností vykresľovaných obrázkov:
set(0, 'DefaultFigureColor', 'white'); % Farba okolia grafu
set(0, 'DefaultAxesColor', 'white'); % Farba vnútra grafu
set(0, 'DefaultAxesXColor', 'black'); % Farba popisu osi x
set(0, 'DefaultAxesYColor', 'black'); % Farba popisu osi y
set(0, 'DefaultTextColor', 'black'); % Farba textu v grafe
set(0, 'DefaultAxesGridColor', 'black'); % Farba mriežky
set(0, 'DefaultAxesGridAlpha', 0.15); % Priehľadnosť mriežky
set(0, 'DefaultLegendTextColor', 'black'); % Farba textu v legende
set(0, 'DefaultLegendColor', 'white'); % Farba pozadia legendy

%% Načítanie a spracovanie dát:
% Načítanie a spracovanie dát pre výnosy do splatnosti amerických štátnych dlhopisov (TS - Treasury Securities) s jednotlivými konštantnými maturitami:
Cesta_TS = 'C:\Users\IgorM\Documents\DP\TS\'; % Nastavenie cesty k priečinku s dátami pre TS 

% Načítanie jednotlivých dát:
Vynos_do_splatnosti_TS_1M = Spracovanie_dat([Cesta_TS '1M.csv'], 'Vynos_do_splatnosti_1_mesacnych_TS'); % Výnosy do splatnosti TS s konštantnou maturitou mesiac
Vynos_do_splatnosti_TS_3M = Spracovanie_dat([Cesta_TS '3M.csv'], 'Vynos_do_splatnosti_3_mesacnych_TS'); % Výnosy do splatnosti TS s konštantnou maturitou 3 mesiace
Vynos_do_splatnosti_TS_6M = Spracovanie_dat([Cesta_TS '6M.csv'], 'Vynos_do_splatnosti_6_mesacnych_TS'); % Výnosy do splatnosti TS s konštantnou maturitou 6 mesiacov
Vynos_do_splatnosti_TS_1Y = Spracovanie_dat([Cesta_TS '1Y.csv'], 'Vynos_do_splatnosti_1_rocnych_TS'); % Výnosy do splatnosti TS s konštantnou maturitou rok
Vynos_do_splatnosti_TS_2Y = Spracovanie_dat([Cesta_TS '2Y.csv'], 'Vynos_do_splatnosti_2_rocnych_TS'); % Výnosy do splatnosti TS s konštantnou maturitou 2 roky 
Vynos_do_splatnosti_TS_3Y = Spracovanie_dat([Cesta_TS '3Y.csv'], 'Vynos_do_splatnosti_3_rocnych_TS'); % Výnosy do splatnosti TS s konštantnou maturitou 3 roky
Vynos_do_splatnosti_TS_5Y = Spracovanie_dat([Cesta_TS '5Y.csv'], 'Vynos_do_splatnosti_5_rocnych_TS'); % Výnosy do splatnosti TS s konštantnou maturitou 5 rokov
Vynos_do_splatnosti_TS_7Y = Spracovanie_dat([Cesta_TS '7Y.csv'], 'Vynos_do_splatnosti_7_rocnych_TS'); % Výnosy do splatnosti TS s konštantnou maturitou 7 rokov
Vynos_do_splatnosti_TS_10Y = Spracovanie_dat([Cesta_TS '10Y.csv'], 'Vynos_do_splatnosti_10_rocnych_TS'); % Výnosy do splatnosti TS s konštantnou maturitou 10 rokov 
Vynos_do_splatnosti_TS_20Y = Spracovanie_dat([Cesta_TS '20Y.csv'], 'Vynos_do_splatnosti_20_rocnych_TS'); % Výnosy do splatnosti TS s konštantnou maturitou 20 rokov 
Vynos_do_splatnosti_TS_30Y = Spracovanie_dat([Cesta_TS '30Y.csv'], 'Vynos_do_splatnosti_30_rocnych_TS'); % Výnosy do splatnosti TS s konštantnou maturitou 30 rokov

% Spojenie výnosov do splatnosti TS s jednotlivými konštantnými maturitami:
Vynosy_do_splatnosti_TS = synchronize(Vynos_do_splatnosti_TS_1M, Vynos_do_splatnosti_TS_3M, Vynos_do_splatnosti_TS_6M, Vynos_do_splatnosti_TS_1Y, ...
                                      Vynos_do_splatnosti_TS_2Y, Vynos_do_splatnosti_TS_3Y, Vynos_do_splatnosti_TS_5Y, Vynos_do_splatnosti_TS_7Y, ...
                                      Vynos_do_splatnosti_TS_10Y, Vynos_do_splatnosti_TS_20Y, Vynos_do_splatnosti_TS_30Y); % Vytvorenie časovej tabuľky
Legenda_nazvy_TS = {'1-mesačné', '3-mesačné', '6-mesačné', '1-ročné', '2-ročné', '3-ročné', '5-ročné', '7-ročné', '10-ročné', '20-ročné', '30-ročné'}; % Názvy TS do legendy
Vykreslenie_vyvoja(Vynosy_do_splatnosti_TS{:,:}, Vynosy_do_splatnosti_TS.Time, 'Výnosy do splatnosti TS s rôznymi konštantnými maturitami', 'výnosov do splatnosti TS s rôznymi konštantnými maturitami', 'Vynosy_TS', Legenda_nazvy_TS) % Vykreslenie vývoja jednotlivých výnosov do splatnosti TS s rôznymi konštantnými maturitami 

% Načítanie a spracovanie dát pre výnosy do splatnosti amerických štátnych dlhopisov chránených proti inflácii (TIPS - Treasury Inflation-Protected Securities) s jednotlivými konštantnými maturitami:
Cesta_TIPS = 'C:\Users\IgorM\Documents\DP\TIPS\'; % Nastavenie cesty k priečinku s dátami pre TIPS

% Načítanie jednotlivých dát:
Vynos_do_splatnosti_TIPS_5Y = Spracovanie_dat([Cesta_TIPS '5Y.csv'], 'Vynos_do_splatnosti_5_rocnych_TIPS'); % Výnosy do splatnosti TIPS s konštantnou maturitou 5 rokov
Vynos_do_splatnosti_TIPS_7Y = Spracovanie_dat([Cesta_TIPS '7Y.csv'], 'Vynos_do_splatnosti_7_rocnych_TIPS'); % Výnosy do splatnosti TIPS s konštantnou maturitou 7 rokov
Vynos_do_splatnosti_TIPS_10Y = Spracovanie_dat([Cesta_TIPS '10Y.csv'], 'Vynos_do_splatnosti_10_rocnych_TIPS'); % Výnosy do splatnosti TIPS s konštantnou maturitou 10 rokov
Vynos_do_splatnosti_TIPS_20Y = Spracovanie_dat([Cesta_TIPS '20Y.csv'], 'Vynos_do_splatnosti_20_rocnych_TIPS'); % Výnosy do splatnosti TIPS s konštantnou maturitou 20 rokov
Vynos_do_splatnosti_TIPS_30Y = Spracovanie_dat([Cesta_TIPS '30Y.csv'], 'Vynos_do_splatnosti_30_rocnych_TIPS'); % Výnosy do splatnosti TIPS s konštantnou maturitou 30 rokov

% Spojenie výnosov do splatnosti TIPS s jednotlivými konštantnými maturitami:
Vynosy_do_splatnosti_TIPS = synchronize(Vynos_do_splatnosti_TIPS_5Y, Vynos_do_splatnosti_TIPS_7Y, Vynos_do_splatnosti_TIPS_10Y, Vynos_do_splatnosti_TIPS_20Y, Vynos_do_splatnosti_TIPS_30Y); % Vytvorenie časovej tabuľky
Legenda_nazvy_TIPS = {'5-ročné', '7-ročné', '10-ročné', '20-ročné', '30-ročné'}; % Názvy TIPS do legendy
Vykreslenie_vyvoja(Vynosy_do_splatnosti_TIPS{:,:}, Vynosy_do_splatnosti_TIPS.Time, 'Výnosy do splatnosti TIPS s rôznymi konštantnými maturitami', 'výnosov do splatnosti TIPS s rôznymi konštantnými maturitami', 'Vynosy_TIPS', Legenda_nazvy_TIPS) % Vykreslenie vývoja jednotlivých výnosov do splatnosti TIPS s rôznymi konštantnými maturitami 

% Načítanie a spracovanie dát pre nominálne hodnoty indexu S&P 500:
Cesta_SAP_500 = 'C:\Users\IgorM\Documents\DP\SAP500\'; % Nastavenie cesty k priečinku s dátami pre S&P 500
Nominalne_hodnoty_SAP_500 = Spracovanie_dat([Cesta_SAP_500 'SAP500.csv'], 'Nominalna_hodnota_SAP_500', 'Nominálna hodnota indexu S&P 500', 'nominálnej hodnoty indexu S&P 500', 'SAP_500'); % Načítanie nominálnych hodnôt indexu S&P 500

% Načítanie a spracovanie dát pre jednotlivé očakávané inflácie:
Cesta_inflacia = 'C:\Users\IgorM\Documents\DP\Inflacia\'; % Nastavenie cesty k priečinku s dátami pre infláciu

% Načítanie jednotlivých dát:
Ocakava_inflacia_1Y = Spracovanie_dat([Cesta_inflacia '1Y.csv'], 'Ocakavana_inflacia_1_rocna'); % Ročná očakávaná inflácia
Ocakava_inflacia_2Y = Spracovanie_dat([Cesta_inflacia '2Y.csv'], 'Ocakavana_inflacia_2_rocna'); % 2-ročná očakávaná inflácia 
Ocakava_inflacia_3Y = Spracovanie_dat([Cesta_inflacia '3Y.csv'], 'Ocakavana_inflacia_3_rocna'); % 3-ročná očakávaná inflácia 
Ocakava_inflacia_4Y = Spracovanie_dat([Cesta_inflacia '4Y.csv'], 'Ocakavana_inflacia_4_rocna'); % 4-ročná očakávaná inflácia 
Ocakava_inflacia_5Y = Spracovanie_dat([Cesta_inflacia '5Y.csv'], 'Ocakavana_inflacia_5_rocna'); % 5-ročná očakávaná inflácia 
Ocakava_inflacia_6Y = Spracovanie_dat([Cesta_inflacia '6Y.csv'], 'Ocakavana_inflacia_6_rocna'); % 6-ročná očakávaná inflácia 
Ocakava_inflacia_7Y = Spracovanie_dat([Cesta_inflacia '7Y.csv'], 'Ocakavana_inflacia_7_rocna'); % 7-ročná očakávaná inflácia 
Ocakava_inflacia_8Y = Spracovanie_dat([Cesta_inflacia '8Y.csv'], 'Ocakavana_inflacia_8_rocna'); % 8-ročná očakávaná inflácia 
Ocakava_inflacia_9Y = Spracovanie_dat([Cesta_inflacia '9Y.csv'], 'Ocakavana_inflacia_9_rocna'); % 9-ročná očakávaná inflácia 
Ocakava_inflacia_10Y = Spracovanie_dat([Cesta_inflacia '10Y.csv'], 'Ocakavana_inflacia_10_rocna'); % 10-ročná očakávaná inflácia 
Ocakava_inflacia_11Y = Spracovanie_dat([Cesta_inflacia '11Y.csv'], 'Ocakavana_inflacia_11_rocna'); % 11-ročná očakávaná inflácia
Ocakava_inflacia_12Y = Spracovanie_dat([Cesta_inflacia '12Y.csv'], 'Ocakavana_inflacia_12_rocna'); % 12-ročná očakávaná inflácia 
Ocakava_inflacia_13Y = Spracovanie_dat([Cesta_inflacia '13Y.csv'], 'Ocakavana_inflacia_13_rocna'); % 13-ročná očakávaná inflácia 
Ocakava_inflacia_14Y = Spracovanie_dat([Cesta_inflacia '14Y.csv'], 'Ocakavana_inflacia_14_rocna'); % 14-ročná očakávaná inflácia 
Ocakava_inflacia_15Y = Spracovanie_dat([Cesta_inflacia '15Y.csv'], 'Ocakavana_inflacia_15_rocna'); % 15-ročná očakávaná inflácia 
Ocakava_inflacia_16Y = Spracovanie_dat([Cesta_inflacia '16Y.csv'], 'Ocakavana_inflacia_16_rocna'); % 16-ročná očakávaná inflácia 
Ocakava_inflacia_17Y = Spracovanie_dat([Cesta_inflacia '17Y.csv'], 'Ocakavana_inflacia_17_rocna'); % 17-ročná očakávaná inflácia 
Ocakava_inflacia_18Y = Spracovanie_dat([Cesta_inflacia '18Y.csv'], 'Ocakavana_inflacia_18_rocna'); % 18-ročná očakávaná inflácia 
Ocakava_inflacia_19Y = Spracovanie_dat([Cesta_inflacia '19Y.csv'], 'Ocakavana_inflacia_19_rocna'); % 19-ročná očakávaná inflácia 
Ocakava_inflacia_20Y = Spracovanie_dat([Cesta_inflacia '20Y.csv'], 'Ocakavana_inflacia_20_rocna'); % 20-ročná očakávaná inflácia 
Ocakava_inflacia_21Y = Spracovanie_dat([Cesta_inflacia '21Y.csv'], 'Ocakavana_inflacia_21_rocna'); % 21-ročná očakávaná inflácia 
Ocakava_inflacia_22Y = Spracovanie_dat([Cesta_inflacia '22Y.csv'], 'Ocakavana_inflacia_22_rocna'); % 22-ročná očakávaná inflácia 
Ocakava_inflacia_23Y = Spracovanie_dat([Cesta_inflacia '23Y.csv'], 'Ocakavana_inflacia_23_rocna'); % 23-ročná očakávaná inflácia 
Ocakava_inflacia_24Y = Spracovanie_dat([Cesta_inflacia '24Y.csv'], 'Ocakavana_inflacia_24_rocna'); % 24-ročná očakávaná inflácia 
Ocakava_inflacia_25Y = Spracovanie_dat([Cesta_inflacia '25Y.csv'], 'Ocakavana_inflacia_25_rocna'); % 25-ročná očakávaná inflácia
Ocakava_inflacia_26Y = Spracovanie_dat([Cesta_inflacia '26Y.csv'], 'Ocakavana_inflacia_26_rocna'); % 26-ročná očakávaná inflácia 
Ocakava_inflacia_27Y = Spracovanie_dat([Cesta_inflacia '27Y.csv'], 'Ocakavana_inflacia_27_rocna'); % 27-ročná očakávaná inflácia 
Ocakava_inflacia_28Y = Spracovanie_dat([Cesta_inflacia '28Y.csv'], 'Ocakavana_inflacia_28_rocna'); % 28-ročná očakávaná inflácia 
Ocakava_inflacia_29Y = Spracovanie_dat([Cesta_inflacia '29Y.csv'], 'Ocakavana_inflacia_29_rocna'); % 29-ročná očakávaná inflácia 
Ocakava_inflacia_30Y = Spracovanie_dat([Cesta_inflacia '30Y.csv'], 'Ocakavana_inflacia_30_rocna'); % 30-ročná očakávaná inflácia 

% Spojenie jednotlivých očakávaných inflácií:
Ocakavana_inflacia = synchronize(Ocakava_inflacia_1Y, Ocakava_inflacia_2Y, Ocakava_inflacia_3Y, Ocakava_inflacia_4Y, Ocakava_inflacia_5Y, ...
                                 Ocakava_inflacia_6Y, Ocakava_inflacia_7Y, Ocakava_inflacia_8Y, Ocakava_inflacia_9Y, Ocakava_inflacia_10Y, ...
                                 Ocakava_inflacia_11Y, Ocakava_inflacia_12Y, Ocakava_inflacia_13Y, Ocakava_inflacia_14Y, Ocakava_inflacia_15Y, ...
                                 Ocakava_inflacia_16Y, Ocakava_inflacia_17Y, Ocakava_inflacia_18Y, Ocakava_inflacia_19Y, Ocakava_inflacia_20Y, ...
                                 Ocakava_inflacia_21Y, Ocakava_inflacia_22Y, Ocakava_inflacia_23Y, Ocakava_inflacia_24Y, Ocakava_inflacia_25Y, ...
                                 Ocakava_inflacia_26Y, Ocakava_inflacia_27Y, Ocakava_inflacia_28Y, Ocakava_inflacia_29Y, Ocakava_inflacia_30Y); % Vytvorenie časovej tabuľky
Legenda_nazvy_inflacia = {'Ročná', '5-ročná', '10-ročná', '15-ročná', '20-ročná', '25-ročná', '30-ročná'}; % Názvy do legendy
Vykreslenie_vyvoja(Ocakavana_inflacia{:,[1, 5:5:30]}, Ocakavana_inflacia.Time, 'Očakávaná inflácia pre vybrané obdobia', 'očakávanej inflácie pre vybrané obdobia', 'Predikovana_inflacia', Legenda_nazvy_inflacia) % Vykreslenie vývoja očakávanej inflácie pre rôzne obdobia

% Načítanie a spracovanie dát pre index spotrebiteľských cien (Consumer Price Index - CPI):
Cesta_CPI = 'C:\Users\IgorM\Documents\DP\CPI\'; % Nastavenie cesty k priečinku s dátami pre CPI
Data_CPI = Spracovanie_dat([Cesta_CPI 'CPI.csv'], 'CPI', 'Hodnota indexu spotrebiteľských cien', 'hodnoty indexu spotrebiteľských cien', 'CPI'); % Načítanie hodnôt indexu spotrebiteľských cien
Data_CPI{526, 1} = 0.5 * Data_CPI{525, 1} + 0.5 * Data_CPI{527, 1}; % Náhrada hodnoty NaN priemerom okolitých hodnôt

% Načítanie a spracovanie dát pre National Average Wage Index (NAWI):
Cesta_NAWI = 'C:\Users\IgorM\Documents\DP\NAWI\'; % Nastavenie cesty k priečinku s dátami pre NAWI
Data_NAWI = Spracovanie_dat([Cesta_NAWI 'NAWI.txt'], 'NAWI', 'Hodnota NAWI (National Average Wage Index)', 'hodnoty NAWI (National Average Wage Index)', 'NAWI'); % Načítanie hodnôt NAWI (National Average Wage Index)
Data_NAWI = [Data_NAWI; timetable(datetime(2025, 1, 1), Data_NAWI.NAWI(end), 'VariableNames', {'NAWI'})]; % Priradenie hodnoty NAWI v roku 2025 rovnakej ako v roku 2024 

%% Svenssonova krivka pre nominálnu úrokovú mieru:
% Informácie o funkcií fitSvensson:
help fitSvensson % stručný help
doc fitSvensson % podrobný help

% Informácie o funkcií fininstrument:
help fininstrument % stručný help
doc fininstrument % podrobný help

% Informácie o funkcií zerorates:
help zerorates % stručný help
doc zerorates % podrobný help

% Kalibrovanie Svenssonovho modelu:
Maturity_TS = [1/12 3/12 6/12 1 2 3 5 7 10 20 30]; % Konštantné maturity jednotlivých TS
Svenssonove_krivky_nominalna_urokova_miera = Kalibrovanie_Svenssonovho_modelu(Vynosy_do_splatnosti_TS, Maturity_TS, 2, 'A'); % Získanie Svenssonových kriviek pre nominálnu úrokovú mieru

% Ukážka Svenssonovej krivky spotových nominálnych úrokových mier pre posledné pozorovanie:
Splatnosti_spotovej_nominalnej_urokovej_miery = (1:1:60)'; % Jednotlivé splatnosti spotových nominálnych úrokových mier
Spotova_nominalna_urokova_miera_vykreslenie = zerorates(Svenssonove_krivky_nominalna_urokova_miera{end}, Vynosy_do_splatnosti_TS.Time(end) + calyears(Splatnosti_spotovej_nominalnej_urokovej_miery)); % Jednotlivé spotové nominálne úrokové miery
Vykreslenie_Svenssonovej_krivky(Spotova_nominalna_urokova_miera_vykreslenie, Splatnosti_spotovej_nominalnej_urokovej_miery, 'Nominálna spotová úroková miera pre rôzne splatnosti', 'nominálnej spotovej úrokovej miery pre rôzne splatnosti', 'Nominalne_uroky') % Vykreslenie Svenssonovej krivky pre spotové nominálne úrokové miery pre posledné pozorovanie

%% Svenssonova krivka pre očakávanú infláciu:
% Kalibrovanie Svenssonovho modelu:
Maturity_ocakavana_inflacia = 1:1:30; % Splatnosti pre očakávanú infláciu
Svenssonove_krivky_ocakavana_inflacia = Kalibrovanie_Svenssonovho_modelu(Ocakavana_inflacia, Maturity_ocakavana_inflacia, 0, 'B'); % Získanie Svenssonových kriviek pre očakávanú infláciu

% Ukážka Svenssonovej krivky očakávanej inflácie pre posledné pozorovanie:
Splatnosti_ocakavana_inflacia = (1:1:60)'; % Jednotlivé splatnosti očakávanej inflácie
Ocakavana_inflacia_vykreslenie = zerorates(Svenssonove_krivky_ocakavana_inflacia{end}, Ocakavana_inflacia.Time(end) + calyears(Splatnosti_ocakavana_inflacia)); % Jednotlivé očakávané inflácie
Vykreslenie_Svenssonovej_krivky(Ocakavana_inflacia_vykreslenie, Splatnosti_ocakavana_inflacia, 'Očakávaná inflácia pre rôzne splatnosti', 'očakávanej inflácie pre rôzne splatnosti', 'Predikovana_inflacia') % Vykreslenie Svenssonovej krivky pre očakávanú infláciu pre posledné pozorovanie

%% Reálna úroková miera:
% Výpočet reálnej úrokovej miery:
Splatnosti_realnej_urokovej_miery = 1:1:780; % Pre aké splatnosti sa má počítať reálna úroková miera
Pocet_splatnosti_urokovej_miery = length(Splatnosti_realnej_urokovej_miery); % Pre koľko splatností sa počíta reálna úroková miera
Pocet_mesiacov = height(Vynosy_do_splatnosti_TS.Time); % Počet mesiacov v ktorých počítame reálnu úrokovú mieru

% Inicializácia vektorov:
Nominalna_urokova_miera_Svensson = zeros(Pocet_mesiacov, Pocet_splatnosti_urokovej_miery); % Inicializácia matice nominálnej úrokovej miery pre rôzne splatnosti v jednotlivých mesiacov 
Ocakavana_inflacia_Svensson = zeros(Pocet_mesiacov, Pocet_splatnosti_urokovej_miery); % Inicializácia matice očakávanej inflácie pre rôzne splatnosti v jednotlivých mesiacoch
Realna_urokova_miera = zeros(Pocet_mesiacov, Pocet_splatnosti_urokovej_miery); % Inicializácia matice reálnej úrokovej miery pre rôzne splatnosti v jednotlivých mesiacoch 

for Mesiac = 1:Pocet_mesiacov % Pre každý mesiac
    Datum = Vynosy_do_splatnosti_TS.Time(Mesiac); % Dátum v daný mesiac
    Nominalna_urokova_miera_Svensson(Mesiac, :) = zerorates(Svenssonove_krivky_nominalna_urokova_miera{Mesiac}, Datum + calmonths(Splatnosti_realnej_urokovej_miery)); % Nominálna úroková miera v danom mesiaci pre všetky splatnosti
    Ocakavana_inflacia_Svensson(Mesiac, :) = zerorates(Svenssonove_krivky_ocakavana_inflacia{Mesiac}, Datum + calmonths(Splatnosti_realnej_urokovej_miery)); % Očakávaná inflácia v danom mesiaci pre všetky splatnosti
    Realna_urokova_miera(Mesiac, :) =  Nominalna_urokova_miera_Svensson(Mesiac, :) - Ocakavana_inflacia_Svensson(Mesiac, :); % Reálna úroková miera vypočítaná podľa Fisherovej aproximácie v danom mesiaci pre všetky splatnosti     
end

% Ukážka krivky reálnej úrokovej miery pre posledné pozorovanie:
Roky_realna_urokova_miera = 1:1:60; % Jednotlivé splatnosti reálnej úrokovej miery
Vykreslenie_posledneho_pozorovania(Realna_urokova_miera * 100, Roky_realna_urokova_miera, 'Reálna úroková miera pre rôzne splatnosti (%)', 'Krivka reálnej úrokovej miery pre rôzne splatnosti', 'Realna_urokova_miera') % Vykreslenie vypočítanej krivky reálnej úrokovej miery pre rôzne splatnosti pre posledné pozorovanie

% Časový vývoj reálnej úrokovej miery pre rôzne splatnosti:
Legenda_nazvy_realna_urokova_miera = {'Ročná', '5-ročná', '10-ročná', '15-ročná', '20-ročná', '25-ročná', '30-ročná'}; % Názvy do legendy
Vykreslenie_vyvoja(Realna_urokova_miera(:, [12, 60:60:360]) * 100, Ocakavana_inflacia.Time, 'Reálna úroková miera pre rôzne splatnosti', 'reálnej úrokovej miery pre rôzne splatnosti', 'Realna_urokova_miera', Legenda_nazvy_realna_urokova_miera) % Vykreslenie vývoja reálnej úrokovej miery pre rôzne splatnosti

%% Reálna hodnota SeLFIES:
Cas_do_konverzie_SeLFIES = 1/12:1/12:44; % Čas do konverzie jednotlivých SeLFIES
Cas_v_rokoch = 0:1/12:65; % Čas vyjadrený v rokoch
Pocet_konverzii_SeLFIES = length(Cas_do_konverzie_SeLFIES); % Koľko rozdielnych konverzii SeLFIES skúmame
Realne_hodnoty_SeLFIES = zeros(Pocet_mesiacov, Pocet_konverzii_SeLFIES); % Inicializácia matice reálnych hodnôt SeLFIES
Realne_hodnoty_SeLFIES_posunute = zeros((Pocet_mesiacov - 1), Pocet_konverzii_SeLFIES); % Inicializácia matice reálnych hodnôt SeLFIES po uplynutí 1 mesiaca od ich vydania
Mesacna_platba_SeLFIES = 1; % Koľko mesačne reálne vyplatí SeLFIES
Pocet_platieb_SeLFIES = 240; % Koľko mesačných platieb dostaneme zo SeLFIES

for Mesiac = 1:Pocet_mesiacov % Pre každý mesiac
    for Konverzia_SeLFIES = 1:Pocet_konverzii_SeLFIES % Pre každú konverziu SeLFIES
        Zaciatok_vyplacania = Cas_do_konverzie_SeLFIES(Konverzia_SeLFIES) + 1/12; % Čas v rokoch do doby kedy SeLFIES začne vyplácať platby
        Koniec_vyplacania = Zaciatok_vyplacania + Cas_v_rokoch(Pocet_platieb_SeLFIES); % Čas v rokoch do doby kedy SeLFIES vyplatí poslednú platbu
        Vyplacanie = Zaciatok_vyplacania:1/12:Koniec_vyplacania; % Čas v rokoch v dobe kedy SeLFIES vypláca platby
        Diskontne_faktory = exp(-Realna_urokova_miera(Mesiac, round(Vyplacanie * 12)) .* Vyplacanie); % Diskontné faktory jednotlivých platieb
        Realne_hodnoty_SeLFIES(Mesiac, Konverzia_SeLFIES) = Mesacna_platba_SeLFIES * sum(Diskontne_faktory); % Reálna hodnota SeLFIES v danom mesiaci s danou konveriou
        if Mesiac < Pocet_mesiacov % Ak nie sme v poslednom skúmanom mesiaci
           Vyplacanie_posunute = (Zaciatok_vyplacania - 1/12):1/12:(Koniec_vyplacania - 1/12); % Čas v rokoch v dobe kedy SeLFIES vypláca platby po uplynutí 1 mesiaca od vydania
           Diskonty_posunute = exp(-Realna_urokova_miera(Mesiac + 1, round(Vyplacanie_posunute * 12)) .* Vyplacanie_posunute); % Diskontné faktory jednotlivých platieb po uplynutí 1 mesiaca od vydania
           Realne_hodnoty_SeLFIES_posunute(Mesiac, Konverzia_SeLFIES) = Mesacna_platba_SeLFIES * sum(Diskonty_posunute); % Reálna hodnota SeLFIES s danou konverziou po uplynutí 1 mesiaca od vydania
        end 
    end
end

% Ukážka vypočítanej reálnej hodnoty SeLFIES pre jednotlivé doby konverzie pre posledné pozorovanie:
Roky_konverzia_SeLFIES = 1:1:40; % Jednotlivé celoročné doby konverzie SeLFIES
Vykreslenie_posledneho_pozorovania(Realne_hodnoty_SeLFIES, Roky_konverzia_SeLFIES, 'Reálna hodnota SeLFIES pre rôzne doby konverzie', 'Reálne hodnoty SeLFIES pre rôzne doby konverzie', 'Hodnoty_SeLFIES') % Vykreslenie vypočítaných reálnych hodnôt SelFIES pre rôzne celoročné konverzie pre posledné pozorovanie

%% Výnosy a volatilita SeLFIES:
% Mesačné logaritmické reálne výnosy SeLFIES:
Mesacny_logaritmicky_realny_vynos_SeLFIES = log(Realne_hodnoty_SeLFIES_posunute(1:end, :) ./ Realne_hodnoty_SeLFIES(1:end - 1, :)); % Mesačný réalny logaritmický výnos jednotlivých SeLFIES s konštantnou dobou konverzie
Mesacny_logaritmicky_realny_vynos_SeLFIES_TT = timetable(Ocakavana_inflacia.Time(2:end), Mesacny_logaritmicky_realny_vynos_SeLFIES); % Vytvorenie časovej tabuľky reálnych logaritmických mesačných výnosov jednotlivých SeLFIES s konštantnou dobou konverzie

% Priemerný reálny ročný logaritmický výnos:
Priemerny_rocny_realny_logaritmicky_vynos_SeLFIES = mean(Mesacny_logaritmicky_realny_vynos_SeLFIES(49:end, :)) * 12; % Priemerný reálny ročný logaritmický výnos jednotlivých SeLFIES s konštantnou dobou konverzie
fprintf('\nPriemerný reálny ročný logaritmický výnos SeLFIES s jednotlivými konštantnými dobami konverzie: \n'); % Vypísanie textu
for Konverzia_SeLFIES = 12:12:480 % Pre každú celoročnú konštantnú konverziu SeLFIES
    fprintf('Konštantná doba konverzie %i-rok.: %.2f %%\n', ...
            round(Cas_do_konverzie_SeLFIES(Konverzia_SeLFIES)), Priemerny_rocny_realny_logaritmicky_vynos_SeLFIES(Konverzia_SeLFIES) * 100); % Vypísanie priemerného reálneho ročného logaritmického výnosu jednotlivých SeLFIES s konštantnou dobou konverzie
end

% Ročná volatilita daného reálneho výnosu:
Mesacna_volatilita_daneho_realneho_vynosu_SeLFIES = std(Mesacny_logaritmicky_realny_vynos_SeLFIES(49:end, :));  % Mesačná volatilita daného reálneho výnosu jednotlivých SeLFIES s konštantnou dobou konverzie
Rocna_volatilita_daneho_realneho_vynosu_SeLFIES = Mesacna_volatilita_daneho_realneho_vynosu_SeLFIES * sqrt(12); % Ročná volatilita daného reálneho výnosu jednotlivých SeLFIES s konštantnou dobou konverzie
fprintf('\nRočná volatilita daného reálneho výnosu SeLFIES s jednotlivými konštantnými dobami konverzie: \n'); % Vypísanie textu
for Konverzia_SeLFIES = 12:12:480 % Pre každú celoročnú konštantnú konverziu SeLFIES
    fprintf('Konštantná doba konverzie %i-rok.: %.2f %%\n', ...
            round(Cas_do_konverzie_SeLFIES(Konverzia_SeLFIES)), Rocna_volatilita_daneho_realneho_vynosu_SeLFIES(Konverzia_SeLFIES) * 100); % Vypísanie ročnej volatility daného reálneho výnosu jednotlivých SeLFIES s konštantnou dobou konverzie
end

% Priemerný reálny ročný aritmetický výnos:
Priemerny_rocny_realny_aritmeticky_vynos_SeLFIES = Priemerny_rocny_realny_logaritmicky_vynos_SeLFIES + (0.5 * Rocna_volatilita_daneho_realneho_vynosu_SeLFIES.^2); % Vypočítaný priemerný reálny ročný aritmetický výnos jednotlivých SeLFIES s konštantnou dobou konverzie
fprintf('\nPriemerný reálny ročný aritmetický výnos SeLFIES s jednotlivými konštantnými dobami konverzie: \n'); % Vypísanie textu
for Konverzia_SeLFIES = 12:12:480 % Pre každú celoročnú konštantnú konverziu SeLFIES
    fprintf('Konštantná doba konverzie %i-rok.: %.2f %%\n', ...
            round(Cas_do_konverzie_SeLFIES(Konverzia_SeLFIES)), Priemerny_rocny_realny_aritmeticky_vynos_SeLFIES(Konverzia_SeLFIES) * 100); % Vypísanie priemerného reálneho ročného aritmetického výnosz jednotlivých SeLFIES s konštantnou dobou konverzie
end

% Reálna hodnota počiatočnej investície v čase:
Pociatocna_investicia_SeLFIES = 1; % Koľko na začiatku investujeme do SeLFIES
Realne_hodnoty_pociatocnej_investicie_SeLFIES = Pociatocna_investicia_SeLFIES * exp(cumsum(Mesacny_logaritmicky_realny_vynos_SeLFIES(49:end, :),1)); % Reálne hodnoty počiatočnej investície do SeLFIES s jednotlivými konštantnými konverziami v každom mesiaci 
Vykreslenie_posledneho_pozorovania(Realne_hodnoty_pociatocnej_investicie_SeLFIES, Roky_konverzia_SeLFIES, 'Reálna hodnota počiatočnej investície do SeLFIES s rôznou konštantnou konverziou', 'Reálne hodnoty počiatočnej investície do SeLFIES s rôznou konštantnou konverziou', 'Hodnoty_investicie_SeLFIES') % Vykreslenie reálnej hodnoty počiatočnej investície v čase v poslednom pozorovaní

%% Reálna hodnota TS:
% Informácie o funkcií bndprice:
help bndprice % stručný help
doc bndprice % podrobný help

% Ocenenie jednotlivých TS s konštantnými maturitami:
Hrube_realne_ceny_TS_2Y = Ocenenie_TS(Vynosy_do_splatnosti_TS, Data_CPI, Maturity_TS, 2); % Hrubá reálna cena TS s konštantnou maturitou 2 roky
Hrube_realne_ceny_TS_3Y = Ocenenie_TS(Vynosy_do_splatnosti_TS, Data_CPI, Maturity_TS, 3); % Hrubá reálna cena TS s konštantnou maturitou 3 roky
Hrube_realne_ceny_TS_5Y = Ocenenie_TS(Vynosy_do_splatnosti_TS, Data_CPI, Maturity_TS, 5); % Hrubá reálna cena TS s konštantnou maturitou 5 rokov
Hrube_realne_ceny_TS_7Y = Ocenenie_TS(Vynosy_do_splatnosti_TS, Data_CPI, Maturity_TS, 7); % Hrubá reálna cena TS s konštantnou maturitou 7 rokov
Hrube_realne_ceny_TS_10Y = Ocenenie_TS(Vynosy_do_splatnosti_TS, Data_CPI, Maturity_TS, 10); % Hrubá reálna cena TS s konštantnou maturitou 10 rokov
Hrube_realne_ceny_TS_20Y = Ocenenie_TS(Vynosy_do_splatnosti_TS, Data_CPI, Maturity_TS, 20); % Hrubá reálna cena TS s konštantnou maturitou 20 rokov
Hrube_realne_ceny_TS_20Y(60, :) = []; % Odstránenie danej hrubej reálnej ceny TS s konštantnou maturitou 20 rokov kvôli nepublikovaným údajom
Hrube_realne_ceny_TS_30Y = Ocenenie_TS(Vynosy_do_splatnosti_TS, Data_CPI, Maturity_TS, 30); % Hrubá reálna cena TS s konštantnou maturitou 30 rokov

Hrube_realne_ceny_TS = synchronize(Hrube_realne_ceny_TS_2Y, Hrube_realne_ceny_TS_3Y, Hrube_realne_ceny_TS_5Y, Hrube_realne_ceny_TS_7Y, Hrube_realne_ceny_TS_10Y, Hrube_realne_ceny_TS_20Y, Hrube_realne_ceny_TS_30Y); % Vytvorenie spoločnej časovej tabuľky reálnych cien TS s konštantnou maturitou 30 rokov

%% Výnosy a volatilita TS:
% Mesačné logaritmické reálne výnosy TS:
Mesacny_logaritmicky_realny_vynos_TS = log(Hrube_realne_ceny_TS{:, :} / 100); % Mesačný logaritmický reálny výnos TS s danými konštantnými maturitami
Mesacny_logaritmicky_realny_vynos_TS_TT = timetable(Vynosy_do_splatnosti_TS.Time(2:end), Mesacny_logaritmicky_realny_vynos_TS); % Vytvorenie časovej tabuľky mesačných logaritmických reálnych výnosov jednotlivých konsťantných TS

% Priemerný reálny ročný logaritmický výnos:
Priemerny_realny_rocny_logaritmicky_vynos_TS = mean(Mesacny_logaritmicky_realny_vynos_TS(49:end, :), 'omitnan') * 12;  % Priemerný reálny ročný logaritmický výnos jednotlivých typov konštantných TS
fprintf('\nPriemerný reálny ročný logaritmický výnos TS s jednotlivými konštantnými maturitami: \n'); % Vypísanie textu
for Maturita_TS = 1:width(Hrube_realne_ceny_TS) % Pre každú skúmanú konštantnú maturitu TS
    fprintf('Konštantná maturita %i-rok.: %.2f %%\n', ...
            Maturity_TS(4 + Maturita_TS), Priemerny_realny_rocny_logaritmicky_vynos_TS(Maturita_TS) * 100); % Vypísanie priemerného reálneho ročného logaritmického výnosu konštantných TS s jednotlivými skúmanými maturitami
end

% Ročná volatilita daného reálneho výnosu:
Mesacna_volatilita_daneho_realneho_vynosu_TS = std(Mesacny_logaritmicky_realny_vynos_TS(49:end, :), 'omitnan');  % Mesačná volatilita daného reálneho výnosu konštantných TS s danými maturitami
Rocna_volatilita_daneho_realneho_vynosu_TS = Mesacna_volatilita_daneho_realneho_vynosu_TS * sqrt(12); % Volatilita daného reálneho výnosu jednotlivých TS s danými konštantnými maturitami
fprintf('\nRočná volatilita daného reálneho výnosu TS s jednotlivými konštantnými maturitami: \n'); % Vypísanie textu
for Maturita_TS = 1:width(Hrube_realne_ceny_TS) % Pre každú skúmanú konštantnú maturitu TS
    fprintf('Konštantná maturita %i-rok.: %.2f %%\n', ...
            Maturity_TS(4 + Maturita_TS), Rocna_volatilita_daneho_realneho_vynosu_TS(Maturita_TS) * 100); % Vypísanie ročnej volatility daného reálneho výnosu konštantných TS so skúmanými maturitami
end

% Priemerný reálny ročný aritmetický výnos:
Priemerny_realny_rocny_aritmeticky_vynos_TS = Priemerny_realny_rocny_logaritmicky_vynos_TS + (0.5 * Rocna_volatilita_daneho_realneho_vynosu_TS.^2); % Vypočítaný priemerný reálny ročný aritmetický výnos jednotlivých typov TS s konštantnými maturitami
fprintf('\nPriemerný reálny ročný aritmetický výnos TS s jednotlivými konštantnými maturitami: \n'); % Vypísanie textu
for Maturita_TS = 1:width(Hrube_realne_ceny_TS) % Pre každú skúmanú konštantnú maturitu TS
    fprintf('Konštantná maturita %i-rok.: %.2f %%\n', ...
            Maturity_TS(4 + Maturita_TS), Priemerny_realny_rocny_aritmeticky_vynos_TS(Maturita_TS) * 100); % Vypísanie priemerného reálneho ročného aritmetického výnosu TS so skúmanými konštantnými maturitami
end

% Reálna hodnota počiatočnej investície v čase:
Pociatocna_investicia_TS = 1; % Koľko na začiatku investujeme do TS
Realne_hodnoty_pociatocnej_investicie_TS = Pociatocna_investicia_TS * exp(cumsum(fillmissing(Mesacny_logaritmicky_realny_vynos_TS(49:end, :), 'constant', 0), 1)); % Reálne hodnoty počiatočnej investície do TS s jednotlivými konštantnými maturitami v každom mesiaci 
Vykreslenie_posledneho_pozorovania(Realne_hodnoty_pociatocnej_investicie_TS(:, [1:5, 7]), Maturity_TS(([5:9, 11])), 'Reálna hodnota počiatočnej investície do TS s rôznym konštantnými maturitami', 'Reálne hodnoty počiatočnej investície do TS s rôznym konštantnými maturitami', 'Hodnoty_investicie_TS') % Vykreslenie reálnej hodnoty počiatočnej investície do TS s rôznym konštantnými maturitami

%% Reálna hodnota TIPS:
Maturity_TIPS = [5 7 10 20 30]; % Konštantné maturity jednotlivých TIPS

% Ocenenie jednotlivých TIPS s konštantnými maturitami:
Hrube_realne_ceny_TIPS_5Y = Ocenenie_TIPS(Vynosy_do_splatnosti_TIPS, Maturity_TIPS, 5); % Hrubé reálne ceny TIPS s konštantnou maturitou 5 rokov
Hrube_realne_ceny_TIPS_7Y = Ocenenie_TIPS(Vynosy_do_splatnosti_TIPS, Maturity_TIPS, 7); % Hrubé reálne ceny TIPS s konštantnou maturitou 7 rokov
Hrube_realne_ceny_TIPS_10Y = Ocenenie_TIPS(Vynosy_do_splatnosti_TIPS, Maturity_TIPS, 10); % Hrubé reálne ceny TIPS s konštantnou maturitou 10 rokov
Hrube_realne_ceny_TIPS_20Y = Ocenenie_TIPS(Vynosy_do_splatnosti_TIPS, Maturity_TIPS, 20); % Hrubé reálne ceny TIPS s konštantnou maturitou 20 rokov
Hrube_realne_ceny_TIPS_30Y = Ocenenie_TIPS(Vynosy_do_splatnosti_TIPS, Maturity_TIPS, 30); % Hrubé reálne ceny TIPS s konštantnou maturitou 30 rokov

Hrube_realne_ceny_TIPS = synchronize(Hrube_realne_ceny_TIPS_5Y, Hrube_realne_ceny_TIPS_7Y, Hrube_realne_ceny_TIPS_10Y, Hrube_realne_ceny_TIPS_20Y, Hrube_realne_ceny_TIPS_30Y); % Vytvorenie spoločnej časovej tabuľky hrubých reálnych cien jednotlivých TIPS s konštantnými maturitami

%% Výnosy a volatilita TIPS:
% Mesačné logaritmické reálne výnosy TIPS:
Mesacny_logaritmicky_realny_vynos_TIPS = log(Hrube_realne_ceny_TIPS{:, :} / 100); % Mesačný logaritmický reálny výnos TIPS s danými konštantnými maturitami
Mesacny_logaritmicky_realny_vynos_TIPS_TT = timetable(Vynosy_do_splatnosti_TIPS.Time(2:end), Mesacny_logaritmicky_realny_vynos_TIPS); % Vytvorenie časovej tabuľky mesačných logaritmických reálnych výnosov jednotlivých konštantných TIPS

% Priemerný reálny ročný logaritmický výnos:
Priemerny_realny_rocny_logaritmicky_vynos_TIPS = mean(Mesacny_logaritmicky_realny_vynos_TIPS, 'omitnan') * 12;  % Priemerný reálny ročný logaritmický výnos jednotlivých typov konštantných TIPS
fprintf('\nPriemerný reálny ročný logaritmický výnos TIPS s jednotlivými konštantnými maturitami: \n'); % Vypísanie textu
for Maturita_TIPS = 1:width(Hrube_realne_ceny_TIPS) % Pre každú skúmanú konštantnú maturitu TIPS
    fprintf('Konštantná maturita %i-rok.: %.2f %%\n', ...
            Maturity_TIPS(Maturita_TIPS), Priemerny_realny_rocny_logaritmicky_vynos_TIPS(Maturita_TIPS) * 100); % Vypísanie priemerného reálneho ročného logaritmického výnosu konštantných TIPS s jednotlivými skúmanými maturitami
end

% Ročná volatilita daného reálneho výnosu:
Mesacna_volatilita_daneho_realneho_vynosu_TIPS = std(Mesacny_logaritmicky_realny_vynos_TIPS, 'omitnan');  % Mesačná volatilita daného reálneho výnosu konštantných TIPS s danými maturitami
Rocna_volatilita_daneho_realneho_vynosu_TIPS = Mesacna_volatilita_daneho_realneho_vynosu_TIPS * sqrt(12); % Ročná volatilita daného reálneho výnosu konštantných TIPS s danými maturitami
fprintf('\nRočná volatilita daného reálneho výnosu TIPS s jednotlivými konštantnými maturitami: \n'); % Vypísanie textu
for Maturita_TIPS = 1:width(Hrube_realne_ceny_TIPS) % Pre každú skúmanú konštantnú maturitu TIPS
    fprintf('Konštantná maturita %i-rok.: %.2f %%\n', ...
            Maturity_TIPS(Maturita_TIPS), Rocna_volatilita_daneho_realneho_vynosu_TIPS(Maturita_TIPS) * 100); % Vypísanie ročnej volatility daného reálneho výnosu konštantných TIPS so skúmanými maturitami
end

% Priemerný reálny ročný aritmetický výnos:
Priemerny_realny_rocny_aritmeticky_vynos_TIPS = Priemerny_realny_rocny_logaritmicky_vynos_TIPS + (0.5 * Rocna_volatilita_daneho_realneho_vynosu_TIPS.^2); % Vypočítaný priemerný reálny ročný aritmetický výnos jednotlivých typov TIPS s konštantnými maturitami
fprintf('\nPriemerný reálny ročný aritmetický výnos TIPS s jednotlivými konštantnými maturitami: \n'); % Vypísanie textu
for Maturita_TIPS = 1:width(Hrube_realne_ceny_TIPS) % Pre každú skúmanú konštantnú maturitu TIPS
    fprintf('Konštantná maturita %i-rok.: %.2f %%\n', ...
            Maturity_TIPS(Maturita_TIPS), Priemerny_realny_rocny_aritmeticky_vynos_TIPS(Maturita_TIPS) * 100); % Vypísanie priemerného reálneho ročného aritmetického výnosu TIPS so skúmanými konštantnými maturitami
end

%% Reálna hodnota S&P 500:
Realna_hodnota_SAP_500 = zeros(length(Nominalne_hodnoty_SAP_500.Time), 1); % Inicializácia vektora reálnych hodnôt akciového indexu S&P 500

for Mesiac = 1:(length(Nominalne_hodnoty_SAP_500.Time))  % Pre každý mesiac
    Index_CPI = find(Data_CPI.Time == Nominalne_hodnoty_SAP_500.Time(Mesiac)); % Index CPI v dátume, kedy počítame reálnu hodnotu akciového indexu S&P 500
    Realna_hodnota_SAP_500(Mesiac) = Nominalne_hodnoty_SAP_500.Nominalna_hodnota_SAP_500(Mesiac) / (Data_CPI.CPI(Index_CPI) / Data_CPI.CPI(1)); % Vypočet reálnej hodnoty akciového indexu S&P 500
end  

Realne_hodnoty_SAP_500 = timetable(Nominalne_hodnoty_SAP_500.Time, Realna_hodnota_SAP_500); % Vytvorenie časovej tabuľky reálnych hodnôt akciového indexu S&P 500

%% Výnosy a volatilita S&P 500:
% Mesačné logaritmické reálne výnosy S&P 500:
Mesacny_logaritmicky_realny_vynos_SAP_500 = log(Realne_hodnoty_SAP_500{2:end, :} ./ Realne_hodnoty_SAP_500{1:end-1, :}); % Mesačné logaritmické reálne výnosy akciového indexu S&P 500
Mesacny_logaritmicky_realny_vynos_SAP_500_TT = timetable(Realne_hodnoty_SAP_500.Time(2:end), Mesacny_logaritmicky_realny_vynos_SAP_500); % Vytvorenie časovej tabuľky mesačných reálnych logaritmických výnosov akciového indexu S&P 500

% Priemerný reálny ročný logaritmický výnos:
Priemerny_realny_rocny_logaritmicky_vynos_SAP_500 = mean(Mesacny_logaritmicky_realny_vynos_SAP_500(49:end)) * 12; % Priemerný reálny ročný logaritmický výnos akciového indexu S&P 500
fprintf('\nPriemerný reálny ročný logaritmický výnos akciového indexu S&P 500: %.2f %% \n', Priemerny_realny_rocny_logaritmicky_vynos_SAP_500 * 100); % Vypísanie priemerného reálneho ročného logaritmického výnosu akciového indexu S&P 500

% Ročná volatilita daného reálneho výnosu:
Mesacna_volatilita_daneho_realneho_vynosu_SAP_500 = std(Mesacny_logaritmicky_realny_vynos_SAP_500(49:end));  % Mesačná volatilita daného reálneho výnosu akciového indexu S&P 500
Rocna_volatilita_daneho_realneho_vynosu_SAP_500 = Mesacna_volatilita_daneho_realneho_vynosu_SAP_500 * sqrt(12); % Ročná volatilita daného reálneho výnosu akciového indexu S&P 500
fprintf('\nRočná volatilita daného reálneho výnosu akciového indexu S&P 500: %.2f %% \n', Rocna_volatilita_daneho_realneho_vynosu_SAP_500 * 100); % Vypísanie ročnej volatility daného reálneho výnosu akciového indexu S&P 500

% Priemerný reálny ročný aritmetický výnos:
Priemerny_realny_rocny_aritmeticky_vynos_SAP_500 = Priemerny_realny_rocny_logaritmicky_vynos_SAP_500 + (0.5 * Rocna_volatilita_daneho_realneho_vynosu_SAP_500^2); % Vypočítaný priemerný reálny ročný aritmetický výnos akciového indexu S&P 500
fprintf('\nPriemerný reálny ročný aritmetický výnos akciového indexu S&P 500: %.2f %% \n', Priemerny_realny_rocny_aritmeticky_vynos_SAP_500 * 100); % Vypísanie priemerného reálneho ročného aritmetického výnosu akciového indexu S&P 500

% Reálna hodnota počiatočnej investície v čase:
Pociatocna_investicia_SAP_500 = 1; % Koľko na začiatku investujeme do akciového indexu S&P 500
Realna_hodnota_pociatocnej_investicie_SAP_500 = Pociatocna_investicia_SAP_500 * exp(cumsum(Mesacny_logaritmicky_realny_vynos_SAP_500(49:end), 1)); % Reálne hodnoty počiatočnej investície do akciového indexu S&P 500 v každom mesiaci
Konecna_realna_hodnota_pociatocnej_investicie_SAP_500 = Realna_hodnota_pociatocnej_investicie_SAP_500(end); % Konečná reálna hodnota počiatočnej investície do akciového indexu S&P 500
fprintf('\nKonečná reálna hodnota počiatočnej investície do akciového indexu S&P 500: %.2f\n', Konecna_realna_hodnota_pociatocnej_investicie_SAP_500); % Vypísanie konečnej reálnej hodnoty počiatočnej investície do akciového indexu S&P 500

%% Reálny príjem z hodnoty finančného nástroja
Konstantne_konverzie_rocne_SeLFIES = 1:40; % Všetky celoročné konštantné konverzie SeLFIES

Priemerne_realne_rocne_aritmeticke_vynosy_TS_SAP_500 = [Priemerny_realny_rocny_aritmeticky_vynos_TS([1:5, 7]), Priemerny_realny_rocny_aritmeticky_vynos_SAP_500];  % Vektor priemerných reálnych ročných aritmetických výnosov TS s konštantnými celoročnými konverziami 2, 3, 5, 7, 10 a 30 rokov a indexu S&P 500 

Drift_M_i_tilde = zeros(length(Konstantne_konverzie_rocne_SeLFIES), 13); % Inicializácia matice driftov reálneho príjmu z hodnoty finančného nástroja 
Volatilita_M_i_tilde = zeros(length(Konstantne_konverzie_rocne_SeLFIES), 13); % Inicializácia matice volatilít reálneho príjmu z hodnoty finančného nástroja 

for Konverzia = 1:(length(Konstantne_konverzie_rocne_SeLFIES)) % Pre každú celoročnú konštantnú konverziu SeLFIES
    % Časové tabuľky logaritmických reálnych mesačných výnosov finančných nástrojov a SeLFIES:
    Mesacny_realny_logaritmicky_vynos_daneho_SeLFIES_TT = timetable(Mesacny_logaritmicky_realny_vynos_SeLFIES_TT.Time, ...
                                                                    Mesacny_logaritmicky_realny_vynos_SeLFIES_TT.Mesacny_logaritmicky_realny_vynos_SeLFIES(:, 12 * Konverzia), ...
                                                                    'VariableNames', {'Mesacny_logaritmicky_realny_vynos_daneho_SeLFIES'}); % Vytvorenie časovej tabuľky mesačných logaritmických reálnych výnosov SeLFIES s danou celoročnou konštantnou konverziou
    Mesacne_realne_logaritmicke_vynosy_TS_SAP_500_SeLFIES_TT = synchronize(Mesacny_logaritmicky_realny_vynos_TS_TT, ...
                                                                           Mesacny_logaritmicky_realny_vynos_SAP_500_TT, ...
                                                                           Mesacny_realny_logaritmicky_vynos_daneho_SeLFIES_TT); % Vytvorenie časovej tabuľky mesačných reálnych logaritmických výnosov TS, S&P 500 a SeLFIES s danou celoročnou konštantnou konverziou
    Mesacne_realne_logaritmicke_vynosy_TIPS_SeLFIES_TT = synchronize(Mesacny_logaritmicky_realny_vynos_TIPS_TT(86:end, :), ...
                                                                     Mesacny_realny_logaritmicky_vynos_daneho_SeLFIES_TT(338:end, :)); % Vytvorenie časovej tabuľky mesačných reálnych logaritmických výnosov TIPS a SeLFIES s danou celoročnou konštantnou konverziou
    
    % Matice mesačných reálnych logaritmických výnosov finančných nástrojov a SeLFIES:
    Mesacne_realne_logaritmicke_vynosy_TS_SAP_500_SeLFIES = [Mesacne_realne_logaritmicke_vynosy_TS_SAP_500_SeLFIES_TT.Mesacny_logaritmicky_realny_vynos_TS(49:end, [1:5, 7]), ...
                                                             Mesacne_realne_logaritmicke_vynosy_TS_SAP_500_SeLFIES_TT.Mesacny_logaritmicky_realny_vynos_SAP_500(49:end), ...
                                                             Mesacne_realne_logaritmicke_vynosy_TS_SAP_500_SeLFIES_TT.Mesacny_logaritmicky_realny_vynos_daneho_SeLFIES(49:end)]; % Matica logaritmických reálnych mesačných výnosov TS s konštantnými maturitami 2, 3, 5, 7, 10 a 30 rokov, S&P 500 a SeLFIES s danou celoročnou konštantnou konverziou
    Mesacne_realne_logaritmicke_vynosy_TS_20_SeLFIES = [Mesacne_realne_logaritmicke_vynosy_TS_SAP_500_SeLFIES_TT.Mesacny_logaritmicky_realny_vynos_TS([49:59, 142:end], 6), ...
                                                        Mesacne_realne_logaritmicke_vynosy_TS_SAP_500_SeLFIES_TT.Mesacny_logaritmicky_realny_vynos_daneho_SeLFIES([49:59, 142:end])]; % Matica logaritmických reálnych mesačných výnosov TS s konštantnou celoročnou maturitou 20 rokov a SeLFIES s danou celoročnou konštantnou konverziou
    Mesacne_realne_logaritmicke_vynosy_TIPS_SeLFIES = [Mesacne_realne_logaritmicke_vynosy_TIPS_SeLFIES_TT.Mesacny_logaritmicky_realny_vynos_TIPS, ...
                                                       Mesacne_realne_logaritmicke_vynosy_TIPS_SeLFIES_TT.Mesacny_logaritmicky_realny_vynos_daneho_SeLFIES]; % Matica logaritmických reálnych mesačných výnosov TIPS a SeLFIES s danou celoročnou konštantnou konverziou

    % Ročné kovariančné matice reálnych logaritmických výnosov finančných nástrojov a SeLFIES:
    Rocna_kovariancna_matica_realne_logaritmicke_vynosy_TS_SAP_500_SeLFIES = 12 * cov(Mesacne_realne_logaritmicke_vynosy_TS_SAP_500_SeLFIES); % Ročná kovariančná matica reálnych logaritmických výnosov TS s konštantnými maturitami 2, 3, 5, 7, 10 a 30 rokov, S&P 500 a SeLFIES s danou celoročnou konštantnou konverziou
    Rocna_kovariancna_matica_realne_logaritmicke_vynosy_TS_20_SeLFIES = 12 * cov(Mesacne_realne_logaritmicke_vynosy_TS_20_SeLFIES); % Ročná kovariančná matica reálnych logaritmických výnosov TS s konštantnou celoročnou maturitou 20 rokov a SeLFIES s danou celoročnou konštantnou konverziou
    Rocna_kovariancna_matica_realne_logaritmicke_vynosy_TIPS_SeLFIES = 12 * cov(Mesacne_realne_logaritmicke_vynosy_TIPS_SeLFIES); % Ročná kovariančná matica reálnych logaritmických výnosov TIPS a SeLFIES s danou celoročnou konštantnou konverziou
    
    % Choleského rozklady ročných kovariančných matíc reálnych logaritmických výnosov finančných nástrojov a SeLFIES:
    Choleskeho_rozklad_TS_SAP_500_SeLFIES = chol(Rocna_kovariancna_matica_realne_logaritmicke_vynosy_TS_SAP_500_SeLFIES , 'lower'); % Choleského rozklad ročnej kovariančnej matice reálnych logaritmických výnosov TS s konštantnými maturitami 2, 3, 5, 7, 10 a 30 rokov, S&P 500 a SeLFIES s danou celoročnou konštantnou konverziou
    Choleskeho_rozklad_TS_20_SeLFIES = chol(Rocna_kovariancna_matica_realne_logaritmicke_vynosy_TS_20_SeLFIES , 'lower'); % Choleského rozklad ročnej kovariančnej matice reálnych logaritmických výnosov TS s konštantnou celoročnou maturitou 20 rokov a SeLFIES s danou celoročnou konštantnou konverziou
    Choleskeho_rozklad_TIPS_SeLFIES = chol(Rocna_kovariancna_matica_realne_logaritmicke_vynosy_TIPS_SeLFIES , 'lower'); % Choleského rozklad ročnej kovariančnej matice reálnych logaritmických výnosov TIPS a SeLFIES s danou celoročnou konštantnou konverziou
    
    Priemerny_rocny_realny_aritmeticky_vynos_SeLFIES_obdobie_TS_20 = 12 * mean(Mesacne_realne_logaritmicke_vynosy_TS_20_SeLFIES(:, 2)) + 0.5 * 12 * var(Mesacne_realne_logaritmicke_vynosy_TS_20_SeLFIES(:, 2)); % Priemerný reálny ročný aritmetický výnos SeLFIES za spoločné skúmané obdobie s americkým štátnym dlhopisom s konštantnou maturitou 20 rokov
    Priemerne_rocne_realne_aritmeticke_vynosy_TIPS_obdobie_TIPS = 12 * mean(Mesacne_realne_logaritmicke_vynosy_TIPS_SeLFIES(:, 1:5)) + 0.5 * 12 * var(Mesacne_realne_logaritmicke_vynosy_TIPS_SeLFIES(:, 1:5)); % Priemerný reálny ročný aritmetický výnos TIPS za spoločné skúmané obdobie 
    Priemerny_rocny_realny_aritmeticky_vynos_SeLFIES_obdobie_TIPS = 12 * mean(Mesacne_realne_logaritmicke_vynosy_TIPS_SeLFIES(:, 6)) + 0.5 * 12 * var(Mesacne_realne_logaritmicke_vynosy_TIPS_SeLFIES(:, 6)); % Priemerný reálny ročný aritmetický výnos SeLFIES za spoločné skúmané obdobie s TIPS
    
    % Vypočet driftu a volatility reálneho príjmu z hodnoty finančného nástroja:
        for Financny_nastroj = 1:13 % Pre každý skúmaný finančný nástroj
            if Financny_nastroj <= 7 % Pre TS s konštantnými celoročnými maturitami 2, 3, 5, 7, 10 a 30 rokov a akciový index S&P 500
               Drift_M_i_tilde(Konverzia, Financny_nastroj) = Priemerne_realne_rocne_aritmeticke_vynosy_TS_SAP_500(Financny_nastroj) - Priemerny_rocny_realny_aritmeticky_vynos_SeLFIES(12 * Konverzia) + (Choleskeho_rozklad_TS_SAP_500_SeLFIES(end, :) * (Choleskeho_rozklad_TS_SAP_500_SeLFIES(end, :)')) - (Choleskeho_rozklad_TS_SAP_500_SeLFIES(Financny_nastroj, :) * (Choleskeho_rozklad_TS_SAP_500_SeLFIES(end, :)')); % Drift reálneho príjmu z hodnoty finančného nástroja
               Volatilita_M_i_tilde(Konverzia, Financny_nastroj) = sqrt((Choleskeho_rozklad_TS_SAP_500_SeLFIES(Financny_nastroj, :) - Choleskeho_rozklad_TS_SAP_500_SeLFIES(end, :)) * ((Choleskeho_rozklad_TS_SAP_500_SeLFIES(Financny_nastroj, :) - Choleskeho_rozklad_TS_SAP_500_SeLFIES(end, :))')); % Volatilita reálneho príjmu z hodnoty finančného nástroja
            elseif Financny_nastroj == 8 % Pre TS s konštantnou celoročnou maturitou 20 rokov
                   Drift_M_i_tilde(Konverzia, Financny_nastroj) = Priemerny_realny_rocny_aritmeticky_vynos_TS(6) - Priemerny_rocny_realny_aritmeticky_vynos_SeLFIES_obdobie_TS_20 + (Choleskeho_rozklad_TS_20_SeLFIES(end, :) * (Choleskeho_rozklad_TS_20_SeLFIES(end, :)')) - (Choleskeho_rozklad_TS_20_SeLFIES(1, :) * (Choleskeho_rozklad_TS_20_SeLFIES(end, :)')); % Drift reálneho príjmu z hodnoty finančného nástroja
                   Volatilita_M_i_tilde(Konverzia, Financny_nastroj) = sqrt((Choleskeho_rozklad_TS_20_SeLFIES(1, :) - Choleskeho_rozklad_TS_20_SeLFIES(end, :)) * ((Choleskeho_rozklad_TS_20_SeLFIES(1, :) - Choleskeho_rozklad_TS_20_SeLFIES(end, :))')); % Volatilita reálneho príjmu z hodnoty finančného nástroja 
            else % Pre TIPS
                 Drift_M_i_tilde(Konverzia, Financny_nastroj) = Priemerne_rocne_realne_aritmeticke_vynosy_TIPS_obdobie_TIPS(Financny_nastroj - 8) - Priemerny_rocny_realny_aritmeticky_vynos_SeLFIES_obdobie_TIPS + (Choleskeho_rozklad_TIPS_SeLFIES(end, :) * (Choleskeho_rozklad_TIPS_SeLFIES(end, :)')) - (Choleskeho_rozklad_TIPS_SeLFIES(Financny_nastroj - 8, :) * (Choleskeho_rozklad_TIPS_SeLFIES(end, :)')); % Drift reálneho príjmu z hodnoty finančného nástroja
                 Volatilita_M_i_tilde(Konverzia, Financny_nastroj) = sqrt((Choleskeho_rozklad_TIPS_SeLFIES(Financny_nastroj - 8, :) - Choleskeho_rozklad_TIPS_SeLFIES(end, :)) * ((Choleskeho_rozklad_TIPS_SeLFIES(Financny_nastroj - 8, :) - Choleskeho_rozklad_TIPS_SeLFIES(end, :))')); % Volatilita reálneho príjmu z hodnoty finančného nástroja
            end
        end
end

% Vypísanie kovariančnej matice reálnych logaritmických výnosov TS s konštantnými maturitami 2, 3, 5, 7, 10 a 30 rokov, S&P 500 a SeLFIES s 40 ročnou konštantnou konverziou:
Nazvy_kovariancia_korelacia = {'TS 2','TS 3','TS 5','TS 7','TS 10','TS 30','S&P 500', 'SeLFIES 40'}; % Názvy riadkov, respektíve stĺpcov kovariančnej/korelačnej matice
Kovariancna_matica_40 = array2table(Rocna_kovariancna_matica_realne_logaritmicke_vynosy_TS_SAP_500_SeLFIES, 'VariableNames', Nazvy_kovariancia_korelacia, 'RowNames', Nazvy_kovariancia_korelacia); % Vytvorenie tabuľky s kovariančnou maticou reálnych logaritmických výnosov TS s konštantnými maturitami 2, 3, 5, 7, 10 a 30 rokov, S&P 500 a SeLFIES s 40 ročnou konštantnou konverziou
Kovariancna_matica_40{:,:} = round(Kovariancna_matica_40{:,:}, 4); % Zaokrúhlenie na 4 desatinné miesta
disp(Kovariancna_matica_40) % Vypísanie kovariančnej matice reálnych logaritmických výnosov TS s konštantnými maturitami 2, 3, 5, 7, 10 a 30 rokov, S&P 500 a SeLFIES s 40 ročnou konštantnou konverziou

% Vypísanie Choleského rozkladu kovariančnej matice reálnych logaritmických výnosov TS s konštantnými maturitami 2, 3, 5, 7, 10 a 30 rokov, S&P 500 a SeLFIES s 40 ročnou konštantnou konverziou:
Choleskeho_rozklad_40 = array2table(Choleskeho_rozklad_TS_SAP_500_SeLFIES, 'VariableNames', Nazvy_kovariancia_korelacia, 'RowNames', Nazvy_kovariancia_korelacia); % Vytvorenie tabuľky s Choleského rozkladom kovariančnej matice reálnych logaritmických výnosov TS s konštantnými maturitami 2, 3, 5, 7, 10 a 30 rokov, S&P 500 a SeLFIES s 40 ročnou konštantnou konverziou:
Choleskeho_rozklad_40{:,:} = round(Choleskeho_rozklad_40{:,:}, 4); % Zaokrúhlenie na 4 desatinné miesta
disp(Choleskeho_rozklad_40) % Vypísanie Choleského rozkladu kovariančnej matice reálnych logaritmických výnosov TS s konštantnými maturitami 2, 3, 5, 7, 10 a 30 rokov, S&P 500 a SeLFIES s 40 ročnou konštantnou konverziou

% Vypísanie driftu a volatility reálneho príjmu z hodnoty finančného nástroja:
Skumane_konstantne_konverzie_SeLFIES = [10 20 30 40]; % Pre ktoré konštantné celoročné konverzie SeLFIES chceme drift a volatilitu reálneho príjmu z hodnoty finančného nástroja
Nazvy_financnych_nastrojov = {'TS 2','TS 3','TS 5','TS 7','TS 10','TS 30', 'S&P 500', ...
                              'TS 20', ...
                              'TIPS 5','TIPS 7','TIPS 10','TIPS 20','TIPS 30'}; % Názvy jednotlivých finančných nástrojov

% Vytvorenie tabuliek driftu a volatility reálneho príjmu z hodnoty finančného nástroja pre jednotlivé skúmané konštantné celoročné konverzie SeLFIES:
Tabulka_drift = array2table(Drift_M_i_tilde(Skumane_konstantne_konverzie_SeLFIES, :), ...
                            'VariableNames', Nazvy_financnych_nastrojov, ...
                            'RowNames', compose('Konštantná konverzia SeLFIES %d', Skumane_konstantne_konverzie_SeLFIES)); % Tabuľka driftu reálneho príjmu z hodnoty finančného nástroja pre jednotlivé skúmané konštantné celoročné konverzie SeLFIES
Tabulka_volatilita = array2table(Volatilita_M_i_tilde(Skumane_konstantne_konverzie_SeLFIES, :), ...
                                 'VariableNames', Nazvy_financnych_nastrojov, ...
                                 'RowNames', compose('Konštantná konverzia SeLFIES %d', Skumane_konstantne_konverzie_SeLFIES)); % Tabuľka volatility reálneho príjmu z hodnoty finančného nástroja pre jednotlivé skúmané konštantné celoročné konverzie SeLFIES

% Zaokrúhlenie hodnôt v tabuľkách na 4 desatinné miesta a prepočet na percentá
Tabulka_drift{:,:} = round(Tabulka_drift{:,:}, 4) * 100; % Zaokrúhlenie na 4 desatinné miesta a prepočet na percentá
Tabulka_volatilita{:,:} = round(Tabulka_volatilita{:,:}, 4) * 100; % Zaokrúhlenie na 4 desatinné miesta a prepočet na percentá

% Vypísanie tabuliek:
disp('Drift (%)'); % Vypísanie textu
disp(Tabulka_drift); % Vypísanie tabuľky driftu reálneho príjmu z hodnoty finančného nástroja pre jednotlivé skúmané konštantné celoročné konverzie SeLFIES
disp('Volatilita (%)'); % Vypísanie textu
disp(Tabulka_volatilita); % Vypísanie tabuľky volatility reálneho príjmu z hodnoty finančného nástroja pre jednotlivé skúmané konštantné celoročné konverzie SeLFIES

% Vypísanie korelačnej matice reálnych logaritmických výnosov TS s konštantnými maturitami 2, 3, 5, 7, 10 a 30 rokov, S&P 500 a SeLFIES s 40 ročnou konštantnou konverziou:
Korelacna_matica_40 = corrcov(Rocna_kovariancna_matica_realne_logaritmicke_vynosy_TS_SAP_500_SeLFIES); % Prepočet ročnej kovariančnej matice reálnych logaritmických výnosov TS s konštantnými maturitami 2, 3, 5, 7, 10 a 30 rokov, S&P 500 a SeLFIES s 40 ročnou konštantnou konverziou na korelačnú maticu
Korelacna_matica_40 = array2table(Korelacna_matica_40, 'VariableNames', Nazvy_kovariancia_korelacia, 'RowNames', Nazvy_kovariancia_korelacia); % Vytvorenie tabuľky s korelačnou maticou reálnych logaritmických výnosov TS s konštantnými maturitami 2, 3, 5, 7, 10 a 30 rokov, S&P 500 a SeLFIES s 40 ročnou konštantnou konverziou
Korelacna_matica_40{:,:} = round(Korelacna_matica_40{:,:}, 4); % Zaokrúhlenie na 4 desatinné miesta
disp(Korelacna_matica_40) % Vypísanie korelačnej matice reálnych logaritmických výnosov TS s konštantnými maturitami 2, 3, 5, 7, 10 a 30 rokov, S&P 500 a SeLFIES s 40 ročnou konštantnou konverziou

%% Vykreslenie závislosti alokácie do S&P 500 od AFS, respektíve AFS - TFS pre jednotlivé nastavenia GLIDeS:  
% Farby do grafu:
Farby = [0.64 0.08 0.18; % Tmavo červená
         0.00 0.50 0.00; % Tmavo zelená
         0.25 0.25 0.25]; % Tmavo sivá

AFS = linspace(0, 2, 1000); % Inicializácia aktuálneho stavu financovania (AFS)
AFS_TFS = linspace(-1, 1, 1000); % Inicializácia rozdielu aktuálneho stavu financovania (AFS) a cieľového stavu financovania (TFS) 

% Hodnoty parametrov pre jednotlivé nastavenia GLIDeS:
% Hodnoty parametra k pre jednotlivé nastavenia lineárnych GLIDeS:
Hodnoty_k = [0.5, 1, 1.5]; % Hodnoty parametra k

% Hodnoty parametrov l a z pre jednotlivé nastavenia spojitých GLIDeS:
Hodnoty_l = [9, 8, 5]; % Hodnoty parametra l
Hodnoty_z = [0.9, 0.8, 0.5]; % Hodnoty parametra z

% Hodnoty parametra b pre jednotlivé nastavenia AFS-TFS GLIDeS:
Hodnoty_b = [7, 3, 1]; % Hodnoty parametra b

% Názvy jednotlivých nastavení GLIDeS do legendy:
% Názvy jednotlivých nastavení lineárnych GLIDeS do legendy:
Nazvy_legenda_linearne_GLIDeS = {'Agresívne (k = 0,5)', ... % Agresívne lineárne GLIDeS
                                 'Mierne (k = 1)', ... % Mierne lineárne GLIDeS
                                 'Konzervatívne (k = 1,5)'}; % Konzervatívne lineárne GLIDeS

% Názvy jednotlivých nastavení spojitých GLIDeS do legendy:
Nazvy_legenda_spojite_GLIDeS = {'Agresívne (l = 9 a z = 0,9)', ... % Agresívne spojité GLIDeS
                                'Mierne (l = 8 a z = 0,8)', ... % Mierne spojité GLIDeS
                                'Konzervatívne (l = 5 a z = 0,5)'}; % Konzervatívne spojité GLIDeS

% Názvy jednotlivých nastavení AFS-TFS GLIDeS do legendy:
Nazvy_legenda_AFS_TFS_GLIDeS = {'Silné (b = 7)', ... % Silné AFS-TFS GLIDeS
                                'Mierne (b = 3)', ... % Mierne AFS-TFS GLIDeS
                                'Slabé (b = 1)'}; % Slabé AFS-TFS GLIDeS

% Vykreslenie závislosti alokácie do S&P 500 od AFS pre jednotlivé GLIDeS:
% Vykreslenie závislosti alokácie do S&P 500 od AFS pre lineárne GLIDeS:
Alokacia_SAP_500_linearne_GLIDeS = zeros(1, length(AFS)); % Inicializácia vektora alokácie do S&P 500 pre lineárne GLIDeS
figure; % Nové grafické okno
hold on; % Kreslenie do rovnakého grafického okna
for Nastavenie = 1:width(Nazvy_legenda_linearne_GLIDeS) % Pre každé jedno nastavenie lineárnych GLIDeS
    k = Hodnoty_k(Nastavenie); % Hodnota parametra k
    for Index_AFS = 1:length(AFS) % Pre každú jednu hodnotu AFS
        if AFS(Index_AFS) < 1 % Ak je AFS pod hodnotou 1
           Alokacia_SAP_500_linearne_GLIDeS(Index_AFS) = max(1 - k * AFS(Index_AFS), 0); % Alokácia do S&P 500 pre lineárne GLIDeS
        else % Ak nie je AFS pod hodnotou 1
             Alokacia_SAP_500_linearne_GLIDeS(Index_AFS) = 0; % Alokácia do S&P 500 pre lineárne GLIDeS
        end
    end    
    plot(AFS * 100, Alokacia_SAP_500_linearne_GLIDeS * 100, ... % Vykreslenie závislosti alokácie do S&P 500 od AFS pre lineárne GLIDeS
         'Color', Farby(Nastavenie, :), ... % Farba čiary
         'LineWidth', 1.5); % Šírka čiary
end
hold off; % Prerušenie kreslenia do rovnakého grafického okna
title('Závislosť alokácie do S&P 500 od AFS pri rôznych nastaveniach lineárnych GLIDeS', ... % Názov grafu
      'FontSize', 14); % Veľkosť písma  
xlabel('AFS (%)', ... % Názov x-ovej osi
       'FontSize', 12); % Veľkosť písma 
ylabel('Alokácia do S&P 500 (%)', ... % Názov y-ovej osi
       'FontSize', 12); % Veľkosť písma 
set(gca, 'FontSize', 12); % Veľkosť písma v grafe
grid on; % Mriežka
xticks(0:10:200); % Nastavenie rozsahu x-ovej osi
yticks(0:10:100); % Nastavenie rozsahu y-ovej osi
legend(Nazvy_legenda_linearne_GLIDeS, ... % Legenda
       'Location', 'best', ... % Poloha legendy
       'FontSize', 12); % Veľkosť písma v legende 
 
% Uloženie obrázku:
Nazov_zavislost_SAP_AFS_linearne_GLIDeS = 'Zavislost_SAP_500_AFS_linearne_GLIDeS.png'; % Názov súboru so závislosťou alokácie do S&P 500 od AFS pre lineárne GLIDeS
Cesta_zavislost_SAP_AFS_linearne_GLIDeS = fullfile('C:\Users\IgorM\Documents\DP\Obrazky_final', Nazov_zavislost_SAP_AFS_linearne_GLIDeS); % Cesta k súboru so závislosťou alokácie do S&P 500 od AFS pre lineárne GLIDeS
imwrite(frame2im(getframe(gcf)), Cesta_zavislost_SAP_AFS_linearne_GLIDeS); % Uloženie súboru so závislosťou alokácie do S&P 500 od AFS pre lineárne GLIDeS

% Vykreslenie závislosti alokácie do S&P 500 od AFS pre spojité GLIDeS:
figure; % Nové grafické okno
hold on; % Kreslenie do rovnakého grafického okna
for Nastavenie = 1:width(Nazvy_legenda_spojite_GLIDeS) % Pre každé jedno nastavenie spojitých GLIDeS
    l = Hodnoty_l(Nastavenie); % Hodnota parametra l
    z = Hodnoty_z(Nastavenie); % Hodnota parametra z
    Alokacia_SAP_500_spojite_GLIDeS  = 1 - (1 ./ (1 + exp(-l * (AFS - z)))); % Alokácia do S&P 500 pre spojité GLIDeS
    plot(AFS * 100, Alokacia_SAP_500_spojite_GLIDeS * 100, ... % Vykreslenie závislosti alokácie do S&P 500 od AFS pre spojité GLIDeS
         'Color', Farby(Nastavenie, :), ... % Farba čiary
         'LineWidth', 1.5); % Šírka čiary
end
hold off; % Prerušenie kreslenia do rovnakého grafického okna
title('Závislosť alokácie do S&P 500 od AFS pri rôznych nastaveniach spojitých GLIDeS', ... % Názov grafu
      'FontSize', 14); % Veľkosť písma  
xlabel('AFS (%)', ... % Názov x-ovej osi
       'FontSize', 12); % Veľkosť písma 
ylabel('Alokácia do S&P 500 (%)', ... % Názov y-ovej osi
       'FontSize', 12); % Veľkosť písma 
set(gca, 'FontSize', 12); % Veľkosť písma v grafe
grid on; % Mriežka
xticks(0:10:200); % Nastavenie rozsahu x-ovej osi
yticks(0:10:100); % Nastavenie rozsahu y-ovej osi
legend(Nazvy_legenda_spojite_GLIDeS, ... % Legenda
       'Location', 'best', ... % Poloha legendy
       'FontSize', 12); % Veľkosť písma v legende 
 
% Uloženie obrázku:
Nazov_zavislost_SAP_AFS_spojite_GLIDeS = 'Zavislost_SAP_500_AFS_spojite_GLIDeS.png'; % Názov súboru so závislosťou alokácie do S&P 500 od AFS pre spojité GLIDeS
Cesta_zavislost_SAP_AFS_spojite_GLIDeS = fullfile('C:\Users\IgorM\Documents\DP\Obrazky_final', Nazov_zavislost_SAP_AFS_spojite_GLIDeS); % Cesta k súboru so závislosťou alokácie do S&P 500 od AFS pre spojité GLIDeS
imwrite(frame2im(getframe(gcf)), Cesta_zavislost_SAP_AFS_spojite_GLIDeS); % Uloženie súboru so závislosťou alokácie do S&P 500 od AFS pre spojité GLIDeS

% Vykreslenie závislosti alokácie do S&P 500 od AFS - TFS pre AFS-TFS GLIDeS:
figure; % Nové grafické okno
hold on; % Kreslenie do rovnakého grafického okna
for Nastavenie = 1:width(Nazvy_legenda_AFS_TFS_GLIDeS) % Pre každé jedno nastavenie AFS-TFS GLIDeS
    b = Hodnoty_b(Nastavenie); % Hodnota parametra b
    Alokacia_SAP_500_AFS_TFS_GLIDeS = 1 - (1 ./ (1 + exp(-b * AFS_TFS))); % Alokácia do S&P 500 pre AFS-TFS GLIDeS
    plot(AFS_TFS * 100, Alokacia_SAP_500_AFS_TFS_GLIDeS * 100, ... % Vykreslenie závislosti alokácie do S&P 500 od AFS - TFS pre AFS-TFS GLIDeS
         'Color', Farby(Nastavenie, :), ... % Farba čiary
         'LineWidth', 1.5); % Šírka čiary
end
hold off; % Prerušenie kreslenia do rovnakého grafického okna
title('Závislosť alokácie do S&P 500 od rozdielu AFS a TFS pri rôznych nastaveniach AFS-TFS GLIDeS', ... % Názov grafu
      'FontSize', 14); % Veľkosť písma  
xlabel('AFS - TFS (%)', ... % Názov x-ovej osi
       'FontSize', 12); % Veľkosť písma 
ylabel('Alokácia do S&P 500 (%)', ... % Názov y-ovej osi
       'FontSize', 12); % Veľkosť písma 
set(gca, 'FontSize', 12); % Veľkosť písma v grafe
grid on; % Mriežka
xticks(-100:10:100); % Nastavenie rozsahu x-ovej osi
yticks(0:10:100); % Nastavenie rozsahu y-ovej osi
legend(Nazvy_legenda_AFS_TFS_GLIDeS, ... % Legenda
       'Location', 'best', ... % Poloha legendy
       'FontSize', 12); % Veľkosť písma v legende 
 
% Uloženie obrázku:
Nazov_zavislost_SAP_AFS_TFS_AFS_TFS_GLIDeS = 'Zavislost_SAP_500_AFS_TFS_AFS_TFS_GLIDeS.png'; % Názov súboru so závislosťou alokácie do S&P 500 od AFS - TFS pre AFS-TFS GLIDeS
Cesta_zavislost_SAP_AFS_TFS_AFS_TFS_GLIDeS = fullfile('C:\Users\IgorM\Documents\DP\Obrazky_final', Nazov_zavislost_SAP_AFS_TFS_AFS_TFS_GLIDeS); % Cesta k súboru so závislosťou alokácie do S&P 500 od AFS - TFS pre AFS-TFS GLIDeS
imwrite(frame2im(getframe(gcf)), Cesta_zavislost_SAP_AFS_TFS_AFS_TFS_GLIDeS); % Uloženie súboru so závislosťou alokácie do S&P 500 od AFS - TFS pre AFS-TFS GLIDeS

%% Historická simulácia dôchodkového sporenia:
% Parametre dôchodkového sporenia:
Doba_sporenia_roky = 40; % Dĺžka doby sporenia investora na dôchodok v rokoch
Doba_sporenia_mesiace = Doba_sporenia_roky * 12; % Dĺžka doby sporenia investora na dôchodok v mesiacoch
Prispevkova_sadzba = 0.12; % Časť z platu investora, ktorú bude odvádzať na dôchodkové sporenie
Cielovy_nahradovy_pomer = 1; % Časť z posledného príjmu sporiteľa, ktorú chce poberať na dôchodku  

% Inicializácia vektorov:
Nominalna_mzda = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora nominálnej mesačnej mzdy sporiteľa
Realna_mzda = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora reálnej mesačnej mzdy sporiteľa
Prispevok = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora mesačných príspevkov investora na dôchodkové sporenie
Cieleny_realny_dochodkovy_prijem = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora hodnoty cieleného reálneho mesačného dôchodkového príjmu

% Výpočet príspevkov a cieľového reálneho mesačného dôchodkového príjmu v každom mesiaci sporenia:
for Mesiac_sporenia = 1:Doba_sporenia_mesiace % Pre každý mesiac sporenia 
    Nominalna_mzda(Mesiac_sporenia) = Data_NAWI{4 + ceil(Mesiac_sporenia / 12), :} / 12; % Nominálna mzda sporiteľa v danom mesiaci
    Realna_mzda(Mesiac_sporenia) = Nominalna_mzda(Mesiac_sporenia) / (Data_CPI.CPI(48 + Mesiac_sporenia) / Data_CPI.CPI(49)); % Reálna mzda dôchodkového sporiteľa
    Prispevok(Mesiac_sporenia) = Realna_mzda(Mesiac_sporenia) * Prispevkova_sadzba; % Hodnota mesačného príspevku investora na dôchodkové sporenie 
    Cieleny_realny_dochodkovy_prijem(Mesiac_sporenia) = Realna_mzda(Mesiac_sporenia) * Cielovy_nahradovy_pomer; % Hodnota cieľového reálneho mesačného dôchodkového príjmu
end

% Hodnota finálneho náhradového pomeru, AFS a podielu v akciovom indexe S&P 500 pre jednotlivé dôchodkové investičné stratégie: 
% Pre lineárne GLIDeS:
[Finalny_nahradovy_pomer_agresivne_linearne_GLIDeS, AFS_agresivne_linearne_GLIDeS, w_SAP_agresivne_linearne_GLIDeS] = GLIDeS(Doba_sporenia_mesiace, 'Linear', 0.5, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevok); % Agresívne lineárne GLIDeS
[Finalny_nahradovy_pomer_mierne_linearne_GLIDeS, AFS_mierne_linearne_GLIDeS, w_SAP_mierne_linearne_GLIDeS] = GLIDeS(Doba_sporenia_mesiace, 'Linear', 1, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevok); % Mierne lineárne GLIDeS
[Finalny_nahradovy_pomer_konzervativne_linearne_GLIDeS, AFS_konzervativne_linearne_GLIDeS, w_SAP_konzervativne_linearne_GLIDeS] = GLIDeS(Doba_sporenia_mesiace, 'Linear', 1.5, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevok); % Konzervatívne lineárne GLIDeS

% Pre spojité GLIDeS:
[Finalny_nahradovy_pomer_agresivne_spojite_GLIDeS, AFS_agresivne_spojite_GLIDeS, w_SAP_agresivne_spojite_GLIDeS] = GLIDeS(Doba_sporenia_mesiace, 'Continous', [9, 0.9], Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevok); % Agresívne spojité GLIDeS
[Finalny_nahradovy_pomer_mierne_spojite_GLIDeS, AFS_mierne_spojite_GLIDeS, w_SAP_mierne_spojite_GLIDeS] = GLIDeS(Doba_sporenia_mesiace, 'Continous', [8, 0.8], Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevok); % Mierne spojité GLIDeS
[Finalny_nahradovy_pomer_konzervativne_spojite_GLIDeS, AFS_konzervativne_spojite_GLIDeS, w_SAP_konzervativne_spojite_GLIDeS] = GLIDeS(Doba_sporenia_mesiace, 'Continous', [5, 0.5], Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevok); % Konzervatívne spojité GLIDeS

% Pre AFS-TFS GLIDeS:
[Finalny_nahradovy_pomer_silne_AFS_TFS_GLIDeS, AFS_silne_AFS_TFS_GLIDeS, w_SAP_silne_AFS_TFS_GLIDeS] = GLIDeS(Doba_sporenia_mesiace, 'AFS_TFS', 7, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevok); % Silné AFS-TFS GLIDeS
[Finalny_nahradovy_pomer_mierne_AFS_TFS_GLIDeS, AFS_mierne_AFS_TFS_GLIDeS, w_SAP_mierne_AFS_TFS_GLIDeS] = GLIDeS(Doba_sporenia_mesiace, 'AFS_TFS', 3, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevok); % Mierne AFS-TFS GLIDeS
[Finalny_nahradovy_pomer_slabe_AFS_TFS_GLIDeS, AFS_slabe_AFS_TFS_GLIDeS, w_SAP_slabe_AFS_TFS_GLIDeS] = GLIDeS(Doba_sporenia_mesiace, 'AFS_TFS', 1, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevok); % Slabé AFS-TFS GLIDeS

% Pre dôchodkové investičné stratégie so zvoleným konštantným pomerom rozdelenia sporiteľových prostiedkov medzi akciový index S&P 500 a dôchodkové dlhopisy SeLFIES: 
[Finalny_nahradovy_pomer_100_0, AFS_100_0] = Konstantne(Doba_sporenia_mesiace, 1, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevok); % 100 % do S&P 500 a 0 % do SeLFIES
[Finalny_nahradovy_pomer_75_25, AFS_75_25] = Konstantne(Doba_sporenia_mesiace, 0.75, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevok); % 75 % do S&P 500 a 25 % do SeLFIES
[Finalny_nahradovy_pomer_50_50, AFS_50_50] = Konstantne(Doba_sporenia_mesiace, 0.5, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevok); % 50 % do S&P 500 a 50 % do SeLFIES
[Finalny_nahradovy_pomer_25_75, AFS_25_75] = Konstantne(Doba_sporenia_mesiace, 0.25, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevok); % 25 % do S&P 500 a 75 % do SeLFIES
[Finalny_nahradovy_pomer_0_100, AFS_0_100] = Konstantne(Doba_sporenia_mesiace, 0, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevok); % 0 % do S&P 500 a 100 % do SeLFIES

% Pre dôchodkové predvolené investičné stratégie (PIS) z jednotlivých krajín:
[Finalny_nahradovy_pomer_PIS_Slovensko, AFS_PIS_Slovensko] = PIS(Doba_sporenia_mesiace, 'Slovakia', Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevok); % PIS zo Slovenska
[Finalny_nahradovy_pomer_PIS_Svedsko, AFS_PIS_Svedsko] = PIS(Doba_sporenia_mesiace, 'Sweden', Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevok); % PIS zo Švédska
[Finalny_nahradovy_pomer_PIS_Cile, AFS_PIS_Cile] = PIS(Doba_sporenia_mesiace, 'Chile', Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevok); % PIS z Čile

% Pre dôchodkové investičné stratégie založené na veku sporiteľa:
[Finalny_nahradovy_pomer_Aging_1, AFS_Aging_1] = Aging(Doba_sporenia_mesiace, '1', Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevok); % Aging 1
[Finalny_nahradovy_pomer_Aging_2, AFS_Aging_2] = Aging(Doba_sporenia_mesiace, '2', Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevok); % Aging 2
[Finalny_nahradovy_pomer_Aging_3, AFS_Aging_3] = Aging(Doba_sporenia_mesiace, '3', Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevok); % Aging 3
[Finalny_nahradovy_pomer_Aging_4, AFS_Aging_4] = Aging(Doba_sporenia_mesiace, '4', Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevok); % Aging 4

% Pre dôchodkové investičné stratégie založené na výnose aktív:
[Finalny_nahradovy_pomer_Discretive, AFS_Discretive, w_SAP_Discretive] = Discretive(Doba_sporenia_mesiace, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Mesacny_logaritmicky_realny_vynos_TS_TT{:, 1}(:, 4), [1; Realna_hodnota_pociatocnej_investicie_SAP_500], [1; Realne_hodnoty_pociatocnej_investicie_TS(:, 4)], Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevok); % Discretive
[Finalny_nahradovy_pomer_CrossEMA, AFS_CrossEMA, w_SAP_CrossEMA] = CrossEMA(Doba_sporenia_mesiace, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Mesacny_logaritmicky_realny_vynos_TS_TT{:, 1}(:, 4), [1; Realna_hodnota_pociatocnej_investicie_SAP_500], Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevok); % CrossEMA
[Finalny_nahradovy_pomer_MaxMin, AFS_MaxMin, w_SAP_MaxMin] = MaxMin(Doba_sporenia_mesiace, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Mesacny_logaritmicky_realny_vynos_TS_TT{:, 1}(:, 4), [1; Realna_hodnota_pociatocnej_investicie_SAP_500], Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevok); % MaxMin
[Finalny_nahradovy_pomer_RiskTolerance, AFS_RiskTolerance, w_SAP_RiskTolerance] = RiskTolerance(Doba_sporenia_mesiace, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Mesacny_logaritmicky_realny_vynos_TS_TT{:, 1}(:, 4), [1; Realna_hodnota_pociatocnej_investicie_SAP_500], Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevok); % RiskTolerance

help quadprog % stručný help
doc quadprog % podrobný help
[Finalny_nahradovy_pomer_Cerny_Melichercik, AFS_Cerny_Melichercik, w_SAP_Cerny_Melichercik, mu, Kovariancna_matica] = Cerny_Melichercik(Doba_sporenia_mesiace, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Mesacny_logaritmicky_realny_vynos_TS_TT{:, 1}(:, 4), Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevok); % Černý-Melicherčík
disp(mu) % Vypísanie vektora priemerných reálnych ročných aritmetických výnosov akciového indexu S&P 500 a amerického štátneho dlhopisu s konštantnou maturitou 7 rokov
disp(Kovariancna_matica) % Vypísanie ročnej kovariančnej matice reálnych výnosov akciového indexu S&P 500 a amerického štátneho dlhopisu s konštantnou maturitou 7 rokov

% Vypísanie finálneho náhradového pomeru pre jednotlivé dôchodkové investičné stratégie:
Nazvy_strategii = ['Agresívne lineárne GLIDeS', "Mierne lineárne GLIDeS", "Konzervatívne lineárne GLIDeS", ...
                   "Agresívne spojité GLIDeS", "Mierne spojité GLIDeS", "Konzervatívne spojité GLIDeS", ...
                   "Silné AFS-TFS GLIDeS", "Mierne AFS-TFS GLIDeS", "Slabé AFS-TFS GLIDeS", ... 
                   "Konštantné 100:0", "Koštantné 75:25", "Konštantné 50:50", "Konštantné 25:75", "Konštantné 0:100", ... 
                   "PIS Slovensko", "PIS Švédsko", "PIS Čile", ... 
                   "Aging 1", "Aging 2", "Aging 3", "Aging 4", ... 
                   "Discretive", "CrossEMA", "MaxMin", "RiskTolerance", ...
                   "Černý-Melicherčík"]; % Názvy jednotlivých stratégií
Finalny_nahradovy_pomer = [Finalny_nahradovy_pomer_agresivne_linearne_GLIDeS, Finalny_nahradovy_pomer_mierne_linearne_GLIDeS, Finalny_nahradovy_pomer_konzervativne_linearne_GLIDeS, ...
                           Finalny_nahradovy_pomer_agresivne_spojite_GLIDeS, Finalny_nahradovy_pomer_mierne_spojite_GLIDeS, Finalny_nahradovy_pomer_konzervativne_spojite_GLIDeS, ...
                           Finalny_nahradovy_pomer_silne_AFS_TFS_GLIDeS, Finalny_nahradovy_pomer_mierne_AFS_TFS_GLIDeS, Finalny_nahradovy_pomer_slabe_AFS_TFS_GLIDeS, ...
                           Finalny_nahradovy_pomer_100_0, Finalny_nahradovy_pomer_75_25, Finalny_nahradovy_pomer_50_50, Finalny_nahradovy_pomer_25_75, Finalny_nahradovy_pomer_0_100, ...
                           Finalny_nahradovy_pomer_PIS_Slovensko, Finalny_nahradovy_pomer_PIS_Svedsko, Finalny_nahradovy_pomer_PIS_Cile, ...
                           Finalny_nahradovy_pomer_Aging_1, Finalny_nahradovy_pomer_Aging_2, Finalny_nahradovy_pomer_Aging_3, Finalny_nahradovy_pomer_Aging_4, ...
                           Finalny_nahradovy_pomer_Discretive, Finalny_nahradovy_pomer_CrossEMA, Finalny_nahradovy_pomer_MaxMin, Finalny_nahradovy_pomer_RiskTolerance, ...
                           Finalny_nahradovy_pomer_Cerny_Melichercik]; % Hodnoty finálneho náhradového pomeru
Tabulka_finalny_nahradovy_pomer = table(Nazvy_strategii', round(Finalny_nahradovy_pomer, 4)' * 100, 'VariableNames', {'Stratégia', 'Finálny náhradový pomer (%)'}); % Vytvorenie tabuľky finálnych náhradových pomerov
disp(Tabulka_finalny_nahradovy_pomer) % Vypísanie tabuľky

% Vykreslenie vývoja AFS pre jednotlivé dôchodkové investičné stratégie:
% Lineárne GLIDeS:
AFS_linearne_GLIDeS = [AFS_agresivne_linearne_GLIDeS', AFS_mierne_linearne_GLIDeS', AFS_konzervativne_linearne_GLIDeS']; % Hodnoty AFS pre lineárne GLIDeS
Legenda_linearne_GLIDeS = {'Agresívne (k = 0,5)', 'Mierne (k = 1)', 'Konzervatívne (k = 1,5)'}; % Názvy do legendy pre lineárne GLIDeS
Vykreslenie_vyvoja(AFS_linearne_GLIDeS * 100, Vynosy_do_splatnosti_TS.Time(49:end), 'AFS', 'AFS pre jednotlivé nastavenia lineárnych GLIDeS', 'AFS_linearne_GLIDeS', Legenda_linearne_GLIDeS) % Vykreslenie časového vývoja AFS pre jednotlivé nastavenia dôchodkovej investičnej stratégie lineárne GLIDeS

% Spojité GLIDeS:
AFS_spojite_GLIDeS = [AFS_agresivne_spojite_GLIDeS', AFS_mierne_spojite_GLIDeS', AFS_konzervativne_spojite_GLIDeS']; % Hodnoty AFS pre spojité GLIDeS
Legenda_spojite_GLIDeS = {'Agresívne (l = 9 a z = 0,9)', 'Mierne (l = 8 a z = 0,8)', 'Konzervatívne (l = 5 a z = 0,5)'}; % Názvy do legendy pre spojité GLIDeS
Vykreslenie_vyvoja(AFS_spojite_GLIDeS * 100, Vynosy_do_splatnosti_TS.Time(49:end), 'AFS', 'AFS pre jednotlivé nastavenia spojitých GLIDeS', 'AFS_spojite_GLIDeS', Legenda_spojite_GLIDeS) % Vykreslenie časového vývoja AFS pre jednotlivé nastavenia dôchodkovej investičnej stratégie spojité GLIDeS

% AFS-TFS GLIDeS:
TFS = 1/480:1/480:1; % Cieľový stav financovania reálneho dôchodkového príjmu sporiteľa (TFS)
AFS_AFS_TFS_GLIDeS = [AFS_silne_AFS_TFS_GLIDeS', AFS_mierne_AFS_TFS_GLIDeS', AFS_slabe_AFS_TFS_GLIDeS', TFS']; % Hodnoty AFS a TFS pre AFS_TFS GLIDeS
Legenda_AFS_TFS_GLIDeS = {'Silné (b = 7)', 'Mierne (b = 3)', 'Slabé (b = 1)', 'TFS (%)'}; % Názvy do legendy pre AFS_TFS GLIDeS
Vykreslenie_vyvoja(AFS_AFS_TFS_GLIDeS * 100, Vynosy_do_splatnosti_TS.Time(49:end), 'AFS', 'AFS a TFS pre jednotlivé nastavenia AFS-TFS GLIDeS', 'AFS_AFS_TFS_GLIDeS', Legenda_AFS_TFS_GLIDeS) % Vykreslenie časového vývoja AFS a TFS pre jednotlivé nastavenia dôchodkovej investičnej stratégie AFS-TFS GLIDeS

% Dôchodkové investičné stratégie so zvoleným konštantným pomerom rozdelenia sporiteľových prostiedkov medzi akciový index S&P 500 a dôchodkové dlhopisy SeLFIES: 
AFS_konstantne = [AFS_100_0', AFS_75_25', AFS_50_50', AFS_25_75', AFS_0_100']; % Hodnoty AFS pre dôchodkové investičné stratégie so zvoleným konštantným pomerom rozdelenia sporiteľových prostiedkov medzi akciový index S&P 500 a dôchodkové dlhopisy SeLFIES
Legenda_konstantne = {'100:0', '75:25', '50:50', '25:75', '0:100'}; % Názvy do legendy pre dôchodkové investičné stratégie so zvoleným konštantným pomerom rozdelenia sporiteľových prostiedkov medzi akciový index S&P 500 a dôchodkové dlhopisy SeLFIES
Vykreslenie_vyvoja(AFS_konstantne * 100, Vynosy_do_splatnosti_TS.Time(49:end), 'AFS', 'AFS pre jednotlivé konštantné pomery medzi indexom S&P 500 a dlhopismi SeLFIES', 'AFS_konstantne', Legenda_konstantne) % Vykreslenie časového vývoja AFS pre dôchodkové investičné stratégie s jednotlivými konštantnými pomermi rozdelenia sporiteľových prostiedkov medzi akciový index S&P 500 a dôchodkové dlhopisy SeLFIES

% Predvolené investičné stratégie (PIS):
AFS_PIS = [AFS_PIS_Slovensko', AFS_PIS_Svedsko', AFS_PIS_Cile']; % Hodnoty AFS pre PIS
Legenda_PIS = {'Slovenská PIS', 'Švédska PIS', 'Čilská PIS'}; % Názvy do legendy pre PIS
Vykreslenie_vyvoja(AFS_PIS * 100, Vynosy_do_splatnosti_TS.Time(49:end), 'AFS', 'AFS pre predvolené investičné stratégie (PIS) z jednotlivých krajín', 'AFS_PIS', Legenda_PIS) % Vykreslenie časového vývoja AFS pre predvolené dôchodkové investičné stratégie z jednotlivých krajín

% Dôchodkové investičné stratégie založené na veku sporiteľa:
AFS_Aging = [AFS_Aging_1', AFS_Aging_2', AFS_Aging_3', AFS_Aging_4']; % Hodnoty AFS pre dôchodkové investičné stratégie založené na veku sporiteľa
Legenda_Aging = {'Aging 1', 'Aging 2', 'Aging 3', 'Aging 4'}; % Názvy do legendy pre dôchodkové investičné stratégie založené na veku sporiteľa
Vykreslenie_vyvoja(AFS_Aging * 100, Vynosy_do_splatnosti_TS.Time(49:end), 'AFS', 'AFS pre jednotlivé dôchodkové investičné stratégie založené na veku sporiteľa', 'AFS_Aging', Legenda_Aging) % Vykreslenie časového vývoja AFS pre jednotlivé dôchodkové investičné stratégie založené na veku sporiteľa

% Pre dôchodkové investičné stratégie založené na výnose aktív a Samuelsonovej teórii celoživotného cyklu:
AFS_value = [AFS_Discretive', AFS_CrossEMA', AFS_MaxMin', AFS_RiskTolerance', AFS_Cerny_Melichercik']; % Hodnoty AFS pre dôchodkové investičné stratégie založené na výnose aktív a Samuelsonovej teórii celoživotného cyklu
Legenda_value = {'Discretive', 'CrossEMA', 'MaxMin', 'RiskTolerance', 'Černý-Melicherčík'}; % Názvy do legendy pre dôchodkové investičné stratégie založené na výnose aktív a Samuelsonovej teórii celoživotného cyklu
Vykreslenie_vyvoja(AFS_value * 100, Vynosy_do_splatnosti_TS.Time(49:end), 'AFS', 'AFS pre jednotlivé dôchodkové investičné stratégie založené na výnose aktív', 'AFS_value_a_Cerny_Melichercik', Legenda_value) % Vykreslenie časového vývoja AFS pre jednotlivé dôchodkové investičné stratégie založené na výnose aktív a Samuelsonovej teórii celoživotného cyklu

% Vykreslenie vývoja percentuálnej alokácie sporiteľových prostriedkov do akciového indexu S&P 500 pre jednotlivé dôchodkové investičné stratégie:
% Lineárne GLIDeS:
w_SAP_linearne_GLIDeS = [w_SAP_agresivne_linearne_GLIDeS', w_SAP_mierne_linearne_GLIDeS', w_SAP_konzervativne_linearne_GLIDeS']; % Alokácia sporiteľových prostriedkov do akciového indexu S&P 500
Vykreslenie_vyvoja(w_SAP_linearne_GLIDeS * 100, Vynosy_do_splatnosti_TS.Time(49:end), 'Alokácia do indexu S&P 500', 'alokácie do indexu S&P 500 pre jednotlivé nastavenia lineárnych GLIDeS', 'w_SAP_linearne_GLIDeS', Legenda_linearne_GLIDeS) % Vykreslenie časového vývoja percentuálnej alokácie sporiteľových prostriedkov do akciového indexu S&P 500 pre jednotlivé nastavenia dôchodkovej investičnej stratégie lineárne GLIDeS

% Spojité GLIDeS:
w_SAP_spojite_GLIDeS = [w_SAP_agresivne_spojite_GLIDeS', w_SAP_mierne_spojite_GLIDeS', w_SAP_konzervativne_spojite_GLIDeS']; % Alokácia sporiteľových prostriedkov do akciového indexu S&P 500
Vykreslenie_vyvoja(w_SAP_spojite_GLIDeS * 100, Vynosy_do_splatnosti_TS.Time(49:end), 'Alokácia do indexu S&P 500', 'alokácie do indexu S&P 500 pre jednotlivé nastavenia spojitých GLIDeS', 'w_SAP_spojite_GLIDeS', Legenda_spojite_GLIDeS) % Vykreslenie časového vývoja percentuálnej alokácie sporiteľových prostriedkov do akciového indexu S&P 500 pre jednotlivé nastavenia dôchodkovej investičnej stratégie spojité GLIDeS

% AFS-TFS GLIDeS:
w_SAP_AFS_TFS_GLIDeS = [w_SAP_silne_AFS_TFS_GLIDeS', w_SAP_mierne_AFS_TFS_GLIDeS', w_SAP_slabe_AFS_TFS_GLIDeS']; % Alokácia sporiteľových prostriedkov do akciového indexu S&P 500
Vykreslenie_vyvoja(w_SAP_AFS_TFS_GLIDeS * 100, Vynosy_do_splatnosti_TS.Time(49:end), 'Alokácia do indexu S&P 500', 'alokácie do indexu S&P 500 pre jednotlivé nastavenia AFS-TFS GLIDeS', 'w_SAP_AFS_TFS_GLIDeS', Legenda_AFS_TFS_GLIDeS(1:3)) % Vykreslenie časového vývoja percentuálnej alokácie sporiteľových prostriedkov do akciového indexu S&P 500 pre jednotlivé nastavenia dôchodkovej investičnej stratégie AFS-TFS GLIDeS

% Pre dôchodkové investičné stratégie založené na výnose aktív a na Samuelsonovej teórii celoživotného cyklu:
w_SAP_value = [w_SAP_Discretive', w_SAP_CrossEMA', w_SAP_MaxMin', w_SAP_RiskTolerance', w_SAP_Cerny_Melichercik']; % Alokácia sporiteľových prostriedkov do akciového indexu S&P 500
tabulate(w_SAP_value(:, 1)) % Koľkokrát boli všetky prostiedky sporiteľa investované do akciového indexu S&P 500 pri využití dôchodkovej investičnej stratégie Discretive
tabulate(w_SAP_value(:, 2)) % Koľkokrát boli všetky prostiedky sporiteľa investované do akciového indexu S&P 500 pri využití dôchodkovej investičnej stratégie CrossEMA
tabulate(w_SAP_value(:, 3)) % Koľkokrát boli všetky prostiedky sporiteľa investované do akciového indexu S&P 500 pri využití dôchodkovej investičnej stratégie MaxMin
Vykreslenie_vyvoja(w_SAP_value(:, 4:5) * 100, Vynosy_do_splatnosti_TS.Time(49:end), 'Alokácia do indexu S&P 500', 'alokácie do indexu S&P 500 pre jednotlivé dôchodkové investičné stratégie založené na výnose aktív', 'w_SAP_value_a_Cerny_Melichercik', Legenda_value(4:5)) % Vykreslenie časového vývoja percentuálnej alokácie sporiteľových prostriedkov do akciového indexu S&P 500 pre vybrané dôchodkové investičné stratégie založené na výnose aktív a Sameulsonovej teórií celoživotného cyklu

%% Historická simulácia dôchodkového sporenia pre kratšie obdobie sporenia:
% Nastavenie dĺžky sporenia:
Doba_sporenia_roky_kratsie_obdobie = 36; % Dĺžka doby sporenia investora na dôchodok v rokoch
Doba_sporenia_mesiace_kratsie_obdobie = Doba_sporenia_roky_kratsie_obdobie * 12; % Dĺžka doby sporenia investora na dôchodok v mesiacoch

% Reálne hodnoty počiatočnej investície v čase:
Realna_hodnota_pociatocnej_investicie_SAP_500_kratsie_obdobie = Pociatocna_investicia_SAP_500 * exp(cumsum(Mesacny_logaritmicky_realny_vynos_SAP_500(97:end), 1)); % Reálne hodnoty počiatočnej investície do akciového indexu S&P 500 v každom mesiaci počas kratšej doby sporenia
Realna_hodnota_pociatocnej_investicie_TS_kratsie_obdobie = Pociatocna_investicia_TS * exp(cumsum(fillmissing(Mesacny_logaritmicky_realny_vynos_TS(97:end, :), 'constant', 0), 1)); % Reálne hodnoty počiatočnej investície do TS s jednotlivými konštantnými maturitami v každom mesiaci počas kratšej doby sporenia

% Inicializácia vektorov:
Nominalna_mzda_kratsie_obdobie = zeros(1, Doba_sporenia_mesiace_kratsie_obdobie); % Inicializácia vektora hodnoty nominálnej mesačnej mzdy sporiteľa
Realna_mzda_kratsie_obdobie = zeros(1, Doba_sporenia_mesiace_kratsie_obdobie); % Inicializácia vektora hodnoty reálnej mesačnej mzdy sporiteľa
Prispevok_kratsie_obdobie = zeros(1, Doba_sporenia_mesiace_kratsie_obdobie); % Inicializácia vektora hodnoty mesačných príspevkov investora na dôchodkové sporenie
Cieleny_realny_dochodkovy_prijem_kratsie_obdobie = zeros(1, Doba_sporenia_mesiace_kratsie_obdobie); % Inicializácia vektora hodnoty cieleného reálneho mesačného dôchodkového príjmu

% Výpočet príspevkov a cieľového reálneho dôchodkového príjmu v každom mesiaci sporenia počas kratšej doby sporenia:
for Mesiac_sporenia = 1:Doba_sporenia_mesiace_kratsie_obdobie % Pre každý mesiac sporenia 
    Nominalna_mzda_kratsie_obdobie(Mesiac_sporenia) = Data_NAWI{ceil(8 + Mesiac_sporenia/12), :} / 12; % Nominálna mzda sporiteľa v danom mesiaci
    Realna_mzda_kratsie_obdobie(Mesiac_sporenia) = Nominalna_mzda_kratsie_obdobie(Mesiac_sporenia) / (Data_CPI.CPI(96 + Mesiac_sporenia) / Data_CPI.CPI(97)); % Reálna mzda dôchodkového sporiteľa
    Prispevok_kratsie_obdobie(Mesiac_sporenia) = Realna_mzda_kratsie_obdobie(Mesiac_sporenia) * Prispevkova_sadzba; % Hodnota mesačného príspevku investora na dôchodkové sporenie 
    Cieleny_realny_dochodkovy_prijem_kratsie_obdobie(Mesiac_sporenia) = Realna_mzda_kratsie_obdobie(Mesiac_sporenia) * Cielovy_nahradovy_pomer; % Hodnota cieleného reálneho mesačného dôchodkového príjmu
end

% Hodnota finálneho náhradového pomeru pre jednotlivé dôchodkové investičné stratégie za kratšie obdobie sporenia:
% Pre lineárne GLIDeS:
Finalny_nahradovy_pomer_agresivne_linearne_GLIDeS_kratsie_obdobie = GLIDeS(Doba_sporenia_mesiace_kratsie_obdobie, 'Linear', 0.5, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_kratsie_obdobie, Prispevok_kratsie_obdobie); % Agresívne lineárne GLIDeS
Finalny_nahradovy_pomer_mierne_linearne_GLIDeS_kratsie_obdobie = GLIDeS(Doba_sporenia_mesiace_kratsie_obdobie, 'Linear', 1, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_kratsie_obdobie, Prispevok_kratsie_obdobie); % Mierne lineárne GLIDeS
Finalny_nahradovy_pomer_konzervativne_linearne_GLIDeS_kratsie_obdobie = GLIDeS(Doba_sporenia_mesiace_kratsie_obdobie, 'Linear', 1.5, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_kratsie_obdobie, Prispevok_kratsie_obdobie); % Konzervatívne lineárne GLIDeS

% Pre spojité GLIDeS:
Finalny_nahradovy_pomer_agresivne_spojite_GLIDeS_kratsie_obdobie = GLIDeS(Doba_sporenia_mesiace_kratsie_obdobie, 'Continous', [9, 0.9], Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_kratsie_obdobie, Prispevok_kratsie_obdobie); % Agresívne spojité GLIDeS
Finalny_nahradovy_pomer_mierne_spojite_GLIDeS_kratsie_obdobie = GLIDeS(Doba_sporenia_mesiace_kratsie_obdobie, 'Continous', [8, 0.8], Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_kratsie_obdobie, Prispevok_kratsie_obdobie); % Mierne spojité GLIDeS
Finalny_nahradovy_pomer_konzervativne_spojite_GLIDeS_kratsie_obdobie = GLIDeS(Doba_sporenia_mesiace_kratsie_obdobie, 'Continous', [5, 0.5], Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_kratsie_obdobie, Prispevok_kratsie_obdobie); % Konzervatívne spojité GLIDeS

% Pre AFS-TFS GLIDeS:
Finalny_nahradovy_pomer_silne_AFS_TFS_GLIDeS_kratsie_obdobie = GLIDeS(Doba_sporenia_mesiace_kratsie_obdobie, 'AFS_TFS', 7, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_kratsie_obdobie, Prispevok_kratsie_obdobie); % Silné AFS-TFS GLIDeS
Finalny_nahradovy_pomer_mierne_AFS_TFS_GLIDeS_kratsie_obdobie = GLIDeS(Doba_sporenia_mesiace_kratsie_obdobie, 'AFS_TFS', 3, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_kratsie_obdobie, Prispevok_kratsie_obdobie); % Mierne AFS-TFS GLIDeS
Finalny_nahradovy_pomer_slabe_AFS_TFS_GLIDeS_kratsie_obdobie = GLIDeS(Doba_sporenia_mesiace_kratsie_obdobie, 'AFS_TFS', 1, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_kratsie_obdobie, Prispevok_kratsie_obdobie); % Slabé AFS-TFS GLIDeS

% Pre dôchodkové investičné stratégie so zvoleným konštantným pomerom rozdelenia sporiteľových prostiedkov medzi akciový index S&P 500 a dôchodkové dlhopisy SeLFIES: 
Finalny_nahradovy_pomer_100_0_kratsie_obdobie = Konstantne(Doba_sporenia_mesiace_kratsie_obdobie, 1, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_kratsie_obdobie, Prispevok_kratsie_obdobie); % 100 % do S&P 500 a 0 % do SeLFIES
Finalny_nahradovy_pomer_75_25_kratsie_obdobie = Konstantne(Doba_sporenia_mesiace_kratsie_obdobie, 0.75, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_kratsie_obdobie, Prispevok_kratsie_obdobie); % 75 % do S&P 500 a 25 % do SeLFIES
Finalny_nahradovy_pomer_50_50_kratsie_obdobie = Konstantne(Doba_sporenia_mesiace_kratsie_obdobie, 0.5, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_kratsie_obdobie, Prispevok_kratsie_obdobie); % 50 % do S&P 500 a 50 % do SeLFIES
Finalny_nahradovy_pomer_25_75_kratsie_obdobie = Konstantne(Doba_sporenia_mesiace_kratsie_obdobie, 0.25, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_kratsie_obdobie, Prispevok_kratsie_obdobie); % 25 % do S&P 500 a 75 % do SeLFIES
Finalny_nahradovy_pomer_0_100_kratsie_obdobie = Konstantne(Doba_sporenia_mesiace_kratsie_obdobie, 0, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_kratsie_obdobie, Prispevok_kratsie_obdobie); % 0 % do S&P 500 a 100 % do SeLFIES

% Pre dôchodkové predvolené investičné stratégie (PIS) z jednotlivých krajín:
Finalny_nahradovy_pomer_PIS_Slovensko_kratsie_obdobie = PIS(Doba_sporenia_mesiace_kratsie_obdobie, 'Slovakia', Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_kratsie_obdobie, Prispevok_kratsie_obdobie); % PIS zo Slovenska
Finalny_nahradovy_pomer_PIS_Svedsko_kratsie_obdobie = PIS(Doba_sporenia_mesiace_kratsie_obdobie, 'Sweden', Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_kratsie_obdobie, Prispevok_kratsie_obdobie); % PIS zo Švédska
Finalny_nahradovy_pomer_PIS_Cile_kratsie_obdobie = PIS(Doba_sporenia_mesiace_kratsie_obdobie, 'Chile', Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_kratsie_obdobie, Prispevok_kratsie_obdobie); % PIS z Čile

% Pre dôchodkové investičné stratégie založené na veku sporiteľa:
Finalny_nahradovy_pomer_Aging_1_kratsie_obdobie = Aging(Doba_sporenia_mesiace_kratsie_obdobie, '1', Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_kratsie_obdobie, Prispevok_kratsie_obdobie); % Aging 1
Finalny_nahradovy_pomer_Aging_2_kratsie_obdobie = Aging(Doba_sporenia_mesiace_kratsie_obdobie, '2', Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_kratsie_obdobie, Prispevok_kratsie_obdobie); % Aging 2
Finalny_nahradovy_pomer_Aging_3_kratsie_obdobie = Aging(Doba_sporenia_mesiace_kratsie_obdobie, '3', Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_kratsie_obdobie, Prispevok_kratsie_obdobie); % Aging 3
Finalny_nahradovy_pomer_Aging_4_kratsie_obdobie = Aging(Doba_sporenia_mesiace_kratsie_obdobie, '4', Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_kratsie_obdobie, Prispevok_kratsie_obdobie); % Aging 4

% Pre dôchodkové investičné stratégie založené na výnose aktív:
Finalny_nahradovy_pomer_Discretive_kratsie_obdobie = Discretive(Doba_sporenia_mesiace_kratsie_obdobie, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Mesacny_logaritmicky_realny_vynos_TS_TT{:, 1}(:, 4), [1; Realna_hodnota_pociatocnej_investicie_SAP_500_kratsie_obdobie], [1; Realna_hodnota_pociatocnej_investicie_TS_kratsie_obdobie(:, 4)], Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_kratsie_obdobie, Prispevok_kratsie_obdobie); % Discretive
Finalny_nahradovy_pomer_CrossEMA_kratsie_obdobie = CrossEMA(Doba_sporenia_mesiace_kratsie_obdobie, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Mesacny_logaritmicky_realny_vynos_TS_TT{:, 1}(:, 4), [1; Realna_hodnota_pociatocnej_investicie_SAP_500_kratsie_obdobie], Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_kratsie_obdobie, Prispevok_kratsie_obdobie); % CrossEMA
Finalny_nahradovy_pomer_MaxMin_kratsie_obdobie = MaxMin(Doba_sporenia_mesiace_kratsie_obdobie, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Mesacny_logaritmicky_realny_vynos_TS_TT{:, 1}(:, 4), [1; Realna_hodnota_pociatocnej_investicie_SAP_500_kratsie_obdobie], Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_kratsie_obdobie, Prispevok_kratsie_obdobie); % MaxMin
Finalny_nahradovy_pomer_RiskTolerance_kratsie_obdobie = RiskTolerance(Doba_sporenia_mesiace_kratsie_obdobie, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Mesacny_logaritmicky_realny_vynos_TS_TT{:, 1}(:, 4), [1; Realna_hodnota_pociatocnej_investicie_SAP_500_kratsie_obdobie], Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_kratsie_obdobie, Prispevok_kratsie_obdobie); % RiskTolerance
Finalny_nahradovy_pomer_Cerny_Melichercik_kratsie_obdobie = Cerny_Melichercik(Doba_sporenia_mesiace_kratsie_obdobie, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Mesacny_logaritmicky_realny_vynos_TS_TT{:, 1}(:, 4), Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_kratsie_obdobie, Prispevok_kratsie_obdobie); % Černý-Melicherčík

% Vypísanie finálneho náhradového pomeru pre jednotlivé dôchodkové investičné stratégie:
Finalny_nahradovy_pomer_kratsie_obdobie = [Finalny_nahradovy_pomer_agresivne_linearne_GLIDeS_kratsie_obdobie, Finalny_nahradovy_pomer_mierne_linearne_GLIDeS_kratsie_obdobie, Finalny_nahradovy_pomer_konzervativne_linearne_GLIDeS_kratsie_obdobie, ...
                                          Finalny_nahradovy_pomer_agresivne_spojite_GLIDeS_kratsie_obdobie, Finalny_nahradovy_pomer_mierne_spojite_GLIDeS_kratsie_obdobie, Finalny_nahradovy_pomer_konzervativne_spojite_GLIDeS_kratsie_obdobie, ...
                                          Finalny_nahradovy_pomer_silne_AFS_TFS_GLIDeS_kratsie_obdobie, Finalny_nahradovy_pomer_mierne_AFS_TFS_GLIDeS_kratsie_obdobie, Finalny_nahradovy_pomer_slabe_AFS_TFS_GLIDeS_kratsie_obdobie, ...
                                          Finalny_nahradovy_pomer_100_0_kratsie_obdobie, Finalny_nahradovy_pomer_75_25_kratsie_obdobie, Finalny_nahradovy_pomer_50_50_kratsie_obdobie, Finalny_nahradovy_pomer_25_75_kratsie_obdobie, Finalny_nahradovy_pomer_0_100_kratsie_obdobie, ...
                                          Finalny_nahradovy_pomer_PIS_Slovensko_kratsie_obdobie, Finalny_nahradovy_pomer_PIS_Svedsko_kratsie_obdobie, Finalny_nahradovy_pomer_PIS_Cile_kratsie_obdobie, ...
                                          Finalny_nahradovy_pomer_Aging_1_kratsie_obdobie, Finalny_nahradovy_pomer_Aging_2_kratsie_obdobie, Finalny_nahradovy_pomer_Aging_3_kratsie_obdobie, Finalny_nahradovy_pomer_Aging_4_kratsie_obdobie, ...
                                          Finalny_nahradovy_pomer_Discretive_kratsie_obdobie, Finalny_nahradovy_pomer_CrossEMA_kratsie_obdobie, Finalny_nahradovy_pomer_MaxMin_kratsie_obdobie, Finalny_nahradovy_pomer_RiskTolerance_kratsie_obdobie, ...
                                          Finalny_nahradovy_pomer_Cerny_Melichercik_kratsie_obdobie]; % Hodnoty finálneho náhradového pomeru
Tabulka_finalny_nahradovy_pomer_kratsie_obdobie = table(Nazvy_strategii', round(Finalny_nahradovy_pomer_kratsie_obdobie, 4)' * 100, 'VariableNames', {'Stratégia', 'Finálny náhradový pomer (%)'}); % Vytvorenie tabuľky finálnych náhradových pomerov
disp(Tabulka_finalny_nahradovy_pomer_kratsie_obdobie) % Vypísanie tabuľky

%% Historická simulácia dôchodkového sporenia pre dlhšie obdobie sporenia:
% Nastavenie dĺžky sporenia:
Doba_sporenia_roky_dlhsie_obdobie = 44; % Dĺžka doby sporenia investora na dôchodok v rokoch
Doba_sporenia_mesiace_dlhsie_obdobie = Doba_sporenia_roky_dlhsie_obdobie * 12; % Dĺžka doby sporenia investora na dôchodok v mesiacoch

% Reálne hodnoty počiatočnej investície v čase:
Realne_hodnoty_pociatocnej_investicie_SAP_500_dlhsie_obdobie = Pociatocna_investicia_SAP_500 * exp(cumsum(Mesacny_logaritmicky_realny_vynos_SAP_500, 1)); % Reálne hodnoty počiatočnej investície do akciového indexu S&P 500 v každom mesiaci počas dlhšej doby sporenia
Realne_hodnoty_pociatocnej_investicie_TS_dlhsie_obdobie = Pociatocna_investicia_TS * exp(cumsum(fillmissing(Mesacny_logaritmicky_realny_vynos_TS, 'constant', 0), 1)); % Reálne hodnoty počiatočnej investície do TS s jednotlivými konštantnými maturitami v každom mesiaci počas dlhšej doby sporenia

Realne_hodnoty_pociatocnej_investicie_SeLFIES_klesajuca_konverzia_dlhsie_obdobie = ones(1, Doba_sporenia_mesiace_dlhsie_obdobie); % Inicializácia vektora reálnej hodnoty počiatočnej investície do SeLFIES s klesajúcou konverziou v každom mesiaci počas dlhšej doby sporenia

for Mesiac = 2:Doba_sporenia_mesiace_dlhsie_obdobie % Pre každý mesiac sporenia 
    Realne_hodnoty_pociatocnej_investicie_SeLFIES_klesajuca_konverzia_dlhsie_obdobie(Mesiac) = Realne_hodnoty_pociatocnej_investicie_SeLFIES_klesajuca_konverzia_dlhsie_obdobie(Mesiac - 1) * exp(Mesacny_logaritmicky_realny_vynos_SeLFIES(Mesiac - 1, 529 - Mesiac)); % Reálne hodnoty počiatočnej investície do SeLFIES s klesajúcou konverziou v každom mesiaci počas dlhšej doby sporenia
end

Legenda_pociatocne_investicie_dlhsie_obdobie = {'SeLFIES s klesajúcou konverziou', 'Index S&P 500'}; % Názvy do legendy
Vykreslenie_vyvoja([Realne_hodnoty_pociatocnej_investicie_SeLFIES_klesajuca_konverzia_dlhsie_obdobie', [1; Realne_hodnoty_pociatocnej_investicie_SAP_500_dlhsie_obdobie]] , Vynosy_do_splatnosti_TS.Time, 'Reálna hodnota počiatočnej investície', 'réalnej hodnoty počiatočnej investície', 'Hodnoty_investicie_dlhsie', Legenda_pociatocne_investicie_dlhsie_obdobie) % Vykreslenie časového vývoja reálnej hodnoty počiatočnej investície do SeLFIES s klesajúcou konverziou a akciového indexu S&P 500 počas dlhšej doby sporenia 

% Inicializácia vektorov:
Nominalna_mzda_dlhsie_obdobie = zeros(1, Doba_sporenia_mesiace_dlhsie_obdobie); % Inicializácia vektora hodnoty nominálnej mesačnej mzdy sporiteľa
Realna_mzda_dlhsie_obdobie = zeros(1, Doba_sporenia_mesiace_dlhsie_obdobie); % Inicializácia vektora hodnoty reálnej mesačnej mzdy sporiteľa
Prispevok_dlhsie_obdobie = zeros(1, Doba_sporenia_mesiace_dlhsie_obdobie); % Inicializácia vektora hodnoty mesačných príspevkov investora na dôchodkové sporenie
Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie = zeros(1, Doba_sporenia_mesiace_dlhsie_obdobie); % Inicializácia vektora hodnoty cieleného reálneho mesačného dôchodkového príjmu

% Výpočet príspevkov a cieľového reálneho dôchodkového príjmu v každom mesiaci sporenia počas dlhšej doby sporenia:
for Mesiac_sporenia = 1:Doba_sporenia_mesiace_dlhsie_obdobie % Pre každý mesiac sporenia 
    Nominalna_mzda_dlhsie_obdobie(Mesiac_sporenia) = Data_NAWI{ceil(Mesiac_sporenia / 12), :} / 12; % Nominálna mzda sporiteľa v danom mesiaci
    Realna_mzda_dlhsie_obdobie(Mesiac_sporenia) = Nominalna_mzda_dlhsie_obdobie(Mesiac_sporenia) / (Data_CPI.CPI(Mesiac_sporenia) / Data_CPI.CPI(1)); % Reálna mzda dôchodkového sporiteľa
    Prispevok_dlhsie_obdobie(Mesiac_sporenia) = Realna_mzda_dlhsie_obdobie(Mesiac_sporenia) * Prispevkova_sadzba; % Hodnota mesačného príspevku investora na dôchodkové sporenie 
    Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie(Mesiac_sporenia) = Realna_mzda_dlhsie_obdobie(Mesiac_sporenia) * Cielovy_nahradovy_pomer; % Hodnota cieleného reálneho mesačného dôchodkového príjmu
end

% Hodnota finálneho náhradového pomeru: 
% Pre lineárne GLIDeS:
Finalny_nahradovy_pomer_agresivne_linearne_GLIDeS_dlhsie_obdobie = GLIDeS(Doba_sporenia_mesiace_dlhsie_obdobie, 'Linear', 0.5, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie, Prispevok_dlhsie_obdobie); % Agresívne lineárne GLIDeS
Finalny_nahradovy_pomer_mierne_linearne_GLIDeS_dlhsie_obdobie = GLIDeS(Doba_sporenia_mesiace_dlhsie_obdobie, 'Linear', 1, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie, Prispevok_dlhsie_obdobie); % Mierne lineárne GLIDeS
Finalny_nahradovy_pomer_konzervativne_linearne_GLIDeS_dlhsie_obdobie = GLIDeS(Doba_sporenia_mesiace_dlhsie_obdobie, 'Linear', 1.5, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie, Prispevok_dlhsie_obdobie); % Konzervatívne lineárne GLIDeS

% Pre spojité GLIDeS:
Finalny_nahradovy_pomer_agresivne_spojite_GLIDeS_dlhsie_obdobie = GLIDeS(Doba_sporenia_mesiace_dlhsie_obdobie, 'Continous', [9, 0.9], Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie, Prispevok_dlhsie_obdobie); % Agresívne spojité GLIDeS
Finalny_nahradovy_pomer_mierne_spojite_GLIDeS_dlhsie_obdobie = GLIDeS(Doba_sporenia_mesiace_dlhsie_obdobie, 'Continous', [8, 0.8], Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie, Prispevok_dlhsie_obdobie); % Mierne spojité GLIDeS
Finalny_nahradovy_pomer_konzervativne_spojite_GLIDeS_dlhsie_obdobie = GLIDeS(Doba_sporenia_mesiace_dlhsie_obdobie, 'Continous', [5, 0.5], Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie, Prispevok_dlhsie_obdobie); % Konzervatívne spojité GLIDeS

% Pre AFS-TFS GLIDeS:
Finalny_nahradovy_pomer_silne_AFS_TFS_GLIDeS_dlhsie_obdobie = GLIDeS(Doba_sporenia_mesiace_dlhsie_obdobie, 'AFS_TFS', 7, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie, Prispevok_dlhsie_obdobie); % Silné AFS-TFS GLIDeS
Finalny_nahradovy_pomer_mierne_AFS_TFS_GLIDeS_dlhsie_obdobie = GLIDeS(Doba_sporenia_mesiace_dlhsie_obdobie, 'AFS_TFS', 3, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie, Prispevok_dlhsie_obdobie); % Mierne AFS-TFS GLIDeS
Finalny_nahradovy_pomer_slabe_AFS_TFS_GLIDeS_dlhsie_obdobie = GLIDeS(Doba_sporenia_mesiace_dlhsie_obdobie, 'AFS_TFS', 1, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie, Prispevok_dlhsie_obdobie); % Slabé AFS-TFS GLIDeS

% Pre dôchodkové investičné stratégie so zvoleným konštantným pomerom rozdelenia sporiteľových prostiedkov medzi akciový index S&P 500 a dôchodkové dlhopisy SeLFIES: 
Finalny_nahradovy_pomer_100_0_dlhsie_obdobie = Konstantne(Doba_sporenia_mesiace_dlhsie_obdobie, 1, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie, Prispevok_dlhsie_obdobie); % 100 % do S&P 500 a 0 % do SeLFIES
Finalny_nahradovy_pomer_75_25_dlhsie_obdobie = Konstantne(Doba_sporenia_mesiace_dlhsie_obdobie, 0.75, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie, Prispevok_dlhsie_obdobie); % 75 % do S&P 500 a 25 % do SeLFIES
Finalny_nahradovy_pomer_50_50_dlhsie_obdobie = Konstantne(Doba_sporenia_mesiace_dlhsie_obdobie, 0.5, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie, Prispevok_dlhsie_obdobie); % 50 % do S&P 500 a 50 % do SeLFIES
Finalny_nahradovy_pomer_25_75_dlhsie_obdobie = Konstantne(Doba_sporenia_mesiace_dlhsie_obdobie, 0.25, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie, Prispevok_dlhsie_obdobie); % 25 % do S&P 500 a 75 % do SeLFIES
Finalny_nahradovy_pomer_0_100_dlhsie_obdobie = Konstantne(Doba_sporenia_mesiace_dlhsie_obdobie, 0, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie, Prispevok_dlhsie_obdobie); % 0 % do S&P 500 a 100 % do SeLFIES

% Pre dôchodkové predvolené investičné stratégie (PIS) z jednotlivých krajín:
Finalny_nahradovy_pomer_PIS_Slovensko_dlhsie_obdobie = PIS(Doba_sporenia_mesiace_dlhsie_obdobie, 'Slovakia', Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie, Prispevok_dlhsie_obdobie); % PIS zo Slovenska
Finalny_nahradovy_pomer_PIS_Svedsko_dlhsie_obdobie = PIS(Doba_sporenia_mesiace_dlhsie_obdobie, 'Sweden', Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie, Prispevok_dlhsie_obdobie); % PIS zo Švédska
Finalny_nahradovy_pomer_PIS_Cile_dlhsie_obdobie = PIS(Doba_sporenia_mesiace_dlhsie_obdobie, 'Chile', Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie, Prispevok_dlhsie_obdobie); % PIS z Čile

% Pre dôchodkové investičné stratégie založené na veku sporiteľa:
Finalny_nahradovy_pomer_Aging_1_dlhsie_obdobie = Aging(Doba_sporenia_mesiace_dlhsie_obdobie, '1', Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie, Prispevok_dlhsie_obdobie); % Aging 1
Finalny_nahradovy_pomer_Aging_2_dlhsie_obdobie = Aging(Doba_sporenia_mesiace_dlhsie_obdobie, '2', Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie, Prispevok_dlhsie_obdobie); % Aging 2
Finalny_nahradovy_pomer_Aging_3_dlhsie_obdobie = Aging(Doba_sporenia_mesiace_dlhsie_obdobie, '3', Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie, Prispevok_dlhsie_obdobie); % Aging 3
Finalny_nahradovy_pomer_Aging_4_dlhsie_obdobie = Aging(Doba_sporenia_mesiace_dlhsie_obdobie, '4', Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie, Prispevok_dlhsie_obdobie); % Aging 4

% Pre dôchodkové investičné stratégie založené na výnose aktív:
Finalny_nahradovy_pomer_Discretive_dlhsie_obdobie = Discretive(Doba_sporenia_mesiace_dlhsie_obdobie, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Mesacny_logaritmicky_realny_vynos_TS_TT{:, 1}(:, 4), [1; Realne_hodnoty_pociatocnej_investicie_SAP_500_dlhsie_obdobie], [1; Realne_hodnoty_pociatocnej_investicie_TS_dlhsie_obdobie(:, 4)], Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie, Prispevok_dlhsie_obdobie); % Discretive
Finalny_nahradovy_pomer_CrossEMA_dlhsie_obdobie = CrossEMA(Doba_sporenia_mesiace_dlhsie_obdobie, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Mesacny_logaritmicky_realny_vynos_TS_TT{:, 1}(:, 4), [1; Realne_hodnoty_pociatocnej_investicie_SAP_500_dlhsie_obdobie], Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie, Prispevok_dlhsie_obdobie); % CrossEMA
Finalny_nahradovy_pomer_MaxMin_dlhsie_obdobie = MaxMin(Doba_sporenia_mesiace_dlhsie_obdobie, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Mesacny_logaritmicky_realny_vynos_TS_TT{:, 1}(:, 4), [1; Realne_hodnoty_pociatocnej_investicie_SAP_500_dlhsie_obdobie], Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie, Prispevok_dlhsie_obdobie); % MaxMin
Finalny_nahradovy_pomer_RiskTolerance_dlhsie_obdobie = RiskTolerance(Doba_sporenia_mesiace_dlhsie_obdobie, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Mesacny_logaritmicky_realny_vynos_TS_TT{:, 1}(:, 4), [1; Realne_hodnoty_pociatocnej_investicie_SAP_500_dlhsie_obdobie], Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie, Prispevok_dlhsie_obdobie); % RiskTolerance
Finalny_nahradovy_pomer_Cerny_Melichercik_dlhsie_obdobie = Cerny_Melichercik(Doba_sporenia_mesiace_dlhsie_obdobie, Mesacny_logaritmicky_realny_vynos_SAP_500_TT{:, 1}, Mesacny_logaritmicky_realny_vynos_TS_TT{:, 1}(:, 4), Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem_dlhsie_obdobie, Prispevok_dlhsie_obdobie); % Černý-Melicherčík

% Vypísanie finálneho náhradového pomeru pre jednotlivé dôchodkové investičné stratégie:
Finalny_nahradovy_pomer_dlhsie_obdobie = [Finalny_nahradovy_pomer_agresivne_linearne_GLIDeS_dlhsie_obdobie, Finalny_nahradovy_pomer_mierne_linearne_GLIDeS_dlhsie_obdobie, Finalny_nahradovy_pomer_konzervativne_linearne_GLIDeS_dlhsie_obdobie, ...
                                          Finalny_nahradovy_pomer_agresivne_spojite_GLIDeS_dlhsie_obdobie, Finalny_nahradovy_pomer_mierne_spojite_GLIDeS_dlhsie_obdobie, Finalny_nahradovy_pomer_konzervativne_spojite_GLIDeS_dlhsie_obdobie, ...
                                          Finalny_nahradovy_pomer_silne_AFS_TFS_GLIDeS_dlhsie_obdobie, Finalny_nahradovy_pomer_mierne_AFS_TFS_GLIDeS_dlhsie_obdobie, Finalny_nahradovy_pomer_slabe_AFS_TFS_GLIDeS_dlhsie_obdobie, ...
                                          Finalny_nahradovy_pomer_100_0_dlhsie_obdobie, Finalny_nahradovy_pomer_75_25_dlhsie_obdobie, Finalny_nahradovy_pomer_50_50_dlhsie_obdobie, Finalny_nahradovy_pomer_25_75_dlhsie_obdobie, Finalny_nahradovy_pomer_0_100_dlhsie_obdobie, ...
                                          Finalny_nahradovy_pomer_PIS_Slovensko_dlhsie_obdobie, Finalny_nahradovy_pomer_PIS_Svedsko_dlhsie_obdobie, Finalny_nahradovy_pomer_PIS_Cile_dlhsie_obdobie, ...
                                          Finalny_nahradovy_pomer_Aging_1_dlhsie_obdobie, Finalny_nahradovy_pomer_Aging_2_dlhsie_obdobie, Finalny_nahradovy_pomer_Aging_3_dlhsie_obdobie, Finalny_nahradovy_pomer_Aging_4_dlhsie_obdobie, ...
                                          Finalny_nahradovy_pomer_Discretive_dlhsie_obdobie, Finalny_nahradovy_pomer_CrossEMA_dlhsie_obdobie, Finalny_nahradovy_pomer_MaxMin_dlhsie_obdobie, Finalny_nahradovy_pomer_RiskTolerance_dlhsie_obdobie, ...
                                          Finalny_nahradovy_pomer_Cerny_Melichercik_dlhsie_obdobie]; % Hodnoty finálneho náhradového pomeru
Tabulka_finalny_nahradovy_pomer_dlhsie_obdobie = table(Nazvy_strategii', round(Finalny_nahradovy_pomer_dlhsie_obdobie, 4)' * 100, 'VariableNames', {'Stratégia', 'Finálny náhradový pomer (%)'}); % Vytvorenie tabuľky finálnych náhradových pomerov
disp(Tabulka_finalny_nahradovy_pomer_dlhsie_obdobie) % Vypísanie tabuľky