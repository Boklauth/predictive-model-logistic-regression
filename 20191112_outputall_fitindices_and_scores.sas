* Making all fit indices for each cohort and by imputation. 



/*
Ref: https://support.sas.com/documentation/cdl/en/statug/63033/HTML/default/viewer.htm#statug_calis_sect030.htm

The following five estimation methods are available in PROC CALIS:

unweighted least squares (ULS)

generalized least squares (GLS)

normal-theory maximum likelihood (ML)

weighted least squares (WLS, ADF)

diagonally weighted least squares (DWLS)

------------
http://support.sas.com/documentation/cdl/en/statug/67523/HTML/default/viewer.htm#statug_calis_syntax13.htm#statug.calis.calisrobust
ROBUST <=name>
ROB <=name>
invokes the robust estimation method that downweights the outliers in estimation. You can use the ROBUST option only in conjunction with the ML method (METHOD= ML). More accurately, the robust estimation is done by using the iteratively reweighted least squares (IRLS) method under the normal distribution assumption. The model fit of robust estimation is evaluated with the ML discrepancy function.

You must provide raw data input for the robust estimation method to work. With the robust method, the Huber weights are applied to the observations so that outliers are downweighted during estimation. See the section Robust Estimation for details.

You can request the three different types of robust methods by using one of the following names:
*/

;
Libname Field "C:\Users\shh6304\Google Drive\CLASSES\2019 Spring\Professional Field Experience 1\00Field";


%macro multi_fit_indices(cohort=, imputation_num=,outputfitname=,);


proc calis data=Field.imputed_mcmc_rounded method=ML ROBUST outfit = fit14_1;/* CHANGE DATASET*/

lineqs

q14_4	=	L11 F1	+ E1	,
q14_5	=	L12 F1	+ E2	,
q14_8	=	L13 F1	+ E3	,
q14_12	=	L14 F1	+ E4	,
q14_13	=	L15 F1	+ E5	,
q18_1	=	L16 F1	+ E6	,
q18_2	=	L17 F1	+ E7	,
q18_5	=	L16 F1	+ E8	;

VARIANCE
E1-E6 = VAR1-VAR6,
f1 1.;
/*cov */
/*f1-f2=ph12;*/
var q14_4	q14_5	q14_8	q14_12	q14_13	q18_1 q18_2	q18_5;
where year = &cohort AND _imputation_ = &imputation_num;
ods output LINEQSEffects=eff&cohort.&imputation_num.x1 LINEQSEffectsStd=st_eff&cohort.&imputation_num.x1;
run;

*q14_4 q14_5 q14_8 q14_12 q14_13 q14 q18_5=>RMSEA=0.598;
proc calis data=Field.imputed_mcmc_rounded method=ML ROBUST outfit = fit14_2;/* CHANGE DATASET*/

lineqs

q14_4	=	L11 F1	+ E1	,
q14_5	=	L12 F1	+ E2	,
q14_8	=	L13 F1	+ E3	,
q14_12	=	L14 F1	+ E4	,
q14_13	=	L15 F1	+ E5	,
/*q18_1	=	L16 F1	+ E6	;*/
/*q18_2	=	L17 F1	+ E5	,*/
q18_5	=	L16 F1	+ E6	;

VARIANCE
E1-E6 = VAR1-VAR6,
f1 1.;
/*cov */
/*f1-f2=ph12;*/
var q14_4	q14_5	q14_8	q14_12	q14_13		/*q18_1 q18_2*/	q18_5;
where year = &cohort AND _imputation_ = &imputation_num;
ods output LINEQSEffects=eff&cohort.&imputation_num.x2 LINEQSEffectsStd=st_eff&cohort.&imputation_num.x2;
run;

*q14_4 q14_5 q14_8 q14_12 q14_13 q14 q18_1=>RMSEA=0.682;
proc calis data=Field.imputed_mcmc_rounded method=ML ROBUST outfit = fit14_3;/* CHANGE DATASET*/

lineqs

q14_4	=	L11 F1	+ E1	,
q14_5	=	L12 F1	+ E2	,
q14_8	=	L13 F1	+ E3	,
q14_12	=	L14 F1	+ E4	,
q14_13	=	L15 F1	+ E5	,
q18_1	=	L16 F1	+ E6	;
/*q18_2	=	L17 F1	+ E6	,*/
/*q18_5	=	L16 F1	+ E6	;*/

VARIANCE
E1-E6 = VAR1-VAR6,
f1 1.;
/*cov */
/*f1-f2=ph12;*/
var q14_4	q14_5	q14_8	q14_12	q14_13		q18_1 /*q18_2	q18_5*/;
where year = &cohort AND _imputation_ = &imputation_num;
ods output LINEQSEffects=eff&cohort.&imputation_num.x3 LINEQSEffectsStd=st_eff&cohort.&imputation_num.x3;
run;

*q14_4 q14_5 q14_8 q14_12 q14_13 q14 q18_1=>RMSEA=0.635;
proc calis data=Field.imputed_mcmc_rounded method=ML ROBUST outfit = fit14_4;/* CHANGE DATASET*/

lineqs

