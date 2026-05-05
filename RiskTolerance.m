function [Finalny_nahradovy_pomer, AFS, w_SAP] = RiskTolerance(Doba_sporenia_mesiace, Realne_logaritmicke_mesacne_vynosy_SAP_500, Realne_logaritmicke_mesacne_vynosy_dlhopis, Realne_hodnoty_pociatocnej_investicie_SAP_500, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevky) % Funkcia na simuláciu dôchodkového sporenia pomocou stratégie RiskTolerance
% Vykoná historickú simulácia dôchodkovej sporivej stratégie RiskTolerance
% Vypočíta finálny náhradový pomer a vráti vývoj AFS a podielu investovaných prostiedkov do akciového indexu S&P 500 pre dôchodkovú investičnú stratégiu RiskTolerance

% Vstupy:
% Doba sporenia mesiace - koľko mesiacov si bude investor sporiť na dôchodok
% Reálne logaritmické mesačné výnosy S&P 500 - mesačné reálne logaritmické výnosy akciového indexu S&P 500
% Reálne logaritmické mesačné výnosy dlhopis - mesačné reálne logaritmické výnosy amerického štátneho dlhopisu s konštantnou maturitou 7 rokov
% Reálne hodnoty počiatočnej investície S&P 500 - reálne hodnoty počiatočnej investície do akciového indexu S&P 500 v čase 
% Reálne hodnoty SeLFIES - reálne hodnoty SeLFIES s jednotlivými konverziami v každom mesiaci sporenia
% Cielený reálny dôchodkový príjem - sporiteľov cieľový reálny mesačný dôchodkový príjem
% Príspevky - koľko peňažných jednotiek prispel sporiteľ do dôchodkovej investičnej stratégie daný mesiac sporenia

% Výstupy:
% Finálny náhradový pomer - výsledný finálny náhradový pomer sporiteľa dosiahnutý dochodkovou investičnou stratégiou RiskTolerance
% AFS - jednotlivé hodnoty aktuálneho stavu financovania (AFS) pre stratégiu RiskTolerance
% w_SAP - jednotlivé hodnoty podielu investovaných prostiedkov do akciového indexu S&P 500 pre stratégiu RiskTolerance

% Parametre dôchodkovej investičnej stratégie RiskTolerance:
n = 5; % 6 pozorovaných mesiacov v dôchodkovej sporivej stratégii RiskTolerance

% Historická simulácia:
% Inicializácia vektorov:
Suma_Buy = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora sumy v alokačnom kritériu dôchodkovej investičnej stratégie RiskTolerance
Buy = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora hodnoty Buy v dôchodkovej investičnej stratégii RiskTolerance
k = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora parametra k používaného pri výpočte hodnoty dynamického rizika v dôchodkovej investičnej stratégii RiskTolerance
DR = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora hodnoty dynamického rizika v dôchodkovej investičnej stratégii RiskTolerance
D_max = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora maximálnej hodnoty reálnej počiatočnej investície do akciového indexu S&P 500 v časovom horizonte od k po súčasný mesiac sporenia
D_min = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora minimálnej hodnoty reálnej počiatočnej investície do akciového indexu S&P 500 v časovom horizonte od k po súčasný mesiac sporenia
AFS = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora aktuálneho stavu financovania cieľového reálneho dôchodkového príjmu
w_SAP = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora alokácie sporiteľových prostiedkov do akciového indexu S&P 500
Hodnota_investicie_SAP_500 = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora hodnoty sporiteľových prostiedkov investovaných do akciového indexu S&P 500
Realny_prijem_zo_SAP_500 = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora reálneho príjmu dostupného z prostiedkov investovaných do akciového indexu S&P 500
Hodnota_investicie_dlhopis = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora hodnoty sporiteľových prostiedkov investovaných do amerického štátneho dlhopisu s konštantnou maturitou 7 rokov
Realny_prijem_z_dlhopisu = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora reálneho príjmu dostupného z prostiedkov investovaných do amerického štátneho dlhopisu s konštantnou maturitou 7 rokov
Celkova_hodnota_prostriedkov = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora celkovej hodnoty investorových prostriedkov

% Hodnoty premenných v prvom mesiaci sporenia:
AFS(1) = 0; % Aktuálny stav financovania cieľového reálneho dôchodkového príjmu v prvom mesiaci sporenia
w_SAP(1) = 1; % Alokácia sporiteľových prostiedkov do akciového indexu S&P 500 v prvom mesiaci sporenia
w_dlhopis = 0; % Alokácia sporiteľových prostiedkov do amerického štátneho dlhopisu s konštantnou maturitou 7 rokov v prvom mesiaci sporenia
Celkova_hodnota_prostriedkov(1) = Prispevky(1); % Celková hodnota investorových prostriedkov v prvom mesiaci sporenia

Posun = 528 - Doba_sporenia_mesiace; % Posun hodnôt pri odlišných obdobiach dôchodkového sporenia

