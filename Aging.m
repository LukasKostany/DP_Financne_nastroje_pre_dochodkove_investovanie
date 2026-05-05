function [Finalny_nahradovy_pomer, AFS] = Aging(Doba_sporenia_mesiace, Typ, Realne_mesacne_logaritmicke_vynosy_SAP_500, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevky) % Funkcia na simuláciu dôchodkového sporenia pomocou stratégie Aging
% Vykoná historickú simulácia dôchodkovej investičnej stratégie založenej na veku sporiteľa - Aging
% Vypočíta finálny náhradový pomer a vráti vývoj AFS pre zvolenú dôchodkovú investičnú stratégiu založenú na veku sporiteľa - Aging

% Vstupy:
% Doba sporenia mesiace - koľko mesiacov si bude investor sporiť na dôchodok
% Typ - typ dôchodkovej investičnej stratégie založenej na veku sporiteľa - Aging   
% Reálne mesačné logaritmické výnosy S&P 500 - mesačné reálne logaritmické výnosy akciového indexu S&P 500
% Reálne hodnoty SeLFIES - reálne hodnoty SeLFIES s jednotlivými konverziami v každom mesiaci sporenia
% Cielený reálny dôchodkový príjem - sporiteľov cieľový reálny mesačný dôchodkový príjem
% Príspevky - koľko peňažných jednotiek prispel sporiteľ do dôchodkovej investičnej stratégie daný mesiac sporenia

% Výstupy:
% Finálny náhradový pomer - výsledný finálny náhradový pomer sporiteľa
% dosiahnutý zvolenou dôchodkovou investičnou stratégiou založenou na veku sporiteľa - Aging
% AFS - jednotlivé hodnoty aktuálneho stavu financovania (AFS) pre zvolenú stratégiu založenú na veku sporiteľa - Aging

% Historická simulácia:
% Inicializácia vektorov:
Vek_sporitela = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora veku dôchodkového sporiteľa
AFS = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora aktuálneho stavu financovania cieľového reálneho dôchodkového príjmu
w_SAP = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora alokácie sporiteľových prostiedkov do akciového indexu S&P 500
Hodnota_investicie_SAP_500 = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora hodnoty sporiteľových prostiedkov investovaných do akciového indexu S&P 500
Realny_prijem_zo_SAP_500 = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora reálneho príjmu dostupného z prostiedkov investovaných do akciového indexu S&P 500
Hodnota_drzanych_SeLFIES = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora hodnoty držaných dôchodkových dlhopisov SeLFIES
Pocet_kusov_SeLFIES = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora počtu držaných dôchodkových dlhopisov SeLFIES - reálneho mesačného príjmu z nich
Celkova_hodnota_prostriedkov = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora celkovej hodnoty investorových prostriedkov

% Hodnoty premenných v prvom  mesiaci sporenia:
Vek_sporitela(1) = 65 - Doba_sporenia_mesiace / 12; % Vek dôchodkového investora v prvom mesiaci sporenia
AFS(1) = 0; % Aktuálny stav financovania cieľového reálneho dôchodkového príjmu v prvom mesiaci sporenia
Celkova_hodnota_prostriedkov(1) = Prispevky(1); % Celková hodnota investorových prostriedkov v prvom mesiaci sporenia

if Typ == "1" % Ak ide o dôchodkovú investičnú stratégiu Aging 1
   w_SAP(1) = 1 - (Vek_sporitela(1) / 100); % Alokácia sporiteľových prostiedkov do akciového indexu S&P 500 v prvom mesiaci sporenia
elseif Typ == "2" % Ak ide o dôchodkovú investičnú stratégiu Aging 2
       w_SAP(1) = 1 - (1 / (Doba_sporenia_mesiace / 12)); % Alokácia sporiteľových prostiedkov do akciového indexu S&P 500 v prvom mesiaci sporenia
elseif Typ == "3" % Ak ide o dôchodkovú investičnú stratégiu Aging 3
       w_SAP(1) = Vek_sporitela(1) / 100; % Alokácia sporiteľových prostiedkov do akciového indexu S&P 500 v prvom mesiaci sporenia
else % Ak ide o dôchodkovú investičnú stratégiu Aging 4
     w_SAP(1) = 1 / (Doba_sporenia_mesiace / 12); % Alokácia sporiteľových prostiedkov do akciového indexu S&P 500 v prvom mesiaci sporenia
end