q14_4	=	L11 F1	+ E1	,
q14_5	=	L12 F1	+ E2	,
q14_8	=	L13 F1	+ E3	,
q14_12	=	L14 F1	+ E4	,
q14_13	=	L15 F1	+ E5	,
/*q18_1	=	L16 F1	+ E6	;*/
q18_2	=	L17 F1	+ E6	;
/*q18_5	=	L16 F1	+ E6	;*/

VARIANCE
E1-E6 = VAR1-VAR6,
f1 1.;
/*cov */
/*f1-f2=ph12;*/
var q14_4	q14_5	q14_8	q14_12	q14_13	q18_2	/*q18_1 	q18_5*/;
where year = &cohort AND _imputation_ = &imputation_num;
ods output LINEQSEffects=eff&cohort.&imputation_num.x4 LINEQSEffectsStd=st_eff&cohort.&imputation_num.x4;
run;

*q14_4 q14_5 q14_8 q14_12 q14_13 q14=> RMSEA =.0714;
proc calis data=Field.imputed_mcmc_rounded method=ML ROBUST outfit = fit14_5 outstat=ostat;/* CHANGE DATASET*/

lineqs

q14_4	=	L11 F1	+ E1	,
q14_5	=	L12 F1	+ E2	,
q14_8	=	L13 F1	+ E3	,
q14_12	=	L14 F1	+ E4	,
q14_13	=	L15 F1	+ E5	;
/*q18_1	=	L16 F1	+ E6	;*/
/*q18_2	=	L17 F1	+ E5	,*/
/*q18_5	=	L16 F1	+ E6	;*/

VARIANCE
E1-E5 = VAR1-VAR5,
f1 1.;
/*cov */
/*f1-f2=ph12;*/
var q14_4	q14_5	q14_8	q14_12	q14_13		/*q18_1 q18_2* q18_5*/	;

where year = &cohort AND _imputation_ = &imputation_num;
ods output LINEQSEffects=eff&cohort.&imputation_num.x5 LINEQSEffectsStd=st_eff&cohort.&imputation_num.x5;
run;
/*
TWO FACTORS
RMSEA--> 0.0763
*/
proc calis data=Field.imputed_mcmc_rounded method=ML ROBUST outfit = fit14_6;/* CHANGE DATASET*/
lineqs

q14_4	=	L11 F1	+ /*L21 F2*/  E1	,
q14_5	=	L12 F1	+ /*L22 F2*/  E2	,
q14_8	=	L13 F1	+ /*L23 F2*/  E3	,
q14_12	=	L14 F1	+ /*L24 F2*/  E4	,
q14_13	=	L15 F1	+ /*L25 F2*/  E5	,
q18_1	=	/*L16 F1	+*/ L26 F2 +E6	,
q18_2	=	/*L17 F1	+*/ L27 F2 +E7	,
q18_5	=	/*L18 F1 +*/ L28 F2 +E8	;
VARIANCE
E1-E8 = VAR1-VAR8,
f1 1. f2 1.;
cov 
f1-f2=ph12;
var q14_4	q14_5	q14_8	q14_12	q14_13	q18_1	q18_2	q18_5;
where year = &cohort AND _imputation_ = &imputation_num;
ods output LINEQSEffects=eff&cohort.&imputation_num.x6 LINEQSEffectsStd=st_eff&cohort.&imputation_num.x6;
run;

proc sql;
create table &outputfitname as select t1.IndexCode, t1.FitIndex as FitIndex1, t1.FitValue as FitValue1, 
							t2.FitValue as FitValue2,
							t3.FitValue as FitValue3,
							t4.FitValue as FitValue4, 
							t5.FitValue as FitValue5, 
							t6.FitValue as FitValue6 
	from fit14_1 t1,fit14_2 t2,fit14_3 t3, fit14_4 t4, fit14_5 t5, fit14_6 t6
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
data &outputfitname;
set &outputfitname;
cohort=&cohort;
_IMPUTATION_=&imputation_num;
run;


* PRINTING;
/*title2 "For Cohort &cohort and Imputation &imputation_num'";*/
/*proc print data=&outputfitname;*/
/*format FitValue1 FitValue2 FitValue3 FitValue4 FitValue5 FitValue2 10.3;*/
/*  footnote 'fitValue2 contains six items; fitValue5 contains five items';*/
/*run;*/

* add cohort adn impuation num to eff adn st_eff;
%do i = 1 %to 6;
data eff&cohort.&imputation_num.x&i;
set eff&cohort.&imputation_num.x&i;
cohort = &cohort;
_IMPUTATION_=&imputation_num;
run;

data st_eff&cohort.&imputation_num.x&i;
set st_eff&cohort.&imputation_num.x&i;
cohort = &cohort;
_IMPUTATION_=&imputation_num;
run;
%end;

%mend multi_fit_indices;

%multi_fit_indices(cohort=2014, imputation_num=1, outputfitname=fit14_imp1);
%multi_fit_indices(cohort=2014, imputation_num=2, outputfitname=fit14_imp2);
%multi_fit_indices(cohort=2014, imputation_num=3, outputfitname=fit14_imp3);
%multi_fit_indices(cohort=2014, imputation_num=4, outputfitname=fit14_imp4);
%multi_fit_indices(cohort=2014, imputation_num=5, outputfitname=fit14_imp5);

