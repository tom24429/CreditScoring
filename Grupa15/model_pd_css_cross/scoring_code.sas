/* 1. PODZIAŁ DANYCH - 70:30 TRENING TEST */
data Abt_app_clean;
    set Mylib.Abt_app;
    where not missing(default_cross12, act_age, app_income, act_cc, act_loaninc, app_loan_amount, act3_n_arrears);
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

/* 2. MODEL */
proc logistic data=Abt_app_train;
    model default_cross12 (event='1') =
          act_age
          app_income
          act_cc
          act_loaninc
          app_loan_amount
          act3_n_arrears;
run;

/* 3. SCORING ZBIORU TESTOWEGO */
data test_scored;
    set Abt_app_test;

    _logit = -0.5017
             - 0.0256  * act_age
             + 0.000207 * app_income
             + 2.4350  * act_cc
             + 0.1227  * act_loaninc
             - 0.00012 * app_loan_amount
             + 0.7447  * act3_n_arrears;

    prob_default_css_cross = 1/(1+exp(-_logit));

    if prob_default_css_cross > 0.5 then pred_default = 1;
    else pred_default = 0;
run;

/* 4. WALIDACJA NA TESTOWYM */
proc freq data=test_scored;
    tables default_cross12 * pred_default / missing;
    title "Macierz pomyłek - Zbiór testowy (model rozszerzony)";
run;
proc means data=test_scored n mean;
    class default_cross12;
    var prob_default_css_cross;
    title "Średnie PD wg faktycznego defaultu (model rozszerzony)";
run;
