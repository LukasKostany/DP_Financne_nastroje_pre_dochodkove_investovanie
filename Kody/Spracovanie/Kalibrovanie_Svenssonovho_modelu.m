function Krivky = Kalibrovanie_Svenssonovho_modelu(Data, Maturita, Perioda_kupony, Typ) % Funkcia na kalibráciu Svenssonovho modelu
% Kalibrovanie Svensonnovho modelu
% Získanie kalibrovanej Svenssonovej krivky pre zadané dáta

% Vstupy:
% Dáta - pre aké dáta sa má Svenssonov model kalibrovať
% Maturita - maturita jednotlivých dát
% Perióda kupónov - koľkokrát ročne sa vyplácajú kupóny
% Typ - či ide o nominálnu úrokovú mieru (A) alebo očakávanú infláciu (B)

% Výstupy:
% Krivky - jednotlivé kalibrované Svenssonove krivky

Pocet_kriviek = height(Data); % Počet Svenssonových kriviek
Krivky = cell(Pocet_kriviek, 1); % Vytvorenie jednotlivých prázdnych kriviek

% Kalibrácia Svensonnovho modelu:
for Mesiac = 1:Pocet_kriviek % Pre každý mesiac
    Datum = Data.Time(Mesiac); % Dátum v daný mesiac
    Vstupy = table2array(Data(Mesiac, :)) / 100; % Vstupné dáta v desatinnej forme

    % Odstránenie hodnôt NaN:
    Vstupy_bez_NaN_indexy = ~isnan(Vstupy); % Indexy vstupov bez NaN
    Vstupy_bez_NaN = Vstupy(Vstupy_bez_NaN_indexy); % Vstupy iba bez NaN
    Maturity_bez_NaN = Maturita(Vstupy_bez_NaN_indexy); % Maturity vstupov bez NaN

    % Tabuľka vstupov bez NaN s dátumom maturity:
    Vstupy_tabulka = array2timetable(Vstupy_bez_NaN', ... % Vytvorenie časovej tabuľky vstupov bez NaN
                                     'RowTimes', Datum + calmonths(Maturity_bez_NaN * 12), ... % Dátumy maturity
                                     'VariableNames', {'Vstup'}); % Zaznamenané vstupy

    % Typ dlhopisu:
    if Typ == 'A' % Ak ide o kalibrovanie Svenssonových kriviek pre nominálnu úrokovú mieru
       Kupony = Vstupy_tabulka.Vstup; % Tak kupóny sú rovné výnosom do splatnosti TS s jednotlivými konštantnými maturitami
    else % Ak ide o kalibrovanie Svenssonových kriviek pre očakávanú infláciu
         Kupony = 0; % Tak kupóny sú rovné 0
    end

    % Vytvorenie finančných nástrojov s jednotlivými maturitami:
    Dlhopisy = fininstrument("FixedBond", ... % Dlhopisy
                             'CouponRate', Kupony, ... % Výšky kupónov jednotlivých dlhopisov
                             'Maturity', Vstupy_tabulka.Properties.RowTimes, ... % Maturity jednotlivých dlhopisov
                             'Period', Perioda_kupony, ... % Perióda vyplácania kupónov
                             'Principal', 100);  % Nominálna hodnota jednotlivých dlhopisov
    
    % Trhová cena dlhopisov:
    if Typ == 'A' % Ak ide o kalibrovanie Svenssonových kriviek pre nominálnu úrokovú mieru
       Cena = 100; % Tak trhová cena dlhopisu je rovná nominálnej (par bondy - TS)
    else % Ak ide o kalibrovanie Svenssonových kriviek pre očakávanú infláciu
         Cena = 100./(1 + Vstupy_tabulka.Vstup').^Maturity_bez_NaN; % Tak trhová cena dlhopisu sa vypočíta podľa vzorca na oceňovanie bezkupónových dlhopisov
    end  

    % Nastevenie ohraničení a počiatočného bodu pre optimalizáciu parametrov beta_0, beta_1, beta_2, beta_3, tau_1 a tau_2 Svenssonovho modelu:
    Beta_0_pociatocna = max(0, min(mean(Vstupy_tabulka.Vstup(end-2:end) * 100), 15)); % Počiatočná hodnota parametra beta_0
    Beta_1_pociatocna = max(-15, min((Vstupy_tabulka.Vstup(1) * 100) - Beta_0_pociatocna, 30)); % Počtiatočná hodnota parametra beta_1
    Startovaci_bod = [Beta_0_pociatocna, Beta_1_pociatocna, 0, 0, 1, 1];  % Počiatočný bod optimalizácie
    Dolna_hranica = [0, -15, -30, -30, 0, 2.5];  % Dolné hranice pre hodnoty parametrov
    Horna_hranica = [15, 30, 30, 30, 2.5, 5.5]; % Horné hranice pre hodnoty parametrov
    Podmienky = {'x0', Startovaci_bod, 'lb', Dolna_hranica, 'ub', Horna_hranica}; % Nastavenie podmienok optimalizácie

    % Kalibrovaná Svenssonova krivka:
    Svenssonov_model = fitSvensson(Datum, Dlhopisy, Cena, Podmienky{:}); % Kalibrácia Svenssonovho modelu 
    Krivky{Mesiac} = Svenssonov_model; % Uloženie Svenssonovej krivky
end

end % Koniec funkcie
