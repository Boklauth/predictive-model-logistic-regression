Libname Field "C:\Users\Dell\Google Drive\CLASSES\2019 Spring\Professional Field Experience 1\00Field";



proc calis data=Field.imputed_mcmc_rounded method=ML ROBUST outfit = fit16_1;/* CHANGE DATASET*/

lineqs

q14_4   =   L11 F1  + E1    ,
q14_5   =   L12 F1  + E2    ,
q14_8   =   L13 F1  + E3    ,
q14_12  =   L14 F1  + E4    ,
q14_13  =   L15 F1  + E5    ,
q18_1   =   L16 F1  + E6    ,
q18_2   =   L17 F1  + E7    ,
q18_5   =   L16 F1  + E8    ;

VARIANCE
E1-E6 = VAR1-VAR6,
f1 1.;
/*cov */
/*f1-f2=ph12;*/
var q14_4   q14_5   q14_8   q14_12  q14_13  q18_1 q18_2 q18_5;
where year = 2016 AND _imputation_ = 1;
run;

*q14_4 q14_5 q14_8 q14_12 q14_13 q14 q18_5=>RMSEA=0.598;
proc calis data=Field.imputed_mcmc_rounded method=ML ROBUST outfit = fit16_2;/* CHANGE DATASET*/

lineqs

q14_4   =   L11 F1  + E1    ,
q14_5   =   L12 F1  + E2    ,
q14_8   =   L13 F1  + E3    ,
q14_12  =   L14 F1  + E4    ,
q14_13  =   L15 F1  + E5    ,
/*q18_1 =   L16 F1  + E6    ;*/
/*q18_2 =   L17 F1  + E5    ,*/
q18_5   =   L16 F1  + E6    ;

VARIANCE
E1-E6 = VAR1-VAR6,
f1 1.;
/*cov */
/*f1-f2=ph12;*/
var q14_4   q14_5   q14_8   q14_12  q14_13      /*q18_1 q18_2*/ q18_5;
where year = 2016 AND _imputation_ = 1;
run;

*q14_4 q14_5 q14_8 q14_12 q14_13 q14 q18_1=>RMSEA=0.682;
proc calis data=Field.imputed_mcmc_rounded method=ML ROBUST outfit = fit16_3;/* CHANGE DATASET*/

lineqs

q14_4   =   L11 F1  + E1    ,
q14_5   =   L12 F1  + E2    ,
q14_8   =   L13 F1  + E3    ,
q14_12  =   L14 F1  + E4    ,
q14_13  =   L15 F1  + E5    ,
q18_1   =   L16 F1  + E6    ;
/*q18_2 =   L17 F1  + E6    ,*/
/*q18_5 =   L16 F1  + E6    ;*/

VARIANCE
E1-E6 = VAR1-VAR6,
f1 1.;
/*cov */
/*f1-f2=ph12;*/
var q14_4   q14_5   q14_8   q14_12  q14_13      q18_1 /*q18_2   q18_5*/;
where year = 2016 AND _imputation_ = 1;
run;

*q14_4 q14_5 q14_8 q14_12 q14_13 q14 q18_1=>RMSEA=0.635;
proc calis data=Field.imputed_mcmc_rounded method=ML ROBUST outfit = fit16_4;/* CHANGE DATASET*/

lineqs

q14_4   =   L11 F1  + E1    ,
q14_5   =   L12 F1  + E2    ,
q14_8   =   L13 F1  + E3    ,
q14_12  =   L14 F1  + E4    ,
q14_13  =   L15 F1  + E5    ,
/*q18_1 =   L16 F1  + E6    ;*/
q18_2   =   L17 F1  + E6    ;
/*q18_5 =   L16 F1  + E6    ;*/

VARIANCE
E1-E6 = VAR1-VAR6,
f1 1.;
/*cov */
/*f1-f2=ph12;*/
var q14_4   q14_5   q14_8   q14_12  q14_13  q18_2   /*q18_1     q18_5*/;
where year = 2016 AND _imputation_ = 1;
run;

