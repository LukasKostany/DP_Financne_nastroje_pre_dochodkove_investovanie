function [Finalny_nahradovy_pomer, AFS, w_SAP] = GLIDeS(Doba_sporenia_mesiace, Typ, Parametre, Logaritmicke_mesacne_realne_vynosy_SAP_500, Realne_hodnoty_SeLFIES, Cieleny_realny_mesacny_dochodkovy_prijem, Prispevky) % Funkcia na simuláciu dôchodkového sporenia pomocou stratégie GLIDeS
% Vykoná historickú simulácia dôchodkovej sporivej stratégie GLIDeS
% Vypočíta finálny náhradový pomer a vráti vývoj AFS a podielu investovaných prostiedkov do akciového indexu S&P 500 pre dané nastavenie dôchodkovej investičnej stratégie GLIDeS

% Vstupy:
% Doba sporenia mesiace - koľko mesiacov si bude investor sporiť na dôchodok
% Typ - aký typ GLIDeS simulujeme
% Parametre - parametre danej stratégie GLIDeS
% Logaritmické mesačné reálne výnosy S&P 500 - mesačné reálne logaritmické výnosy akciového indexu S&P 500
% Reálne hodnoty SeLFIES - reálne hodnoty SeLFIES s jednotlivými konverziami v každom mesiaci sporenia
% Cielený reálny mesačný dôchodkový príjem - sporiteľov cielený reálny mesačný dôchodkový príjem
% Príspevky - koľko peňažných jednotiek prispel sporiteľ do dôchodkovej investičnej stratégie daný mesiac sporenia

% Výstupy
% Finálny náhradový pomer - výsledný finálny náhradový pomer sporiteľa dosiahnutý daným nastavením dôchodkovej investičnej stratégie GLIDeS
% AFS - jednotlivé hodnoty aktuálneho stavu financovania (AFS) pre dané nastavenie dôchodkovej investičnej stratégie GLIDeS
% w_SAP - jednotlivé hodnoty podielu investovaných prostiedkov do akciového indexu S&P 500 pre dané nastavenie dôchodkovej investičnej stratégie GLIDeS

% Historická simulácia:
% Inicializácia vektorov:
AFS = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora aktuálneho stavu financovania cieľového reálneho dôchodkového príjmu
TFS = zeros(1,Doba_sporenia_mesiace); % Inicializácia vektora cieľového stavu financovania cieľového reálneho dôchodkového príjmu
w_SAP = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora alokácie sporiteľových prostiedkov do akciového indexu S&P 500
w_SeLFIES = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora alokácie sporiteľových prostiedkov do nákupu dôchodkových dlhopisov SeLFIES
Hodnota_investicie_SAP_500 = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora hodnoty sporiteľových prostiedkov investovaných do akciového indexu S&P 500
Realny_prijem_zo_SAP_500 = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora reálneho príjmu dostupného z prostiedkov investovaných do akciového indexu S&P 500
Hodnota_drzanych_SeLFIES = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora hodnoty držaných dôchodkových dlhopisov SeLFIES
Pocet_kusov_SeLFIES = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora počtu držaných dôchodkových dlhopisov SeLFIES - mesačného reálneho príjmu z nich
Celkova_hodnota_prostriedkov = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora celkovej hodnoty investorových prostriedkov

% Nastavenie parametrov GLIDeS:
if Typ == "Linear" % Ak ide o lineárne GLIDeS
   k = Parametre; % Nastavenie parametra k
elseif Typ == "Continous" % Ak ide o spojité GLIDeS
       l = Parametre(1); % Nastavenie parametra l
       z = Parametre(2); % Nastavenie parametra z
else % Ak ide o AFS-TFS GLIDeS
     b = Parametre; % Nastavenie parametra b
end

Posun = 528 - Doba_sporenia_mesiace; % Posun hodnôt pri odlišných obdobiach dôchodkového sporenia

% Hodnoty premenných v prvom mesiaci sporenia:
AFS(1) = 0; % Aktuálny stav financovania cieľového reálneho dôchodkového príjmu v prvom mesiaci sporenia
TFS(1) = 1/480; % Cieľový stav financovania cieľového reálneho dôchodkového príjmu v prvom mesiaci sporenia
if Typ == "AFS_TFS" % Ak ide o AFS-TFS GLIDeS
   w_SAP(1) = 0.5; % Alokácia sporiteľových prostiedkov do akciového indexu S&P 500 v prvom mesiaci sporenia
else % Ak ide o lineárne alebo spojité GLIDeS
    w_SAP(1) = 1; % Alokácia sporiteľových prostiedkov do akciového indexu S&P 500 v prvom mesiaci sporenia
