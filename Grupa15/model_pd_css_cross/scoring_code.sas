SCORECARD_POINTS = 0;

/* 1. ACT12_N_GOOD_DAYS */
select;
    when ( missing(ACT12_N_GOOD_DAYS) ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 54);
    when ( not missing(ACT12_N_GOOD_DAYS) and ACT12_N_GOOD_DAYS <= 2 ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 45);
    when ( 2 < ACT12_N_GOOD_DAYS <= 3 ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 37);
    when ( 8 < ACT12_N_GOOD_DAYS ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 34);
    when ( 3 < ACT12_N_GOOD_DAYS <= 4 ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 34);
    when ( 4 < ACT12_N_GOOD_DAYS <= 8 ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 29);
    otherwise 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 29);
end;

/* 2. ACT_CCSS_MAXDUE */
select;
    when ( missing(ACT_CCSS_MAXDUE) ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 71);
    when ( not missing(ACT_CCSS_MAXDUE) and ACT_CCSS_MAXDUE <= 0 ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 59);
    when ( 0 < ACT_CCSS_MAXDUE <= 1 ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 45);
    when ( 4 < ACT_CCSS_MAXDUE ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 37);
    when ( 1 < ACT_CCSS_MAXDUE <= 4 ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 29);
    otherwise 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 29);
end;

/* 3. ACT_CCSS_N_STATC */
select;
    when ( 26 < ACT_CCSS_N_STATC ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 125);
    when ( 15 < ACT_CCSS_N_STATC <= 26 ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 85);
    when ( missing(ACT_CCSS_N_STATC) ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 79);
    when ( 6 < ACT_CCSS_N_STATC <= 15 ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 54);
    when ( 4 < ACT_CCSS_N_STATC <= 6 ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 40);
    when ( not missing(ACT_CCSS_N_STATC) and ACT_CCSS_N_STATC <= 4 ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 29);
    otherwise 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 29);
end;

/* 4. ACT_CCSS_UTL */
select;
    when ( 0.5347222222 < ACT_CCSS_UTL ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 58);
    when ( missing(ACT_CCSS_UTL) ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 57);
    when ( 0.5208333333 < ACT_CCSS_UTL <= 0.5347222222 ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 44);
    when ( 0.4895833333 < ACT_CCSS_UTL <= 0.5208333333 ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 40);
    when ( 0.4479166667 < ACT_CCSS_UTL <= 0.4895833333 ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 36);
    when ( 0.4083333333 < ACT_CCSS_UTL <= 0.4479166667 ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 32);
    when ( not missing(ACT_CCSS_UTL) and ACT_CCSS_UTL <= 0.4083333333 ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 29);
    otherwise 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 29);
end;

/* 5. AGS3_MEAN_CMAXA_DUE */
select;
    when ( missing(AGS3_MEAN_CMAXA_DUE) ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 60);
    when ( not missing(AGS3_MEAN_CMAXA_DUE) and AGS3_MEAN_CMAXA_DUE <= 0.6666666667 ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 49);
    when ( 0.6666666667 < AGS3_MEAN_CMAXA_DUE <= 1 ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 39);
    when ( 3 < AGS3_MEAN_CMAXA_DUE ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 33);
    when ( 1 < AGS3_MEAN_CMAXA_DUE <= 3 ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 29);
    otherwise 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 29);
end;

/* 6. APP_INCOME */
select;
    when ( 1049 < APP_INCOME <= 3872 ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 77);
    when ( 573 < APP_INCOME <= 1049 ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 60);
    when ( 3872 < APP_INCOME ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 52);
    when ( 411 < APP_INCOME <= 573 ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 42);
    when ( not missing(APP_INCOME) and APP_INCOME <= 411 ) 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 29);
    otherwise 
        SCORECARD_POINTS = sum(SCORECARD_POINTS, 29);
end;

/* KALIBRACJA PD */
prob_default_css_cross = 1/(1+exp(-(-0.028954669*SCORECARD_POINTS+8.2497434934)));

/* Drop pomocnicze */
drop SCORECARD_POINTS;