*q14_4 q14_5 q14_8 q14_12 q14_13 q14=> RMSEA =.0714;
proc calis data=Field.imputed_mcmc_rounded method=ML ROBUST outfit = fit16_5 outstat=ostat;/* CHANGE DATASET*/

lineqs

q14_4   =   L11 F1  + E1    ,
q14_5   =   L12 F1  + E2    ,
q14_8   =   L13 F1  + E3    ,
q14_12  =   L14 F1  + E4    ,
q14_13  =   L15 F1  + E5    ;
/*q18_1 =   L16 F1  + E6    ;*/
/*q18_2 =   L17 F1  + E5    ,*/
/*q18_5 =   L16 F1  + E6    ;*/

VARIANCE
E1-E5 = VAR1-VAR5,
f1 1.;
/*cov */
/*f1-f2=ph12;*/
var q14_4   q14_5   q14_8   q14_12  q14_13      /*q18_1 q18_2* q18_5*/  ;

where year = 2016 AND _imputation_ = 1;
run;
/*
TWO FACTORS
RMSEA--> 0.0763
*/
proc calis data=Field.imputed_mcmc_rounded method=ML ROBUST outfit = fit16_6;/* CHANGE DATASET*/
lineqs

q14_4   =   L11 F1  + /*L21 F2*/  E1    ,
q14_5   =   L12 F1  + /*L22 F2*/  E2    ,
q14_8   =   L13 F1  + /*L23 F2*/  E3    ,
q14_12  =   L14 F1  + /*L24 F2*/  E4    ,
q14_13  =   L15 F1  + /*L25 F2*/  E5    ,
q18_1   =   /*L16 F1    +*/ L26 F2 +E6  ,
q18_2   =   /*L17 F1    +*/ L27 F2 +E7  ,
q18_5   =   /*L18 F1 +*/ L28 F2 +E8 ;
VARIANCE
E1-E8 = VAR1-VAR8,
f1 1. f2 1.;
cov
f1-f2=ph12;
var q14_4   q14_5   q14_8   q14_12  q14_13  q18_1   q18_2   q18_5;
where year = 2016 AND _imputation_ = 1;
run;

proc sql;
create table fit16 as select t1.IndexCode, t1.FitIndex as FitIndex1, t1.FitValue as FitValue1,
                            t2.FitValue as FitValue2,
                            t3.FitValue as FitValue3,
                            t4.FitValue as FitValue4,
                            t5.FitValue as FitValue5,
                            t6.FitValue as FitValue6
    from fit16_1 t1,fit16_2 t2,fit16_3 t3, fit16_4 t4, fit16_5 t5, fit16_6 t6
    where t1.IndexCode = t2.IndexCode AND
            t1.IndexCode=t3.IndexCode AND
            t1.IndexCode=t4.IndexCode AND
            t1.IndexCode=t5.IndexCode AND
            t1.IndexCode=t6.IndexCode AND
            t2.IndexCode=t3.IndexCode AND
            t2.IndexCode=t4.IndexCode AND
            t2.IndexCode=t5.IndexCode AND
            t2.IndexCode=t6.IndexCode AND
            t3.IndexCode=t4.IndexCode AND
            t3.IndexCode=t5.IndexCode AND
            t3.IndexCode=t6.IndexCode AND
            t4.IndexCode=t5.IndexCode AND
            t4.IndexCode=t6.IndexCode AND
            t5.IndexCode=t6.IndexCode
        ;
proc print data=fit16;
run;
Libname Field "C:\Users\Dell\Google Drive\CLASSES\2019 Spring\Professional Field Experience 1\00Field";


* finding relationship between HSGPA, ACT and fall_gpa and spring gpa;
* Pearson Correlation ;

proc corr data = Field.all_scores4 out=corr14;
var hsgpa act fall_gpa spring_gpa f1_im1;
ods output PearsonCorr=cor_table14;
where _imputation_=1 and year=2014;
run;

