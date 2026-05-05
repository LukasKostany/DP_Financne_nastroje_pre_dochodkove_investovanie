function [Finalny_nahradovy_pomer, AFS, w_SAP] = MaxMin(Doba_sporenia_mesiace, Realne_logaritmicke_mesacne_vynosy_SAP_500, Realne_logaritmicke_mesacne_vynosy_dlhopis, Realne_hodnoty_pociatocnej_investicie_SAP_500, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevky) % Funkcia na simuláciu dôchodkového sporenia pomocou stratégie MaxMin
% Vykoná historickú simulácia dôchodkovej sporivej stratégie MaxMin
% Vypočíta finálny náhradový pomer a vráti vývoj AFS a podielu investovaných prostiedkov do akciového indexu S&P 500 pre dôchodkovú investičnú stratégiu MaxMin

% Vstupy:
% Doba sporenia mesiace - koľko mesiacov si bude investor sporiť na dôchodok
% Reálne logaritmické mesačné výnosy S&P 500 - mesačné reálne logaritmické výnosy akciového indexu S&P 500
% Reálne logaritmické mesačné výnosy dlhopis - mesačné reálne logaritmické výnosy amerického štátneho dlhopisu s konštantnou maturitou 7 rokov
% Reálne hodnoty počiatočnej investície S&P 500 - reálne hodnoty počiatočnej investície do akciového indexu S&P 500 v čase 
% Reálne hodnoty SeLFIES - reálne hodnoty SeLFIES s jednotlivými konverziami v každom mesiaci sporenia
% Cielený reálny dôchodkový príjem - sporiteľov cieľový reálny mesačný dôchodkový príjem
% Príspevky - koľko peňažných jednotiek prispel sporiteľ do dôchodkovej investičnej stratégie daný mesiac sporenia

% Výstupy:
% Finálny náhradový pomer - výsledný finálny náhradový pomer sporiteľa dosiahnutý dochodkovou investičnou stratégiou MaxMin
% AFS - jednotlivé hodnoty aktuálneho stavu financovania (AFS) pre stratégiu MaxMin
% w_SAP - jednotlivé hodnoty podielu investovaných prostiedkov do akciového indexu S&P 500 pre stratégiu MaxMin

% Parametre dôchodkovej investičnej stratégie MaxMin:
k = 2/7; % Podiel 2 a počtu pozorovaných mesiacov zvýšesených o 1

