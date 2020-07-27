Libname Field "C:\Users\Dell\Google Drive\CLASSES\2019 Spring\Professional Field Experience 1\00Field";

/*
http://support.sas.com/documentation/cdl/en/statug/68162/HTML/default/viewer.htm#statug_mianalyze_examples01.htm
The following statements combine the means and standard errors from imputed data sets, 
The EDF= option requests that the adjusted degrees of freedom be used in the analysis. 
For sample means based on 31 observations, the complete-data error degrees of freedom is 30.

proc mianalyze data=outuni edf=30;
   modeleffects Oxygen RunTime RunPulse;
   stderr SOxygen SRunTime SRunPulse;
run;
*******************
*******************



*/


/*
Arguments
cohort: is the value of cohort in the dataset.
PL_prefix: is the prefix for the plausible values. They are from multiple impuatation.
nPL is: the numeric order of the plausible value. Without this number, the macro won't work. the macro depends on these values to run regression model for each plausible value.
dv: is the y/reponse/outcome variable.
iv: is the variables/predictors to be included in the regression model. This does not include the variable for the plausible value.
*/

* breaking data;
data d2014;
set Field.all_scores4;
if cohort = 2014;
run;
data d2015;
set Field.all_scores4;
if cohort = 2015;
run;
data d2016;
set Field.all_scores4;
if cohort = 2016;
run;
data d2017;
set Field.all_scores4;
if cohort = 2017;
run;

ods trace on;
proc logistic data=Field.all_scores4 outest=betas covout;
      model Y2Returned(event='1')= fall_gpa hsgpa act dummyFemale Asian Black Hispanic MultiRaces Internat dummyResident stem dummy1stChoice f1_im1
	                / selection=stepwise 
                     slentry=0.3
                     slstay=0.05 
                     details
                     lackfit;
 output out=rthreef2014 p=phat lower=lcl upper=ucl
      predprob=(individual crossvalidate);
ods output  ParameterEstimates=est;

	  where _imputation_=1 AND cohort=2014;
   run;
   ods trace off;

%macro repeated_reg_log(cohort=, PL_prefix=, nPL=, dv=, iv=, output=);

* effects on gpa using four cohorts together;
* logistic regression to get the parameter estimates--coefficients;
* the outputs given are coefficient tables and covariance matrices for significant effects;

%do i = 1%to &nPL;
title "Logistic Reg: Retention on '&cohort'";
proc logistic data =Field.all_scores4 outest=outreg&i covout;
model &dv (event='1')= &iv &PL_prefix.&i; /*don't forget ";"*/
   
ods output ParameterEstimates=coef_tbl&i;
 *ods output  SelParmEst=coef_tbl&i ; /* is ParameterEstimates if stepwise is not used */
where cohort = &cohort;
by _imputation_;
run;

proc mianalyze parms=coef_tbl&i /*edf=331*/;
modeleffects Intercept &iv &PL_prefix.&i;
ods output ParameterEstimates=rolledup_coef_tbl&cohort.&PL_prefix.&i; /*Varianceinfo=out_var*//*GET OUTPUTS*/
run;

%end;


* prepare data step for rolling up plausible value;
%do j = 1 %to 5; 
data rolledup_coef_tbl&cohort.&PL_prefix.&j;
set rolledup_coef_tbl&cohort.&PL_prefix.&j; 
_Imputation_=&j; 
run;
%end;

data x;
set Rolledup_coef_tbl&cohort.&PL_prefix.1 
	Rolledup_coef_tbl&cohort.&PL_prefix.2 
	Rolledup_coef_tbl&cohort.&PL_prefix.3 
	Rolledup_coef_tbl&cohort.&PL_prefix.4
	Rolledup_coef_tbl&cohort.&PL_prefix.5;
run;

data xx;
set x;
rename Parm=Variable;
if Parm="f1_im1" then Parm="F1"; 
if Parm="f1_im2" then Parm="F1"; 
if Parm="f1_im3" then Parm="F1"; 
if Parm="f1_im4" then Parm="F1"; 
if Parm="f1_im5" then Parm="F1"; 
Model="Model1";
Dependent="fall_gpa";  /*CHANGE DEPENDENT VARIABL HERE*/
DF=1;
drop NImpute LCLMean	UCLMean Min Max Theta0;
run;