proc corr data = Field.all_scores4 out=corr14;
var hsgpa act fall_gpa spring_gpa f1_im1;
ods output PearsonCorr=cor_table15;
where _imputation_=1 and year=2015;
run;

proc corr data = Field.all_scores4 out=corr14;
var hsgpa act fall_gpa spring_gpa f1_im1;
ods output PearsonCorr=cor_table16;
where _imputation_=1 and year=2016;
run;

proc corr data = Field.all_scores4 out=corr14;
var hsgpa act fall_gpa spring_gpa f1_im1;
ods output PearsonCorr=cor_table17;
where _imputation_=1 and year=2017;
run;
proc corr data = Field.all_scores4 out=corr14;
var hsgpa act fall_gpa spring_gpa f1_im1;
ods output PearsonCorr=cor_table_all;
where _imputation_=1;
run;

data cor1;
set cor_table14;
cohort = 2014;
run;
data cor2;
set cor_table15;
cohort = 2015;
run;
data cor3;
set cor_table16;
cohort = 2016;
run;
data cor4;
set cor_table17;
cohort = 2017;
run;
data cor5;
set cor_table_all;
cohort = sum(2014, 2015, 2016, 2017);
run;

data field.corr_tble;
set cor1 cor2 cor3 cor4 cor5;
run;

proc export data =field.corr_tble
outfile="C:\Users\Dell\Google Drive\CLASSES\Conferences\AEA Conference 19\Presentation_Predicting_Retention\IOSlides_predicting_retention\corr_table.csv"
dbms=csv
replace;
run;























* effects on gpa using four cohorts together;
ods trace on;
proc reg data =Field.all_scores4 outest=outreg covout;
model fall_gpa = hsgpa act dummyFemale  
Asian Black Hispanic MultiRaces dummyResident stem dummy1stChoice F1_im1 
/ selection=stepwise 
  slentry=0.3
  slstay=0.05 
  details
  lackfit;
  ods output  SelParmEst=coef;
/*where cohort = 2014 or cohort = 2015;*/
by _imputation_;
run;
ods trace off;


proc mianalyze data=outreg /*edf=331*/;
modeleffects Intercept hsgpa dummyFemale Asian Black Hispanic Multiraces dummyResident stem;
ods output ParameterEstimates=out_analyze; /*Varianceinfo=out_var*//*GET OUTPUTS*/
run;

proc export data = out_analyze 
outfile = "C:\Users\Dell\Google Drive\CLASSES\Conferences\AEA Conference 19\Presentation_Predicting_Retention\IOSlides_predicting_retention\fall_gpa.csv"
dbms=csv
replace;
run;

********************************;

* by year 2014;
data scores4_2014;
set Field.all_scores4;
if cohort=2014;
run;


/*proc reg data =scores4_2014 outest=outreg_full covout;*/
ods trace on;
proc reg data =field.all_scores4 outest=outreg_full covout;
model fall_gpa = hsgpa act dummyFemale Asian Black Hispanic MultiRaces dummyResident stem dummy1stChoice F1_im1 
/*/ selection=stepwise */
/*  slentry=0.3*/
/*  slstay=0.05 */
/*  details*/
/*  lackfit*/
;
ods output   ParameterEstimates=coef14;
where cohort = 2014;
by _imputation_;
run;
ods trace off;

proc mianalyze data=outreg_full /*edf=331*/;
/*modeleffects Intercept hsgpa dummyFemale Black Hispanic Multiraces stem;*/
modeleffects Intercept hsgpa act dummyFemale Asian Black Hispanic MultiRaces dummyResident stem dummy1stChoice F1_im1 ;
ods output ParameterEstimates=out_analyze14; /*Varianceinfo=out_var*//*GET OUTPUTS*/
run;

proc export data = coef 
outfile ="C:\Users\Dell\Google Drive\CLASSES\Conferences\AEA Conference 19\Presentation_Predicting_Retention\IOSlides_predicting_retention\coef14.csv"
dbms=csv
replace;
run;

