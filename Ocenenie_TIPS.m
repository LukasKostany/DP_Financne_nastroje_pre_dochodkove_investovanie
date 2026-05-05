function Ceny_TIPS_TT = Ocenenie_TIPS(Vynosy_do_splatnosti, Maturity_vsetky, Maturita_konkretna) % Funkcia na ocenenie TIPS
% Ocenenie Treasury Inflation-Protected Securities (TIPS)
% Vypočíta ceny TIPS s danou konštantnou maturitou a zaznamená ich v podobe časovej tabuľky

% Vstupy:
% Výnosy do splatnosti - časová tabuľka s výnosmi do splatnosti pre jednotlivé konštantné maturity TIPS
% Maturity všetky - vektor všetkých konštantných maturít TIPS
% Maturita konkrétna - konštantná maturita TIPS, ktoré chceme oceniť

% Výstupy:
% Ceny_TIPS_TT - časová tabuľka obsahujúca ceny konštantného TIPS s danou maturitou 

Index_maturita = find(Maturity_vsetky == Maturita_konkretna, 1); % Index zadanej maturity TIPS

Data = Vynosy_do_splatnosti(:, Index_maturita); % Výnosy do splatnosti TIPS pre danú konštantnú maturitu v pobobe časovej tabuľky
Data_bez_NaN = rmmissing(Data); % Odstránenie NaN hodnôt z dát
Vynosy_do_splatnosti_bez_NaN = Data_bez_NaN{:, 1} / 100; % Jednotlivé zaznamenané výnosy do splatnosti TIPS pre danú konštantnú maturitu v desatinnej forme
Datumy_bez_NaN = Data_bez_NaN.Time; % Dátumy jednotlivých zaznamenaných výnosov TIPS pre danú koštantnú maturitu

Hruba_realna_cena_TIPS = zeros(length(Datumy_bez_NaN) - 1, 1); % Inicializácia vektora hrubých reálnych cien konštantného TIPS pre danú maturitu
Datum_ocenenia = NaT(length(Datumy_bez_NaN) - 1, 1); % Inicializácia vektora dátumov ocenenia TIPS s danou konštantnou maturitou

% Ocenenie TIPS:
for Mesiac = 1:(length(Datumy_bez_NaN) - 1) % Pre každý mesiac
    Datum_ocenenia(Mesiac) = Datumy_bez_NaN(Mesiac) + calmonths(1); % Dátum kedy oceňujeme TIPS s danou konštantnou maturitou
    
    % Cena TIPS:
    [Cista_cena, Alikvotny_urok] = bndprice(Vynosy_do_splatnosti_bez_NaN(Mesiac + 1), ... % Výnosy do splatnosti TIPS pre danú konštantnú maturitu v danom mesiaci
                                            Vynosy_do_splatnosti_bez_NaN(Mesiac), ... % Kupónová sadzba TIPS pre danú konštantnú maturitu 
                                            Datum_ocenenia(Mesiac), ... % Dátum ocenenia TIPS pre danú konštantnú maturitu
                                            Datumy_bez_NaN(Mesiac) + calmonths(Maturita_konkretna * 12), ... % Dátum maturity daného konštantného TIPS
                                            'Period', 2, ... % Koľkokrát TIPS ročne vyplatí kupón
                                            'Face', 100);  % Nominálna hodnota konštatného TIPS s danou maturitou
                                      
   Hruba_realna_cena_TIPS(Mesiac) = Cista_cena + Alikvotny_urok; % Reálna čistá cena TIPS s danou konštantnou maturitou 
end

Ceny_TIPS_TT = timetable(Datum_ocenenia, Hruba_realna_cena_TIPS, 'VariableNames', {'Hruba_realna_cena'}); % Časová tabuľka reálnych hrubých cien TIPS s danou konštantnou maturitou v jednotlivých dátumoch
                       
end % Koniec funkcie