* roll up all plausible value;
title "Final rolledup regression parameter estimates with five plausible values and five imputed data sets";
proc mianalyze parms=xx /*edf=331*/;
modeleffects Intercept &iv F1;
ods output ParameterEstimates=&output; /*Varianceinfo=out_var*//*GET OUTPUTS*/
run;


;
%mend;



%repeated_reg_log(cohort=2014, PL_prefix=f1_im, nPL=5, dv= Y2Returned, iv=fall_gpa hsgpa act dummyFemale Asian Black Hispanic MultiRaces Internat dummyResident stem dummy1stChoice, output=ret_output14);

proc export data = ret_output14
outfile ="C:\Users\Dell\Google Drive\CLASSES\Conferences\AEA Conference 19\Presentation_Predicting_Retention\IOSlides_predicting_retention\ret_all_vars14.csv"
dbms=csv
replace;
run;







/*WITHOUT PLAUSIBLE VALUES*/


* cohort 2014;
%let cohort = 2014;
%let dv=Y2Returned;
%let iv=fall_gpa hsgpa act dummyFemale Asian Black Hispanic MultiRaces stem Internat dummyResident  dummy1stChoice;
%let siv= fall_gpa /*hsgpa*/act /* dummyFemale /*Asian Black Hispanic MultiRaces*/ stem /*Internat dummyResident  dummy1stChoice*/;
%let outputname=ret14;
title "Regression on '&cohort'";

proc logistic data =Field.all_scores4 outest=outreg covout;
model &dv(event='1') = &iv

/ selection=stepwise 
  slentry=0.3
  slstay=0.05 
  details
  lackfit
;

ods output  ParameterEstimates=est;
where cohort = &cohort;
by _imputation_;
run;


* use this one because it includes all three variables in the model for all impuatation.;
ods trace on;
proc logistic data =Field.all_scores4 outest=outreg covout;
model &dv(event='1') = fall_gpa act stem /lackfit rsquare

/*/ selection=stepwise */
/*  slentry=0.3*/
/*  slstay=0.05 */
/*  details*/
/*  lackfit*/
;

ods output  ParameterEstimates=est FitStatistics=fit_log;
where cohort = &cohort;
by _imputation_;
run;
ods trace off;

proc export data=fit_log
outfile="C:\Users\Dell\Google Drive\CLASSES\Conferences\AEA Conference 19\Presentation_Predicting_Retention\IOSlides_predicting_retention\fit_log.csv"
dbms=csv
replace;
run;

proc mianalyze 
/*data=outreg*/
parms=est 
/*edf=331*/;
/*where Step=5;*/
modeleffects Intercept &siv;
ods output ParameterEstimates=&outputname; /*Varianceinfo=out_var*//*GET OUTPUTS*/
run;



/* below shows the same results*/

/*proc mianalyze */
/*data=outreg*/
/*/*parms=coef_tbl */*/
/*/*edf=331*/;*/
/*modeleffects Intercept &siv;*/
/*ods output ParameterEstimates=&output; /*Varianceinfo=out_var*//*GET OUTPUTS*/*/
/*run;*/
;
proc export data=&outputname
outfile="C:\Users\Dell\Google Drive\CLASSES\Conferences\AEA Conference 19\Presentation_Predicting_Retention\IOSlides_predicting_retention\&outputname..csv"
dbms=csv
replace;
run;


* cohort 2015;
%let cohort = 2015;
%let dv=fall_gpa;
%let iv=hsgpa act dummyFemale Asian Black Hispanic MultiRaces stem Internat dummyResident  dummy1stChoice;
%let siv= hsgpa /*act*/ dummyFemale /*Asian*/ Black Hispanic MultiRaces stem /*Internat dummyResident  dummy1stChoice*/;
%let outputname=a_predictors2;
title "Regression on '&cohort'";

proc reg data =Field.all_scores4 outest=outreg covout;
model &dv = &iv

/ selection=stepwise 
  slentry=0.3
  slstay=0.05 
  details
  lackfit
;

