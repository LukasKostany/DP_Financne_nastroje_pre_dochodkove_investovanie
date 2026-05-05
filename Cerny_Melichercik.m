function [Finalny_nahradovy_pomer, AFS, w_SAP, mu, Sigma] = Cerny_Melichercik(Doba_sporenia_mesiace, Realne_logaritmicke_mesacne_vynosy_SAP_500, Realne_logaritmicke_mesacne_vynosy_dlhopis, Realne_hodnoty_SeLFIES, Cieleny_realny_dochodkovy_prijem, Prispevky) % Funkcia na simuláciu dôchodkového sporenia pomocou stratégie Černý-Melicherčík
% Vykoná historickú simulácia dôchodkovej sporivej stratégie Černý-Melicherčík
% Vypočíta finálny náhradový pomer a vráti vývoj AFS a podielu investovaných prostiedkov do akciového indexu S&P 500 pre dôchodkovú investičnú stratégiu Černý-Melicherčík a vypočíta hodnoty priemerného reálneho ročného aritmetického výnosu akciového indexu S&P 500 a amerického štátneho dlhopisu s konštantnou maturitou 7 rokov a ročnej kovariančnej matice reálnych výnosov akciového indexu S&P 500 a amerického štátneho dlhopisu s konštantnou maturitou 7 rokov  

% Vstupy:
% Doba sporenia mesiace - koľko mesiacov si bude investor sporiť na dôchodok
% Reálne logaritmické mesačné výnosy S&P 500 - mesačné reálne logaritmické výnosy akciového indexu S&P 500
% Reálne logaritmické mesačné výnosy dlhopis - mesačné reálne logaritmické výnosy amerického štátneho dlhopisu s konštantnou maturitou 7 rokov
% Reálne hodnoty SeLFIES - reálne hodnoty SeLFIES s jednotlivými konverziami v každom mesiaci sporenia
% Cielený reálny dôchodkový príjem - sporiteľov cieľový reálny mesačný dôchodkový príjem
% Príspevky - koľko peňažných jednotiek prispel sporiteľ do dôchodkovej investičnej stratégie daný mesiac sporenia

% Výstupy:
% Finálny náhradový pomer - výsledný finálny náhradový pomer sporiteľa dosiahnutý dochodkovou investičnou stratégiou Černý-Melicherčík
% AFS - jednotlivé hodnoty aktuálneho stavu financovania (AFS) pre stratégiu Černý-Melicherčík
% w_SAP - jednotlivé hodnoty podielu investovaných prostiedkov do akciového indexu S&P 500 pre stratégiu Černý-Melicherčík
% mu -  priemerný reálny ročný aritmetický výnos akciového indexu S&P 500 a amerického štátneho dlhopisu s konštantnou maturitou 7 rokov 
% Sigma - ročná kovariančná matica reálnych výnosov akciového indexu S&P 500 a amerického štátneho dlhopisu s konštantnou maturitou 7 rokov  

Posun = 528 - Doba_sporenia_mesiace; % Posun hodnôt pri odlišných obdobiach dôchodkového sporenia

% Parametre dôchodkovej investičnej stratégie Černý-Melicherčík:
r = 0.02; % Bezriziková miera
gamma = 9; % Averzia dôchodkového sporiteľa voči riziku

if Posun == 0 % Ak nedochádza k posunu dát
   Priemerny_rocny_realny_aritmeticky_vynos_SAP_500 = mean(Realne_logaritmicke_mesacne_vynosy_SAP_500) * 12 + 0.5 * 12 * var(Realne_logaritmicke_mesacne_vynosy_SAP_500); % Priemerný ročný reálny aritmetický výnos akciového indexu S&P 500
   Priemerny_rocny_realny_aritmeticky_vynos_dlhopis = mean(Realne_logaritmicke_mesacne_vynosy_dlhopis) * 12 + 0.5 * 12 * var(Realne_logaritmicke_mesacne_vynosy_dlhopis); % Priemerný ročný reálny aritmetický výnos amerického štátneho dlhopisu s konštantnou maturitou 7 rokov
   mu = [Priemerny_rocny_realny_aritmeticky_vynos_SAP_500; Priemerny_rocny_realny_aritmeticky_vynos_dlhopis]; % Vektor priemerného ročného reálneho aritmetického výnosu akciového indexu S&P 500 a amerického štátneho dlhopisu s konštantnou maturitou 7 rokov
   Sigma = cov(Realne_logaritmicke_mesacne_vynosy_SAP_500, Realne_logaritmicke_mesacne_vynosy_dlhopis) * 12; % Ročná kovariančná matica reálnych výnosov akciového indexu S&P 500 a amerického štátneho dlhopisu s konštantnou maturitou 7 rokov 
else % Ak dochádza k posunu dát
     Priemerny_rocny_realny_aritmeticky_vynos_SAP_500 = mean(Realne_logaritmicke_mesacne_vynosy_SAP_500((Posun + 1):end)) * 12 + 0.5 * 12 * var(Realne_logaritmicke_mesacne_vynosy_SAP_500((Posun + 1):end)); % Priemerný ročný reálny aritmetický výnos akciového indexu S&P 500
     Priemerny_rocny_realny_aritmeticky_vynos_dlhopis = mean(Realne_logaritmicke_mesacne_vynosy_dlhopis((Posun + 1):end)) * 12 + 0.5 * 12 * var(Realne_logaritmicke_mesacne_vynosy_dlhopis((Posun + 1):end)); % Priemerný ročný reálny aritmetický výnos amerického štátneho dlhopisu s konštantnou maturitou 7 rokov
     mu = [Priemerny_rocny_realny_aritmeticky_vynos_SAP_500; Priemerny_rocny_realny_aritmeticky_vynos_dlhopis]; % Vektor priemerného ročného reálneho aritmetického výnosu akciového indexu S&P 500 a amerického štátneho dlhopisu s konštantnou maturitou 7 rokov
     Sigma = cov(Realne_logaritmicke_mesacne_vynosy_SAP_500((Posun + 1):end), Realne_logaritmicke_mesacne_vynosy_dlhopis((Posun + 1):end)) * 12; % Ročná kovariančná matica reálnych výnosov akciového indexu S&P 500 a amerického štátneho dlhopisu s konštantnou maturitou 7 rokov