proc export data = out_analyze14 
outfile ="C:\Users\Dell\Google Drive\CLASSES\Conferences\AEA Conference 19\Presentation_Predicting_Retention\IOSlides_predicting_retention\out_analyze14.csv"
dbms=csv
replace;
run;


proc reg data =field.all_scores4 outest=outreg_full covout;
model fall_gpa = hsgpa act dummyFemale  
Asian Black Hispanic MultiRaces dummyResident stem dummy1stChoice F1_im1 
/ selection=stepwise 
  slentry=0.3
  slstay=0.05 
  details
  lackfit;
where cohort = 2015;
by _imputation_;
run;
proc mianalyze data=outreg_full /*edf=331*/;
modeleffects Intercept hsgpa dummyFemale Black Hispanic Multiraces stem;
ods output ParameterEstimates=out_analyze15; /*Varianceinfo=out_var*//*GET OUTPUTS*/
run;

proc reg data =field.all_scores4 outest=outreg_full covout;
model fall_gpa = hsgpa act dummyFemale  
Asian Black Hispanic MultiRaces dummyResident stem dummy1stChoice F1_im1 
/ selection=stepwise 
  slentry=0.3
  slstay=0.05 
  details
  lackfit;
where cohort = 2016;
by _imputation_;
run;
proc mianalyze data=outreg_full /*edf=331*/;
modeleffects Intercept hsgpa Black Multiraces stem;
ods output ParameterEstimates=out_analyze16; /*Varianceinfo=out_var*//*GET OUTPUTS*/
run;

proc reg data =field.all_scores4 outest=outreg_full covout;
model fall_gpa = hsgpa act dummyFemale  
Asian Black Hispanic MultiRaces dummyResident stem dummy1stChoice F1_im1 
/ selection=stepwise 
  slentry=0.3
  slstay=0.05 
  details
  lackfit;
where cohort = 2017;
by _imputation_;
run;
proc mianalyze data=outreg_full /*edf=331*/;
modeleffects Intercept hsgpa dummyFemale Black Multiraces stem;
ods output ParameterEstimates=out_analyze17; /*Varianceinfo=out_var*//*GET OUTPUTS*/
run;

data r14;
set out_analyze14;
cohort=2014;
run;
data r15;
set out_analyze15;
cohort=2015;
run;
data r16;
set out_analyze16;
cohort=2016;
run;
data r17;
set out_analyze17;
cohort=2017;
run;

data out_analyze;
set r14 r15 r16 r17;
run;

proc export data = out_analyze 
outfile = "C:\Users\Dell\Google Drive\CLASSES\Conferences\AEA Conference 19\Presentation_Predicting_Retention\IOSlides_predicting_retention\effect_on_fgpa_by_year.csv"
dbms=csv
replace;
run;




*************************;


* spring gpa and hsgpa and act;
proc reg data =Field.all_scores4 outest=outreg covout;
model spring_gpa = hsgpa act dummyFemale  
Asian Black Hispanic MultiRaces dummyResident stem dummy1stChoice F1_im1 
/ selection=stepwise 
  slentry=0.3
  slstay=0.05 
  details
  lackfit;
/*where cohort = 2014 or cohort = 2015;*/
by _imputation_;
run;

/*ods trace off;*/
/*   proc print data=outreg(obs=8);*/
/*      var _Imputation_ _Type_ _Name_*/
/*         Intercept RunTime RunPulse;*/
/*      title 'REG Model Coefficients and Covariance Matrices'*/
/*            ' (First Two Imputations)';*/
/*   run;*/


proc mianalyze data=outreg /*edf=331*/;
modeleffects Intercept hsgpa act;
ods output ParameterEstimates=out_analyze; /*Varianceinfo=out_var*//*GET OUTPUTS*/
run;