for Mesiac_sporenia = 2:Doba_sporenia_mesiace % Pre každý mesiac sporenia
    k(Mesiac_sporenia) = max(1, ((2 * Mesiac_sporenia) - Doba_sporenia_mesiace)); % Parameter k používaný pri výpočte hodnoty dynamického rizika v dôchodkovej investičnej stratégii RiskTolerance
    D_max(Mesiac_sporenia) = max(Realne_hodnoty_pociatocnej_investicie_SAP_500(k(Mesiac_sporenia):Mesiac_sporenia)); % Maximálna hodnota reálnej počiatočnej investície do akciového indexu S&P 500 v časovom horizonte od k po súčasný mesiac sporenia
    D_min(Mesiac_sporenia) = min(Realne_hodnoty_pociatocnej_investicie_SAP_500(k(Mesiac_sporenia):Mesiac_sporenia)); % Minimálna hodnota počiatočnej investície do akciového indexu S&P 500 v časovom horizonte od k po súčasný mesiac sporenia
    
    if D_max(Mesiac_sporenia) > D_min(Mesiac_sporenia) % Ak je maximálna reálna hodnota počiatočnej investície do akciového indexu S&P 500 v časovom horizonte od k po súčasný mesiac sporenia väčšia ako minimálna
       DR(Mesiac_sporenia) = (D_max(Mesiac_sporenia) - Realne_hodnoty_pociatocnej_investicie_SAP_500(Mesiac_sporenia)) / (D_max(Mesiac_sporenia) - D_min(Mesiac_sporenia)); % Hodnota dynamického rizika v dôchodkovej investičnej stratégii RiskTolerance
    else % Ak nie je maximálna reálna hodnota počiatočnej investície do akciového indexu S&P 500 v časovom horizonte od k po súčasný mesiac sporenia väčšia ako minimálna
         DR(Mesiac_sporenia) = 0; % Hodnota dynamického rizika v dôchodkovej investičnej stratégii RiskTolerance
    end
    
    Buy(Mesiac_sporenia) = 1 - DR(Mesiac_sporenia); % Hodnota Buy v dôchodkovej investičnej stratégii RiskTolerance
        
    Hodnota_investicie_SAP_500(Mesiac_sporenia) = w_SAP(Mesiac_sporenia - 1) * Celkova_hodnota_prostriedkov(Mesiac_sporenia - 1) * exp(Realne_logaritmicke_mesacne_vynosy_SAP_500(Posun + Mesiac_sporenia - 1)); % Hodnota sporiteľových prostiedkov investovaných do akciového indexu S&P 500
    Realny_prijem_zo_SAP_500(Mesiac_sporenia) = Hodnota_investicie_SAP_500(Mesiac_sporenia) / Realne_hodnoty_SeLFIES(Posun + Mesiac_sporenia, (Doba_sporenia_mesiace + 1) - Mesiac_sporenia); % Reálny príjem dostupný z prostiedkov investovaných do akciového indexu S&P 500
    
    Hodnota_investicie_dlhopis(Mesiac_sporenia) = w_dlhopis * Celkova_hodnota_prostriedkov(Mesiac_sporenia - 1)  * exp(Realne_logaritmicke_mesacne_vynosy_dlhopis(Posun + Mesiac_sporenia - 1)); % Hodnota sporiteľových prostiedkov investovaných do amerického štátneho dlhopisu s konštantnou maturitou 7 rokov
    Realny_prijem_z_dlhopisu(Mesiac_sporenia) = Hodnota_investicie_dlhopis(Mesiac_sporenia) / Realne_hodnoty_SeLFIES(Posun + Mesiac_sporenia, (Doba_sporenia_mesiace + 1) - Mesiac_sporenia); % Reálny príjem dostupný z prostiedkov investovaných do amerického štátneho dlhopisu s konštantnou maturitou 7 rokov
    
    AFS(Mesiac_sporenia) = (Realny_prijem_z_dlhopisu(Mesiac_sporenia) + Realny_prijem_zo_SAP_500(Mesiac_sporenia)) / Cieleny_realny_dochodkovy_prijem(Mesiac_sporenia); % Aktuálny stav financovania cieľového reálneho dôchodkového príjmu
    
    Celkova_hodnota_prostriedkov(Mesiac_sporenia) = Hodnota_investicie_dlhopis(Mesiac_sporenia) + Hodnota_investicie_SAP_500(Mesiac_sporenia) + Prispevky(Mesiac_sporenia); % Celková hodnota sporiteľových prostriedkov
    
    if Mesiac_sporenia < 6 % Ak je doba sporenia kratšia ako 6 mesiacov
       Suma_Buy(Mesiac_sporenia) = sum(Buy(1:Mesiac_sporenia)); % Suma v čitateli alokačného kritéria dôchodkovej investičnej stratégie RiskTolerance
       w_SAP(Mesiac_sporenia) = Suma_Buy(Mesiac_sporenia) / length(Buy(1:Mesiac_sporenia)); % Alokácia sporiteľových prostiedkov do akciového indexu S&P 500
    else % Ak je doba sporenia aspoň 6 mesiacov
         Suma_Buy(Mesiac_sporenia) = sum(Buy((Mesiac_sporenia - n):Mesiac_sporenia)); % Suma v čitateli alokačného kritéria dôchodkovej investičnej stratégie RiskTolerance
         w_SAP(Mesiac_sporenia) = Suma_Buy(Mesiac_sporenia) / (n + 1); % Alokácia sporiteľových prostiedkov do akciového indexu S&P 500
    end 
    
    w_dlhopis = 1 - w_SAP(Mesiac_sporenia); % Alokácia sporiteľových prostiedkov do amerického štátneho dlhopisu s konštantnou maturitou 7 rokov
    
end

Finalny_nahradovy_pomer = AFS(end); % Výsledný náhradový pomer sporiteľa

end % Koniec funkcie