end    
w_SeLFIES(1) = 1 - w_SAP(1); % Alokácia sporiteľových prostiedkov do nákupu dôchodkových dlhopisov SeLFIES v prvom mesiaci sporenia
Celkova_hodnota_prostriedkov(1) = Prispevky(1); % Celková hodnota investorových prostriedkov v prvom mesiaci sporenia

for Mesiac_sporenia = 2:Doba_sporenia_mesiace % Pre každý mesiac sporenia
    Hodnota_investicie_SAP_500(Mesiac_sporenia) = w_SAP(Mesiac_sporenia - 1) * Celkova_hodnota_prostriedkov(Mesiac_sporenia - 1) * exp(Logaritmicke_mesacne_realne_vynosy_SAP_500(Posun + Mesiac_sporenia - 1)); % Hodnota sporiteľových prostiedkov investovaných do akciového indexu S&P 500
    Realny_prijem_zo_SAP_500(Mesiac_sporenia) = Hodnota_investicie_SAP_500(Mesiac_sporenia) / Realne_hodnoty_SeLFIES(Posun + Mesiac_sporenia, (Doba_sporenia_mesiace + 1 - Mesiac_sporenia)); % Reálny príjem dostupný z prostiedkov investovaných do akciového indexu S&P 500
    
    Pocet_kusov_SeLFIES(Mesiac_sporenia) = (w_SeLFIES(Mesiac_sporenia - 1) * Celkova_hodnota_prostriedkov(Mesiac_sporenia - 1)) / Realne_hodnoty_SeLFIES(Posun + Mesiac_sporenia - 1, (Doba_sporenia_mesiace + 1) - (Mesiac_sporenia - 1)); % Počet držaných dôchodkových dlhopisov SeLFIES - reálny príjem z nich
    Hodnota_drzanych_SeLFIES(Mesiac_sporenia) = Pocet_kusov_SeLFIES(Mesiac_sporenia) * Realne_hodnoty_SeLFIES(Posun + Mesiac_sporenia, (Doba_sporenia_mesiace + 1 - Mesiac_sporenia)); % Hodnota držaných dôchodkových dlhopisov SeLFIES
    
    Celkova_hodnota_prostriedkov(Mesiac_sporenia) = Hodnota_investicie_SAP_500(Mesiac_sporenia) + Hodnota_drzanych_SeLFIES(Mesiac_sporenia) + Prispevky(Mesiac_sporenia); % Celková hodnota sporiteľových prostriedkov
    
    AFS(Mesiac_sporenia) = (Pocet_kusov_SeLFIES(Mesiac_sporenia) + Realny_prijem_zo_SAP_500(Mesiac_sporenia)) / Cieleny_realny_mesacny_dochodkovy_prijem(Mesiac_sporenia); % Aktuálny stav financovania cieľového reálneho dôchodkového príjmu
    TFS(Mesiac_sporenia) = Mesiac_sporenia / Doba_sporenia_mesiace; % Cieľový stav financovania cieľového reálneho dôchodkového príjmu
    
    if Typ == "Linear" % Ak ide o lineárne GLIDeS
       if AFS(Mesiac_sporenia) < 1 % Ak je aktuálny stav financovania cieľového reálneho dôchodkového príjmu menší ako 1
          w_SAP(Mesiac_sporenia) = max(1 - k * AFS(Mesiac_sporenia), 0); % Alokácia sporiteľových prostiedkov do akciového indexu S&P 500
       else % Ak je aktuálny stav financovania cieľového reálneho dôchodkového príjmu väčší alebo rovný 1
            w_SAP(Mesiac_sporenia) = 0; % Alokácia sporiteľových prostiedkov do akciového indexu S&P 500
       end
    elseif Typ == "Continous" % Ak ide o spojité GLIDeS 
           w_SAP(Mesiac_sporenia) = 1 - (1 / (1 + exp(-l * (AFS(Mesiac_sporenia) - z)))); % Alokácia sporiteľových prostiedkov do akciového indexu S&P 500
    else % Ak ide o AFS-TFS GLIDeS 
         w_SAP(Mesiac_sporenia) = 1 - (1 / (1 + exp(-b * (AFS(Mesiac_sporenia) - TFS(Mesiac_sporenia))))); % Alokácia sporiteľových prostiedkov do akciového indexu S&P 500
    end
    
    w_SeLFIES(Mesiac_sporenia) = 1 - w_SAP(Mesiac_sporenia); % Alokácia sporiteľových prostiedkov do nákupu dôchodkových dlhopisov SeLFIES
end

Finalny_nahradovy_pomer = AFS(end); % Výsledný náhradový pomer sporiteľa

end % Koniec funckie