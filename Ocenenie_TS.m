function Ceny_TS_TT = Ocenenie_TS(Vynosy_do_splatnosti, CPI, Maturity_vsetky, Maturita_konkretna) % Funkcia na ocenenie TS
% Ocenenie Treasury Securities (TS) 
% Vypočíta ceny TS s danou konštantnou maturitou a zaznamená ich v podobe časovej tabuľky

% Vstupy:
% Výnosy do splatnosti - časová tabuľka s výnosmi do splatnosti TS pre všetky konštantné maturity
% CPI - časová tabuľka s hodnotami Consumer Price Index (CPI)
% Maturity všetky - vektor všetkých konštantných maturít TS 
% Maturita konkrétna - konštantná maturita TS, ktoré chceme oceniť

% Výstupy:
% Ceny_TS_TT - časová tabuľka obsahujúca ceny TS s danou konštantnou maturitou 

Index_maturita = find(Maturity_vsetky == Maturita_konkretna, 1); % Index zadanej maturity TS

Data = Vynosy_do_splatnosti(:, Index_maturita); % Výnosy do splatnosti TS pre danú maturitu v pobobe časovej tabuľky
Data_bez_NaN = rmmissing(Data); % Odstránenie NaN hodnôt z dát
Vynosy_do_splatnosti_bez_NaN = Data_bez_NaN{:, 1} / 100; % Jednotlivé zaznamenané výnosy do splatnosti TS pre danú maturitu v desatinnej forme
Datumy_bez_NaN = Data_bez_NaN.Time; % Dátumy jednotlivých zaznamenaných výnosov do splatnosti TS pre danú maturitu

Hruba_realna_cena_TS = zeros(length(Datumy_bez_NaN) - 1, 1); % Inicializácia vektora hrubých reálnych cien konštantného TS pre danú maturitu
Datum_ocenenia = NaT(length(Datumy_bez_NaN) - 1, 1); % Inicializácia vektora dátumov ocenenia TS s danou konštantnou maturitou

% Ocenenie TS:
for Mesiac = 1:(length(Datumy_bez_NaN) - 1) % Pre každý mesiac
    Datum_ocenenia(Mesiac) = Datumy_bez_NaN(Mesiac) + calmonths(1); % Dátum kedy oceňujeme TS s danou konštantnou maturitou
    
    % Cena TS:
    [Cista_cena, Alikvotny_urok] = bndprice(Vynosy_do_splatnosti_bez_NaN(Mesiac + 1), ... % Výnos do splatnosti TS pre danú konštantnú maturitu v danom mesiaci
                                            Vynosy_do_splatnosti_bez_NaN(Mesiac), ... % Kupónová sadzba pre TS s danou konštantnou maturitou 
                                            Datum_ocenenia(Mesiac), ... % Dátum ocenenia TS pre danú konštantnú maturitu
                                            Datumy_bez_NaN(Mesiac) + calmonths(Maturita_konkretna * 12), ... % Dátum maturity daného konštantného TS
                                            'Period', 2, ... % Koľkokrát TS ročne vyplatí kupón
                                            'Face', 100);  % Nominálna hodnota daného konštatného TS
                                      
    % Inflačná úprava:
    Index_CPI = find(CPI.Time == Datum_ocenenia(Mesiac)); % Index CPI v dátume kedy oceňujeme konštantné TS s danou maturitou
    Inflacna_uprava = CPI.CPI(Index_CPI - 1) / CPI.CPI(Index_CPI); % Inflačná úprava pre hodnotu TS s danou konštantnou maturitou

    Hruba_realna_cena_TS(Mesiac) = (Cista_cena + Alikvotny_urok) * Inflacna_uprava; % Konečná hrubá reálna cena TS s danou konštantnou maturitou 
end

Ceny_TS_TT = timetable(Datum_ocenenia, Hruba_realna_cena_TS, 'VariableNames', {'Hruba_realna_cena'}); % Časová tabuľka hrubých reálnych cien konštantného TS s danou maturitou v jednotlivých dátumoch
                       
end % Koniec funkcie