ods output  SelParmEst=coef_tbl ; 
where cohort = &cohort;
by _imputation_;
run;

proc mianalyze 
/*output=outreg*/
parms=coef_tbl 
/*edf=331*/;
modeleffects Intercept &siv;
ods output ParameterEstimates=&outputname; /*Varianceinfo=out_var*//*GET OUTPUTS*/
run;

/* below shows the same results*/

/*proc mianalyze */
/*data=outreg*/
/*/*parms=coef_tbl */*/
/*/*edf=331*/;*/
/*modeleffects Intercept &siv;*/
/*ods output ParameterEstimates=&output; /*Varianceinfo=out_var*//*GET OUTPUTS*/*/
/*run;*/
;
proc export data=&outputname
outfile="C:\Users\Dell\Google Drive\CLASSES\Conferences\AEA Conference 19\Presentation_Predicting_Retention\IOSlides_predicting_retention\&outputname..csv"
dbms=csv
replace;
run;


* cohort 2016;
%let cohort = 2016;
%let dv=fall_gpa;
%let iv=hsgpa act dummyFemale Asian Black Hispanic MultiRaces stem Internat dummyResident  dummy1stChoice;
%let siv= hsgpa /*act dummyFemale Asian*/ Black /*Hispanic*/ MultiRaces stem /*Internat dummyResident  dummy1stChoice*/;
%let outputname=a_predictors3;
title "Regression on '&cohort'";

proc reg data =Field.all_scores4 outest=outreg covout;
model &dv = &iv

/ selection=stepwise 
  slentry=0.3
  slstay=0.05 
  details
  lackfit
;

ods output  SelParmEst=coef_tbl ; 
where cohort = &cohort;
by _imputation_;
run;

proc mianalyze 
/*output=outreg*/
parms=coef_tbl 
/*edf=331*/;
modeleffects Intercept &siv;
ods output ParameterEstimates=&outputname; /*Varianceinfo=out_var*//*GET OUTPUTS*/
run;

/* below shows the same results*/

/*proc mianalyze */
/*data=outreg*/
/*/*parms=coef_tbl */*/
/*/*edf=331*/;*/
/*modeleffects Intercept &siv;*/
/*ods output ParameterEstimates=&output; /*Varianceinfo=out_var*//*GET OUTPUTS*/*/
/*run;*/
;
proc export data=&outputname
outfile="C:\Users\Dell\Google Drive\CLASSES\Conferences\AEA Conference 19\Presentation_Predicting_Retention\IOSlides_predicting_retention\&outputname..csv"
dbms=csv
replace;
run;



* cohort 2017;
%let cohort = 2017;
%let dv=fall_gpa;
%let iv=hsgpa act dummyFemale Asian Black Hispanic MultiRaces stem Internat dummyResident  dummy1stChoice;
%let siv= hsgpa /*act*/ dummyFemale Asian Black /*Hispanic*/ MultiRaces stem /*Internat dummyResident  dummy1stChoice*/;
%let outputname=a_predictors4;
title "Regression on '&cohort'";

proc reg data =Field.all_scores4 outest=outreg covout;
model &dv = &iv

/ selection=stepwise 
  slentry=0.3
  slstay=0.05 
  details
  lackfit
;

ods output  SelParmEst=coef_tbl ; 
where cohort = &cohort;
by _imputation_;
run;

proc mianalyze 
/*output=outreg*/
parms=coef_tbl 
/*edf=331*/;
modeleffects Intercept &siv;
ods output ParameterEstimates=&outputname; /*Varianceinfo=out_var*//*GET OUTPUTS*/
run;

/* below shows the same results*/

/*proc mianalyze */
/*data=outreg*/
/*/*parms=coef_tbl */*/
/*/*edf=331*/;*/
/*modeleffects Intercept &siv;*/
/*ods output ParameterEstimates=&output; /*Varianceinfo=out_var*//*GET OUTPUTS*/*/
/*run;*/
;
proc export data=&outputname
outfile="C:\Users\Dell\Google Drive\CLASSES\Conferences\AEA Conference 19\Presentation_Predicting_Retention\IOSlides_predicting_retention\&outputname..csv"
dbms=csv
replace;
run;