* spring gpa and hsgpa and act;
proc reg data =Field.all_scores4 outest=outreg2 covout;
model spring_gpa = hsgpa act dummyFemale;
where year =2014;
by _imputation_;
run;

proc mianalyze data=outreg2 /*edf=331*/;
modeleffects Intercept hsgpa act dummyFemale;
ods output ParameterEstimates=out_analyze; /*Varianceinfo=out_var*//*GET OUTPUTS*/
run;

proc means data = Field.all_scores4 mean std min max;
class _imputation_;
var fall_gpa spring_gpa hsgpa act;
run;
proc export data=out_analyze 
outfile ="C:\Users\Dell\Google Drive\CLASSES\Conferences\AEA Conference 19\Presentation_Predicting_Retention\IOSlides_predicting_retention\gpa_reg.csv"
dbms=csv
replace;
run;




* NEED TO CREATE MORE DESCRIPTIVES;
ods trace off;
proc means data = Field.all_scores4 ;
var S2Returned	Y2Returned	AIndian	Asian	Black	Hispanic	Internat	Hawaiian	MultiRaces	Unknownrace	
dummyfemale	dummyResident	dummy1stChoice;
where _imputation_=1 and year=2014;
run;

ods trace on;
proc freq data = field.all_scores4;
tables item1-item6/all;
ods output OneWayFreqs = f;
where _IMPUTATION_=1 and year =2014;
run;

* export to r;
proc export data = f
outfile ="C:\Users\Dell\Google Drive\CLASSES\Conferences\AEA Conference 19\Presentation_Predicting_Retention\IOSlides_predicting_retention\items_f.csv"
dbms=csv
replace;
run;







* looking at the relationship with overal dataset to answer research questions;


* F1 is significant with spring gpa;
proc reg data = Field.all_scores4;
model spring_gpa=F1;
where _imputation_=1;
run;

/*F1 is significant with spring gpa after controlling for fall_gpa*/
proc reg data = Field.all_scores4;
model spring_gpa=fall_gpa F1;
where _imputation_=1 AND cohort = 2014 or cohort =2015;
run;

proc corr data = Field.all_scores4;
var spring_gpa fall_gpa F1;
where _imputation_=1;
run;








/*logistic regression*/
/*
export scores4 for R
*/

proc export data = field.all_scores4 outfile="C:\Users\Dell\Google Drive\CLASSES\Conferences\AEA Conference 19\Presentation_Predicting_Retention\IOSlides_predicting_retention\all_scores4.csv"
dbms=csv
replace;
run;
/*
Using the two cohorts as the trainingg data
And using the last two years as the test data;

*/

ods graphics on;
proc logistic data=Field.all_scores4 outest=betas covout;
      model Y2Returned(event='1')=
hsgpa act F1_im1 dummy1stChoice dummyFemale  
Asian Black Hispanic MultiRaces dummyResident stem fall_gpa
                   / selection=stepwise 
                     slentry=0.3
                     slstay=0.05 
                     details
                     lackfit;
/*	roc hsgpa;*/
/*	roc F1compScore;*/
/*	roc F2compScore;*/
/*	*/
      output out=rthreef2014 p=phat lower=lcl upper=ucl
      predprob=(individual crossvalidate);
	  where _imputation_=1 AND (cohort=2014 Or cohort = 2015);
   run;
ods graphics off;

/*
using year 2014 as traing data set
*/

proc logistic data=Field.all_scores4 outest=betas covout;
      model Y2Returned(event='1')=
hsgpa act F1_im1 dummy1stChoice dummyFemale  
Asian Black Hispanic MultiRaces dummyResident stem fall_gpa
                   / selection=stepwise 
                     slentry=0.3
                     slstay=0.05 
                     details
                     lackfit;
/*	roc hsgpa;*/
/*	roc F1compScore;*/
/*	roc F2compScore;*/
/*	*/
      output out=rthreef2014 p=phat lower=lcl upper=ucl
      predprob=(individual crossvalidate);
	  where _imputation_=1 AND cohort=2014;
   run;
