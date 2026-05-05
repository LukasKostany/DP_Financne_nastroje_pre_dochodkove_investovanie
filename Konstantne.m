function [Finalny_nahradovy_pomer, AFS] = Konstantne(Doba_sporenia_mesiace, Pomer_SAP_500, Realne_logaritmicke_mesacne_vynosy_SAP_500, Realna_hodnota_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevky) % Funkcia na simuláciu dôchodkového sporenia pomocou stratégií s konštantným pomerom aktív
% Vykoná historickú simulácia dôchodkovej investičnej stratégie so stanoveným konštantným pomerom rozdelenia prostriedkov medzi S&P 500 a SeLFIES 
% Vypočíta finálny náhradový pomer a vráti vývoj AFS pre dôchodkovú investičnú stratégiu so zvoleným konštantným pomerom rozdelenia sporiteľových zdrojov medzi akciový index S&P 500 a dôchodkové dlhopisy SeLFIES 

% Vstupy:
% Doba sporenia mesiace - koľko mesiacov si bude investor sporiť na dôchodok
% Pomer S&P 500 - aká čast z celkovej hodnoty sporiteľových prostriedkov bude investovaná do akciového indexu S&P 500
% Reálne logaritmické mesačné výnosy S&P 500 - reálne mesačné logaritmické výnosy akciového indexu S&P 500
% Reálna hodnota SeLFIES - reálne hodnoty SeLFIES s jednotlivými konverziami v každom mesiaci sporenia
% Cielený reálny dôchodkový príjem - sporiteľov cieľový reálny mesačný dôchodkový príjem
% Príspevky - koľko peňažných jednotiek prispel sporiteľ do dôchodkovej investičnej stratégie daný mesiac sporenia

% Výstupy:
% Finálny náhradový pomer - výsledný finálny náhradový pomer sporiteľa dosiahnutý daným nastavením dôchodkovej investičnej stratégie s konštantným pomerom aktív
% AFS - jednotlivé hodnoty aktuálneho stavu financovania (AFS) pre dané nastavenie dôchodkovej investičnej stratégie s konštantným pomerom aktív

% Historická simulácia:
% Inicializácia vektorov:
AFS = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora aktuálneho stavu financovania cieľového reálneho dôchodkového príjmu
Hodnota_investicie_SAP_500 = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora hodnoty sporiteľových prostiedkov investovaných do akciového indexu S&P 500
Realny_prijem_zo_SAP_500 = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora reálneho príjmu dostupného z prostiedkov investovaných do akciového indexu S&P 500
Hodnota_drzanych_SeLFIES = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora hodnoty držaných dôchodkových dlhopisov SeLFIES
Pocet_kusov_SeLFIES = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora počtu držaných dôchodkových dlhopisov SeLFIES - mesačného reálneho príjmu z nich
Celkova_hodnota_prostriedkov = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora celkovej hodnoty investorových prostriedkov

% Nastavenie konštantných alokačných pomerov dôchodkovej investičnej stratégie:
w_SAP = Pomer_SAP_500;  % Konštantný pomer alokácie sporiteľových prostiedkov do akciového indexu S&P 500
w_SeLFIES = 1 - w_SAP; % Konštantný pomer alokácie sporiteľových prostiedkov do dôchodkových dlhopisov SeLFIES

% Hodnoty premenných v prvom mesiaci sporenia:
AFS(1) = 0; % Aktuálny stav financovania cieľového reálneho dôchodkového príjmu v prvom mesiaci sporenia
Celkova_hodnota_prostriedkov(1) = Prispevky(1); % Celková hodnota investorových prostriedkov v prvom mesiaci sporenia

Posun = 528 - Doba_sporenia_mesiace; % Posun hodnôt pri odlišných obdobiach dôchodkového sporenia

for Mesiac_sporenia = 2:Doba_sporenia_mesiace % Pre každý mesiac sporenia
    Hodnota_investicie_SAP_500(Mesiac_sporenia) = w_SAP * Celkova_hodnota_prostriedkov(Mesiac_sporenia - 1) * exp(Realne_logaritmicke_mesacne_vynosy_SAP_500(Posun + Mesiac_sporenia - 1)); % Hodnota sporiteľových prostiedkov investovaných do akciového indexu S&P 500
    Realny_prijem_zo_SAP_500(Mesiac_sporenia) = Hodnota_investicie_SAP_500(Mesiac_sporenia) / Realna_hodnota_SeLFIES(Posun + Mesiac_sporenia, (Doba_sporenia_mesiace + 1 - Mesiac_sporenia)); % Reálny príjem dostupný z prostiedkov investovaných do akciového indexu S&P 500
    
    Pocet_kusov_SeLFIES(Mesiac_sporenia) = (w_SeLFIES * Celkova_hodnota_prostriedkov(Mesiac_sporenia - 1)) / Realna_hodnota_SeLFIES(Posun + Mesiac_sporenia - 1, (Doba_sporenia_mesiace + 1) - (Mesiac_sporenia - 1)); % Počet držaných dôchodkových dlhopisov SeLFIES - reálny príjem z nich
    Hodnota_drzanych_SeLFIES(Mesiac_sporenia) = Pocet_kusov_SeLFIES(Mesiac_sporenia) * Realna_hodnota_SeLFIES(Posun + Mesiac_sporenia, (Doba_sporenia_mesiace + 1) - Mesiac_sporenia); % Hodnota držaných dôchodkových dlhopisov SeLFIES
    
    AFS(Mesiac_sporenia) = (Pocet_kusov_SeLFIES(Mesiac_sporenia) + Realny_prijem_zo_SAP_500(Mesiac_sporenia)) / Cieleny_realny_dochodkovy_prijem(Mesiac_sporenia); % Aktuálny stav financovania cieľového reálneho dôchodkového príjmu
        
    Celkova_hodnota_prostriedkov(Mesiac_sporenia) = Hodnota_investicie_SAP_500(Mesiac_sporenia) + Hodnota_drzanych_SeLFIES(Mesiac_sporenia) + Prispevky(Mesiac_sporenia); % Celková hodnota sporiteľových prostriedkov
end
    
Finalny_nahradovy_pomer = AFS(end); % Výsledný náhradový pomer sporiteľa

end % Koniec funckie