% Historická simulácia:
% Inicializácia vektorov:
Stop_Loss = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora rozhodavacieho kritéria Stop-Loss dôchodkovej investičnej stratégie MaxMin
Buy = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora rozhodavacieho kritéria Buy dôchodkovej investičnej stratégie MaxMin
EMA = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora hodnôt EMA v dôchodkovej investičnej stratégii MaxMin
Citlivost = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora hodnôt citlivosti voči riziku u sporiteľa v dôchodkovej investičnej stratégii MaxMin
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
    Citlivost(Mesiac_sporenia) = (Mesiac_sporenia^(Mesiac_sporenia / Doba_sporenia_mesiace) + Mesiac_sporenia) / (2 * Doba_sporenia_mesiace); % Hodnota citlivosti voči riziku u sporiteľa v dôchodkovej investičnej stratégii MaxMin
    
    if Mesiac_sporenia < 6 % Ak je doba sporenia kratšia ako 6 mesiacov
       if Realne_hodnoty_pociatocnej_investicie_SAP_500(Mesiac_sporenia) >= max(Realne_hodnoty_pociatocnej_investicie_SAP_500(1:Mesiac_sporenia)) % Ak je splnená podmienka rozhodavacieho kritéria Buy dôchodkovej investičnej stratégie MaxMin
          Buy(Mesiac_sporenia) = 1; % Hodnota rozhodavacieho kritéria Buy dôchodkovej investičnej stratégie MaxMin
       else % Ak nie je splnená podmienka rozhodavacieho kritéria Buy dôchodkovej investičnej stratégie MaxMin
            Buy(Mesiac_sporenia) = 0; % Hodnota rozhodavacieho kritéria Buy dôchodkovej investičnej stratégie MaxMin
       end     
    else % Ak je doba sporenia aspoň 6 mesiacov
         if Realne_hodnoty_pociatocnej_investicie_SAP_500(Mesiac_sporenia) >= max(Realne_hodnoty_pociatocnej_investicie_SAP_500((Mesiac_sporenia - 5):Mesiac_sporenia)) % Ak je splnená podmienka rozhodavacieho kritéria Buy dôchodkovej investičnej stratégie MaxMin
            Buy(Mesiac_sporenia) = 1; % Hodnota rozhodavacieho kritéria Buy dôchodkovej investičnej stratégie MaxMin
         else % Ak nie je splnená podmienka rozhodavacieho kritéria Buy dôchodkovej investičnej stratégie MaxMin
              Buy(Mesiac_sporenia) = 0; % Hodnota rozhodavacieho kritéria Buy dôchodkovej investičnej stratégie MaxMin
         end     
    end 
    
    if Mesiac_sporenia < 6 % Ak je doba sporenia kratšia ako 6 mesiacov
       EMA(Mesiac_sporenia) = ((Realne_hodnoty_pociatocnej_investicie_SAP_500(Mesiac_sporenia) * k) + (min(Realne_hodnoty_pociatocnej_investicie_SAP_500(1:Mesiac_sporenia)) * (1 - k))) * Citlivost(Mesiac_sporenia); % Hodnota EMA v dôchodkovej investičnej stratégii MaxMin
       if Realne_hodnoty_pociatocnej_investicie_SAP_500(Mesiac_sporenia) <= (min(EMA(1:Mesiac_sporenia)) * Citlivost(Mesiac_sporenia)) % Ak je splnená podmienka rozhodavacieho kritéria Stop-Loss dôchodkovej investičnej stratégie MaxMin
          Stop_Loss(Mesiac_sporenia) = 1; % Hodnota rozhodavacieho kritéria Stop-Loss dôchodkovej investičnej stratégie MaxMin
       else % Ak nie je splnená podmienka rozhodavacieho kritéria Stop-Loss dôchodkovej investičnej stratégie MaxMin
            Stop_Loss(Mesiac_sporenia) = 0; % Hodnota rozhodavacieho kritéria Stop-Loss dôchodkovej investičnej stratégie MaxMin
       end     
    else % Ak je doba sporenia aspoň 6 mesiacov
         EMA(Mesiac_sporenia) = ((Realne_hodnoty_pociatocnej_investicie_SAP_500(Mesiac_sporenia) * k) + (min(Realne_hodnoty_pociatocnej_investicie_SAP_500((Mesiac_sporenia - 5):Mesiac_sporenia)) * (1 - k))) * Citlivost(Mesiac_sporenia); % Hodnota EMA v dôchodkovej investičnej stratégii MaxMin
         if Realne_hodnoty_pociatocnej_investicie_SAP_500(Mesiac_sporenia) <= (min(EMA((Mesiac_sporenia - 5):Mesiac_sporenia)) * Citlivost(Mesiac_sporenia)) % Ak je splnená podmienka rozhodavacieho kritéria Stop-Loss dôchodkovej investičnej stratégie MaxMin
            Stop_Loss(Mesiac_sporenia) = 1; % Hodnota rozhodavacieho kritéria Stop-Loss dôchodkovej investičnej stratégie MaxMin
         else % Ak nie je splnená podmienka rozhodavacieho kritéria Stop-Loss dôchodkovej investičnej stratégie MaxMin
              Stop_Loss(Mesiac_sporenia) = 0; % Hodnota rozhodavacieho kritéria Stop-Loss dôchodkovej investičnej stratégie MaxMin
         end     
    end 
    
    Hodnota_investicie_SAP_500(Mesiac_sporenia) = w_SAP(Mesiac_sporenia - 1) * Celkova_hodnota_prostriedkov(Mesiac_sporenia - 1) * exp(Realne_logaritmicke_mesacne_vynosy_SAP_500(Posun + Mesiac_sporenia - 1)); % Hodnota sporiteľových prostiedkov investovaných do akciového indexu S&P 500
    Realny_prijem_zo_SAP_500(Mesiac_sporenia) = Hodnota_investicie_SAP_500(Mesiac_sporenia) / Realne_hodnoty_SeLFIES(Posun + Mesiac_sporenia, (Doba_sporenia_mesiace + 1) - Mesiac_sporenia); % Reálny príjem dostupný z prostiedkov investovaných do akciového indexu S&P 500
    
    Hodnota_investicie_dlhopis(Mesiac_sporenia) = w_dlhopis * Celkova_hodnota_prostriedkov(Mesiac_sporenia - 1)  * exp(Realne_logaritmicke_mesacne_vynosy_dlhopis(Posun + Mesiac_sporenia - 1)); % Hodnota sporiteľových prostiedkov investovaných do amerického štátneho dlhopisu s konštantnou maturitou 7 rokov
    Realny_prijem_z_dlhopisu(Mesiac_sporenia) = Hodnota_investicie_dlhopis(Mesiac_sporenia) / Realne_hodnoty_SeLFIES(Posun + Mesiac_sporenia, (Doba_sporenia_mesiace + 1) - Mesiac_sporenia); % Reálny príjem dostupný z prostiedkov investovaných do amerického štátneho dlhopisu s konštantnou maturitou 7 rokov
    
    AFS(Mesiac_sporenia) = (Realny_prijem_z_dlhopisu(Mesiac_sporenia) + Realny_prijem_zo_SAP_500(Mesiac_sporenia)) / Cieleny_realny_dochodkovy_prijem(Mesiac_sporenia); % Aktuálny stav financovania cieľového reálneho dôchodkového príjmu
        
    Celkova_hodnota_prostriedkov(Mesiac_sporenia) = Hodnota_investicie_dlhopis(Mesiac_sporenia) + Hodnota_investicie_SAP_500(Mesiac_sporenia) + Prispevky(Mesiac_sporenia); % Celková hodnota sporiteľových prostriedkov
        
    if Stop_Loss(Mesiac_sporenia) == 0 && Buy(Mesiac_sporenia) == 1 % Ak platí rozhodovacie kritérium v dôchodkovej investičnej stratégii MaxMin
       w_SAP(Mesiac_sporenia) = 1; % Alokácia sporiteľových prostiedkov do akciového indexu S&P 500
    else % Ak neplatí rozhodovacie kritérium v dôchodkovej investičnej stratégii MaxMin
         w_SAP(Mesiac_sporenia) = 0; % Alokácia sporiteľových prostiedkov do akciového indexu S&P 500
    end
        
    w_dlhopis = 1 - w_SAP(Mesiac_sporenia); % Alokácia sporiteľových prostiedkov do amerického štátneho dlhopisu s konštantnou maturitou 7 rokov
end

Finalny_nahradovy_pomer = AFS(end); % Výsledný náhradový pomer sporiteľa

end % Koniec funkcie