end

% Parametre pre optimalizačnú úlohu:
H = gamma * Sigma; % Kvadratický člen v účelovej funkcií
f = -(mu - r); % Lineárny člen v účelovej funkcií
Aeq = [1 1]; % Ľavá strana lineárneho ohraničenia v tvare rovnosti
lb = [0; 0]; % Dolné ohraničenie premenných

% Historická simulácia:
% Inicializácia vektorov:
C_t_NPV = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora súčasnej hodnoty budúcich príspevkov na dôchodkové sporenie
alpha = zeros(1, Doba_sporenia_mesiace); % Inicializácia vektora hodnoty alpha v dôchodkovej investičnej stratégii Černý-Melicherčík
Riesenie_optimalizacnej_ulohy = zeros(2, Doba_sporenia_mesiace); % Inicializácia vektora riešení optimalizačnej úlohy v dôchodkovej investičnej stratégii Černý-Melicherčík
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
   
for Mesiac_sporenia = 2:Doba_sporenia_mesiace % Pre každý mesiac sporenia
    Hodnota_investicie_SAP_500(Mesiac_sporenia) = w_SAP(Mesiac_sporenia - 1) * Celkova_hodnota_prostriedkov(Mesiac_sporenia - 1) * exp(Realne_logaritmicke_mesacne_vynosy_SAP_500(Posun + Mesiac_sporenia - 1)); % Hodnota sporiteľových prostiedkov investovaných do akciového indexu S&P 500
    Realny_prijem_zo_SAP_500(Mesiac_sporenia) = Hodnota_investicie_SAP_500(Mesiac_sporenia) / Realne_hodnoty_SeLFIES(Posun + Mesiac_sporenia, (Doba_sporenia_mesiace + 1) - Mesiac_sporenia); % Reálny príjem dostupný z prostiedkov investovaných do akciového indexu S&P 500
    
    Hodnota_investicie_dlhopis(Mesiac_sporenia) = w_dlhopis * Celkova_hodnota_prostriedkov(Mesiac_sporenia - 1)  * exp(Realne_logaritmicke_mesacne_vynosy_dlhopis(Posun + Mesiac_sporenia - 1)); % Hodnota sporiteľových prostiedkov investovaných do amerického štátneho dlhopisu s konštantnou maturitou 7 rokov
    Realny_prijem_z_dlhopisu(Mesiac_sporenia) = Hodnota_investicie_dlhopis(Mesiac_sporenia) / Realne_hodnoty_SeLFIES(Posun + Mesiac_sporenia, (Doba_sporenia_mesiace + 1) - Mesiac_sporenia); % Reálny príjem dostupný z prostiedkov investovaných do amerického štátneho dlhopisu s konštantnou maturitou 7 rokov
    
    AFS(Mesiac_sporenia) = (Realny_prijem_z_dlhopisu(Mesiac_sporenia) + Realny_prijem_zo_SAP_500(Mesiac_sporenia)) / Cieleny_realny_dochodkovy_prijem(Mesiac_sporenia); % Aktuálny stav financovania cieľového reálneho dôchodkového príjmu
    
    Celkova_hodnota_prostriedkov(Mesiac_sporenia) = Hodnota_investicie_dlhopis(Mesiac_sporenia) + Hodnota_investicie_SAP_500(Mesiac_sporenia) + Prispevky(Mesiac_sporenia); % Celková hodnota sporiteľových prostriedkov
        
    U_t = Celkova_hodnota_prostriedkov(Mesiac_sporenia); % Celková nasporená suma v dôchodkovom sporení
    C_t_NPV(Mesiac_sporenia) = sum(Prispevky(Mesiac_sporenia) .* exp((-r / 12) .* (1:(Doba_sporenia_mesiace - Mesiac_sporenia)))); % Súčasná hodnota budúcich príspevkov na dôchodkové sporenie
    alpha(Mesiac_sporenia) = U_t / (U_t + C_t_NPV(Mesiac_sporenia)); % Hodnota alpha v dôchodkovej investičnej stratégii Černý-Melicherčík
    beq = alpha(Mesiac_sporenia); % Pravá strana lineárneho ohraničenia v tvare rovnosti
    Riesenie_optimalizacnej_ulohy(:, Mesiac_sporenia) = quadprog(H, f, [], [], Aeq, beq, lb, []); % Riešenie optimalizačnej úlohy v dôchodkovej investičnej stratégii Černý-Melicherčík
        
    w_SAP(Mesiac_sporenia) = Riesenie_optimalizacnej_ulohy(1, Mesiac_sporenia) / alpha(Mesiac_sporenia); % Alokácia sporiteľových prostiedkov do akciového indexu S&P 500
    w_dlhopis = 1 - w_SAP(Mesiac_sporenia); % Alokácia sporiteľových prostiedkov do amerického štátneho dlhopisu s konštantnou maturitou 7 rokov
end

Finalny_nahradovy_pomer = AFS(end); % Výsledný náhradový pomer sporiteľa

end % Koniec funkcie