w_SeLFIES = 1 - w_SAP(1); % Alokácia sporiteľových prostiedkov do nákupu dôchodkových dlhopisov SeLFIES v prvom mesiaci sporenia

Posun = 528 - Doba_sporenia_mesiace; % Posun hodnôt pri odlišných obdobiach dôchodkového sporenia

for Mesiac_sporenia = 2:Doba_sporenia_mesiace % Pre každý mesiac sporenia
    Vek_sporitela(Mesiac_sporenia) = Vek_sporitela(1) + ((Mesiac_sporenia - 1) / 12); % Vek dôchodkového sporiteľa
    
    Hodnota_investicie_SAP_500(Mesiac_sporenia) = w_SAP(Mesiac_sporenia - 1) * Celkova_hodnota_prostriedkov(Mesiac_sporenia - 1) * exp(Realne_mesacne_logaritmicke_vynosy_SAP_500(Posun + Mesiac_sporenia - 1)); % Hodnota sporiteľových prostiedkov investovaných do akciového indexu S&P 500
    Realny_prijem_zo_SAP_500(Mesiac_sporenia) = Hodnota_investicie_SAP_500(Mesiac_sporenia) / Realne_hodnoty_SeLFIES(Posun + Mesiac_sporenia, (Doba_sporenia_mesiace + 1 - Mesiac_sporenia)); % Reálny príjem dostupný z prostiedkov investovaných do akciového indexu S&P 500
    
    Pocet_kusov_SeLFIES(Mesiac_sporenia) = (w_SeLFIES * Celkova_hodnota_prostriedkov(Mesiac_sporenia - 1)) / Realne_hodnoty_SeLFIES(Posun + Mesiac_sporenia - 1, (Doba_sporenia_mesiace + 1) - (Mesiac_sporenia - 1)); % Počet držaných dôchodkových dlhopisov SeLFIES - reálny mesačný príjem z nich
    Hodnota_drzanych_SeLFIES(Mesiac_sporenia) = Pocet_kusov_SeLFIES(Mesiac_sporenia) * Realne_hodnoty_SeLFIES(Posun + Mesiac_sporenia, (Doba_sporenia_mesiace + 1) - Mesiac_sporenia); % Hodnota držaných dôchodkových dlhopisov SeLFIES
        
    AFS(Mesiac_sporenia) = (Pocet_kusov_SeLFIES(Mesiac_sporenia) + Realny_prijem_zo_SAP_500(Mesiac_sporenia)) / Cieleny_realny_dochodkovy_prijem(Mesiac_sporenia); % Aktuálny stav financovania cieľového reálneho dôchodkového príjmu
    
    Celkova_hodnota_prostriedkov(Mesiac_sporenia) = Hodnota_investicie_SAP_500(Mesiac_sporenia) + Hodnota_drzanych_SeLFIES(Mesiac_sporenia) + Prispevky(Mesiac_sporenia); % Celková hodnota sporiteľových prostriedkov
        
    if Typ == "1" % Ak ide o dôchodkovú investičnú stratégiu Aging 1
       w_SAP(Mesiac_sporenia) = 1 - (floor(Vek_sporitela(Mesiac_sporenia)) / 100); % Alokácia sporiteľových prostiedkov do akciového indexu S&P 500
    elseif Typ == "2" % Ak ide o dôchodkovú investičnú stratégiu Aging 2
           w_SAP(Mesiac_sporenia) = 1 - (ceil(Mesiac_sporenia / 12) / (Doba_sporenia_mesiace / 12)); % Alokácia sporiteľových prostiedkov do akciového indexu S&P 500
    elseif Typ == "3" % Ak ide o dôchodkovú investičnú stratégiu Aging 3
           w_SAP(Mesiac_sporenia) = floor(Vek_sporitela(Mesiac_sporenia)) / 100; % Alokácia sporiteľových prostiedkov do akciového indexu S&P 500
    else % Ak ide o dôchodkovú investičnú stratégiu Aging 4
         w_SAP(Mesiac_sporenia) = ceil(Mesiac_sporenia / 12) / (Doba_sporenia_mesiace / 12); % Alokácia sporiteľových prostiedkov do akciového indexu S&P 500
    end
        
    w_SeLFIES = 1 - w_SAP(Mesiac_sporenia); % Alokácia sporiteľových prostiedkov do nákupu dôchodkových dlhopisov SeLFIES
end

Finalny_nahradovy_pomer = AFS(end); % Výsledný náhradový pomer sporiteľa

end % Koniec funckie