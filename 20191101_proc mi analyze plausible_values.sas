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

%macro repeated_reg(cohort=, PL_prefix=, nPL=, dv=, iv=, output=);

* effects on gpa using four cohorts together;
* logistic regression to get the parameter estimates--coefficients;
* the outputs given are coefficient tables and covariance matrices for significant effects;

%do i = 1%to &nPL;
title "Regression on '&cohort'";
proc reg data =Field.all_scores4 outest=outreg&i covout;
model &dv = &iv &PL_prefix.&i;
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


%repeated_reg(cohort=2014, PL_prefix=f1_im, nPL=5, dv= fall_gpa, iv=hsgpa act dummyFemale Asian Black Hispanic MultiRaces Internat dummyResident stem dummy1stChoice, output=final_output1);

proc export data = final_output1
outfile ="C:\Users\Dell\Google Drive\CLASSES\Conferences\AEA Conference 19\Presentation_Predicting_Retention\IOSlides_predicting_retention\fall_gpa2014.csv"
dbms=csv
replace;
run;


%repeated_reg(cohort=2015, PL_prefix=f1_im, nPL=5, dv= fall_gpa, iv=hsgpa act dummyFemale Asian Black Hispanic MultiRaces Internat dummyResident stem dummy1stChoice, output=final_output2);

proc export data = final_output2
outfile ="C:\Users\Dell\Google Drive\CLASSES\Conferences\AEA Conference 19\Presentation_Predicting_Retention\IOSlides_predicting_retention\fall_gpa2015.csv"
dbms=csv
replace;
run;

%repeated_reg(cohort=2016, PL_prefix=f1_im, nPL=5, dv= fall_gpa, iv=hsgpa act dummyFemale Asian Black Hispanic MultiRaces Internat dummyResident stem dummy1stChoice, output=final_output3);

proc export data = final_output3
outfile ="C:\Users\Dell\Google Drive\CLASSES\Conferences\AEA Conference 19\Presentation_Predicting_Retention\IOSlides_predicting_retention\fall_gpa2016.csv"
dbms=csv
replace;
run;

%repeated_reg(cohort=2017, PL_prefix=f1_im, nPL=5, dv= fall_gpa, iv=hsgpa act dummyFemale Asian Black Hispanic MultiRaces Internat dummyResident stem dummy1stChoice, output=final_output4);

proc export data = final_output4
outfile ="C:\Users\Dell\Google Drive\CLASSES\Conferences\AEA Conference 19\Presentation_Predicting_Retention\IOSlides_predicting_retention\fall_gpa2017.csv"
dbms=csv
replace;
run;

* checking each cohort's estimates;
* if they are stable, the code may be wrong; *They should not be constant across cohorts.;
proc sql;
create table coef5x5 as 
select 	a.Parm, a.Estimate as Estimate2014, a.probt as p2014, 
		b.Estimate as Estimate2015, b.probt as p2015,
		c.Estimate as Estimate2016, b.probt as p2016,
		d.Estimate as Estimate2017, b.probt as p2017
from  final_output1 a, final_output2 b, final_output3 c, final_output4 d
where 	a.Parm=b.Parm AND
		a.Parm=c.Parm AND
		a.Parm=d.Parm AND
		b.Parm=c.Parm AND
		b.Parm=d.Parm AND
		c.Parm=d.Parm;
quit;

proc export data = coef5x5
outfile ="C:\Users\Dell\Google Drive\CLASSES\Conferences\AEA Conference 19\Presentation_Predicting_Retention\IOSlides_predicting_retention\coef5x5.csv"
dbms=csv
replace;
run;




/*WITHOUT PLAUSIBLE VALUES*/


* cohort 2014;
%let cohort = 2014;
%let dv=fall_gpa;
%let iv=hsgpa act dummyFemale Asian Black Hispanic MultiRaces stem Internat dummyResident  dummy1stChoice;
%let siv= hsgpa /*act*/ dummyFemale /*Asian*/ Black Hispanic MultiRaces stem /*Internat dummyResident  dummy1stChoice*/;
%let outputname=a_predictors1;
title "Regression on '&cohort'";

proc reg data =Field.all_scores4 outest=outreg covout;
model &dv = &iv

/ selection=stepwise 
  slentry=0.3
  slstay=0.05 
  details
  lackfit
;

ods output  SelParmEst=coef_tbl; 
where cohort = &cohort;
by _imputation_;
run;

ods trace on;


proc reg data =Field.all_scores4 outest=outreg covout;
model &dv = &siv

/*/ selection=stepwise */
/*  slentry=0.3*/
/*  slstay=0.05 */
/*  details*/
/*  lackfit*/
;

ods output  ParameterEstimates=coef_tbl FitStatistics=fit_tbl; 

where cohort = &cohort;
by _imputation_;
run;
ods trace off;


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
outfile="C:\Users\Dell\Google Drive\CLASSES\Conferences\AEA Conference 19\Presentation_Predicting_Retention\IOSlides_predicting_retention\&output..csv"
dbms=csv
replace;
run;

proc export data=Fit_tbl
outfile="C:\Users\Dell\Google Drive\CLASSES\Conferences\AEA Conference 19\Presentation_Predicting_Retention\IOSlides_predicting_retention\mse1.csv"
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

* get MSE and r-square;
proc reg data =Field.all_scores4 outest=outreg covout;
model &dv = &siv

/*/ selection=stepwise */
/*  slentry=0.3*/
/*  slstay=0.05 */
/*  details*/
/*  lackfit*/
;

ods output  ParameterEstimates=coef_tbl FitStatistics=fit_tbl; 

where cohort = &cohort;
by _imputation_;
run;

proc export data=Fit_tbl
outfile="C:\Users\Dell\Google Drive\CLASSES\Conferences\AEA Conference 19\Presentation_Predicting_Retention\IOSlides_predicting_retention\mse2.csv"
dbms=csv
replace;
run;

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


* get MSE and r-square;
proc reg data =Field.all_scores4 outest=outreg covout;
model &dv = &siv

/*/ selection=stepwise */
/*  slentry=0.3*/
/*  slstay=0.05 */
/*  details*/
/*  lackfit*/
;

ods output  ParameterEstimates=coef_tbl FitStatistics=fit_tbl; 

where cohort = &cohort;
by _imputation_;
run;

proc export data=Fit_tbl
outfile="C:\Users\Dell\Google Drive\CLASSES\Conferences\AEA Conference 19\Presentation_Predicting_Retention\IOSlides_predicting_retention\mse3.csv"
dbms=csv
replace;
run;


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


* get MSE and r-square;
proc reg data =Field.all_scores4 outest=outreg covout;
model &dv = &siv

/*/ selection=stepwise */
/*  slentry=0.3*/
/*  slstay=0.05 */
/*  details*/
/*  lackfit*/
;

ods output  ParameterEstimates=coef_tbl FitStatistics=fit_tbl; 

where cohort = &cohort;
by _imputation_;
run;

proc export data=Fit_tbl
outfile="C:\Users\Dell\Google Drive\CLASSES\Conferences\AEA Conference 19\Presentation_Predicting_Retention\IOSlides_predicting_retention\mse4.csv"
dbms=csv
replace;
run;


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