data field.fit2014_5imputations;
set fit14_imp1 fit14_imp2 fit14_imp3 fit14_imp4 fit14_imp5;
run;

* effects for cohort 2014 imputation 1 to 5 model 2;
data field.eff2014allx2;
set eff20141x2 eff20142x2 eff20143x2 eff20144x2 eff20145x2;
run;

* effects for cohort 2014 imputation 1 to 5 model 5;
data field.eff2014allx5;
set eff20141x5 eff20142x5 eff20143x5 eff20144x5 eff20145x5;
run;

* st_effects for cohort 2014 imputation 1 to 5 model 2;
data field.st_eff2014allx2;
set st_eff20141x2 st_eff20142x2 st_eff20143x2 st_eff20144x2 st_eff20145x2;
run;

* roll up st effects for 5 imputation;
proc mianalyze parms=field.st_eff2014allx2 /*edf=331*/;
modeleffects q14_4	q14_5	q14_8	q14_12	q14_13 q18_5		/*q18_1 q18_2* q18_5*/;
ods output ParameterEstimates=xxxx2; /*Varianceinfo=out_var*//*GET OUTPUTS*/
run;

proc print data=field.st_eff2014allx5;
run;

* st_effects for cohort 2014 imputation 1 to 5 model 5;
data field.st_eff2014allx5;
set st_eff20141x5 st_eff20142x5 st_eff20143x5 st_eff20144x5 st_eff20145x5;
run;

* roll up st effects for 5 imputation;
proc mianalyze parms=field.st_eff2014allx5 /*edf=331*/;
modeleffects q14_4	q14_5	q14_8	q14_12	q14_13		/*q18_1 q18_2* q18_5*/;
ods output ParameterEstimates=xxxx5; /*Varianceinfo=out_var*//*GET OUTPUTS*/
run;





proc transpose data=field.fit2014_5imputations out=x2014;
run;

%multi_fit_indices(cohort=2015, imputation_num=1, outputfitname=fit15_imp1);
%multi_fit_indices(cohort=2015, imputation_num=2, outputfitname=fit15_imp2);
%multi_fit_indices(cohort=2015, imputation_num=3, outputfitname=fit15_imp3);
%multi_fit_indices(cohort=2015, imputation_num=4, outputfitname=fit15_imp4);
%multi_fit_indices(cohort=2015, imputation_num=5, outputfitname=fit15_imp5);

data field.fit2015_5imputations;
set fit15_imp1 fit15_imp2 fit15_imp3 fit15_imp4 fit15_imp5;
run;


%multi_fit_indices(cohort=2016, imputation_num=1, outputfitname=fit16_imp1);
%multi_fit_indices(cohort=2016, imputation_num=2, outputfitname=fit16_imp2);
%multi_fit_indices(cohort=2016, imputation_num=3, outputfitname=fit16_imp3);
%multi_fit_indices(cohort=2016, imputation_num=4, outputfitname=fit16_imp4);
%multi_fit_indices(cohort=2016, imputation_num=5, outputfitname=fit16_imp5);

data field.fit2016_5imputations;
set fit16_imp1 fit16_imp2 fit16_imp3 fit16_imp4 fit16_imp5;
run;



%multi_fit_indices(cohort=2017, imputation_num=1, outputfitname=fit17_imp1);
%multi_fit_indices(cohort=2017, imputation_num=2, outputfitname=fit17_imp2);
%multi_fit_indices(cohort=2017, imputation_num=3, outputfitname=fit17_imp3);
%multi_fit_indices(cohort=2017, imputation_num=4, outputfitname=fit17_imp4);
%multi_fit_indices(cohort=2017, imputation_num=5, outputfitname=fit17_imp5);

data field.fit2017_5imputations;
set fit17_imp1 fit17_imp2 fit17_imp3 fit17_imp4 fit17_imp5;
run;


data field.all_fit;
set fit2014_5imputations fit2015_5imputations fit2016_5imputations fit2017_5imputations;
run;





proc export data=all_fit
outfile ="C:\Users\shh6304\Google Drive\CLASSES\Conferences\AEA Conference 19\Presentation_Predicting_Retention\IOSlides_predicting_retention\all_fit.csv"
dbms=csv
replace;
run;







* Creating sample means and standard errors for the variabes in each imputed data;
 proc univariate data=fit2014_5imputations noprint;
var fitValue1-fitValue6;
      output out=outuni mean= fitValue1-fitValue6

                        stderr=stderr1-stderr21;
      by _Imputation_;
   run;
proc print data=outuni;
title 'UNIVARIATE Means and Standard Errors';
run;
proc MIANALYZE DATA = outuni; /*edf = 10080; complete-case degrees of freedom (this is not used because degrees of freedom for each variable are different and over the concerned cutoff 484*/
  modeleffects Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	
Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7;              /* you can list multiple variables to impute */
stderr stderr1-stderr21;
 run;
