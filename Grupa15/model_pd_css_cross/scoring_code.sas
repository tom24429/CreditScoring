/* 1. PODZIAŁ DANYCH - TYLKO Z KOMPLETNYMI default_cross12 */
data Abt_app_clean;
    set Mylib.Abt_app;
    where not missing(default_cross12, act_age, app_income, act_cc);
run;

data Abt_app_split;
    set Abt_app_clean;
    if ranuni(12345) < 0.7 then selected = 1;
    else selected = 0;
run;

data Abt_app_train Abt_app_test;
    set Abt_app_split;
    if selected=1 then output Abt_app_train;
    else output Abt_app_test;
run;

/* 2. MODEL LOGISTYCZNY */
proc logistic data=Abt_app_train;
    model default_cross12 (event='1') = act_age app_income act_cc;
run;

/* 3. TEST NA ZBIORZE TESTOWYM */
data test_scored;
    set Abt_app_test;
    _logit = 0.7010 
           - 0.0183 * act_age 
           + 0.000065 * app_income 
           + 2.2317 * act_cc;
    
    prob_default_css_cross = 1/(1+exp(-_logit));
    if prob_default_css_cross > 0.5 then pred_default = 1;
    else pred_default = 0;
run;
proc freq data=test_scored;
    tables default_cross12 * pred_default / missing;
    title "Macierz pomyłek - Zbiór testowy";
run;
proc means data=test_scored n mean;
    class default_cross12;
    var prob_default_css_cross;
    title "Średnie PD wg faktycznego defaultu";
run;
