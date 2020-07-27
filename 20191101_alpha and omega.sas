*macro for Alpha and Omega;
/**/
/**/
/*proc contents noprint*/
/*  data = field.scores15*/
/*  OUT = OUT(keep=nobs)*/
/*;*/
/*run;*/
/*data _NULL_;*/
/*	set OUT(obs=1);*/
/*	call symputx('nrows',nobs);*/
/*	stop;*/
/*run;*/
/**/
/*%put &=nrows;*/
/**/




%macro Rev_22_13(data=, items=items???, nitems= );

* get number of observation; 

proc sql noprint;
select count(*)
into :nobs
from &data
quit;
%put Count=&nobs;

* using proc calis to get factor loadings and error variance;
proc calis  data=&data method=ML Nobs=&nobs outstat=bo_omega_ noprint
			covariance se res;
	var &items;
    factor 
		Factor1 ---> &items;
	pvar Factor1 = 1.;
    title1 "One Factor Model";
    run;

* extract loadings and error variance; 
data bo_load_(drop=_type_ _name_ Factor1);
	set bo_omega_;
if _type_="LOADINGS" or _type_="ERRVAR"; /*drop everything else except these two*/
run;
proc transpose	data=bo_load_
				out=bo_load(rename=(_name_=Variable Col1=Factor1 Col2=ErrorVar));
	run;
* sum all factor laodings and error variance;
proc means data=bo_load sum noprint;
    var factor1 ErrorVar;
    output out=bo_omega1 sum=F1_sum EV_sum;
run;
* print factor loadings and error variance;
proc print data=bo_load;
run;
proc print data=bo_omega1;
run;

* calculating omega;
data bfinal_omega;
	set bo_omega1;
omega=F1_Sum**2/(F1_Sum**2+EV_sum); 
/*omega = sum of all factor loadings squared/(sum of all factor loadings squared + sum of all error variance)*/

run;

proc print data=bfinal_omega;
	var omega;
	title2 "Coefficient Omega";
	run;

	* CALCULATING ALPHA;
* creating total score;
	data rev;
	set &data;
	total = sum(of &items);
	run;

	* calculate variance for items and total scores;
proc means data=rev var;
var &items total;
output out=bo_var var =var1-var&nitems total_var;
run;
*This is cronbach alpha;
data final_alpha;
set bo_var;
alpha=(&nitems/(&nitems-1))*(1-(sum(of var1-var&nitems))/total_var);
run;

proc print data=final_alpha;
var alpha;
run;

data alpha_omega (keep=alpha omega);
merge final_alpha bfinal_omega;
proc print;
title "Alpha and Omega Coefficients";
run;

%mend Rev_22_13;

* SIX ITEMS;
* cohort 2014;
%rev_22_13(data=field.scores14,
items=q14_4 q14_5 q14_8 q14_12	q14_13 q18_5,
nitems=6
);

data alpha_omega14;
set alpha_omega;
cohort=2014;
run;

* cohort 2015;
%rev_22_13(data=field.scores15,
items=q14_4 q14_5 q14_8 q14_12	q14_13 q18_5,
nitems=6
);

data alpha_omega15;
set alpha_omega;
cohort=2015;
run;

* cohort 2016;
%rev_22_13(data=field.scores16,
items=q14_4 q14_5 q14_8 q14_12	q14_13 q18_5,
nitems=6
);

data alpha_omega16;
set alpha_omega;
cohort=2016;
run;

* cohort 2017;
%rev_22_13(data=field.scores17,
items=q14_4 q14_5 q14_8 q14_12	q14_13 q18_5,
nitems=6
);

data alpha_omega17;
set alpha_omega;
cohort=2017;
run;

data alpha_omega_m1;
set alpha_omega14 alpha_omega15 alpha_omega16 alpha_omega17;
Model="model1_sixitems";
run;



* FIVe ITEMS;
* cohort 2014;
%rev_22_13(data=field.scores14,
items=q14_4 q14_5 q14_8 q14_12	q14_13 ,
nitems=5
);

data alpha_omega14;
set alpha_omega;
cohort=2014;
run;

* cohort 2015;
%rev_22_13(data=field.scores15,
items=q14_4 q14_5 q14_8 q14_12	q14_13 ,
nitems=5
);

data alpha_omega15;
set alpha_omega;
cohort=2015;
run;

* cohort 2016;
%rev_22_13(data=field.scores16,
items=q14_4 q14_5 q14_8 q14_12	q14_13 ,
nitems=5
);

data alpha_omega16;
set alpha_omega;
cohort=2016;
run;

* cohort 2017;
%rev_22_13(data=field.scores17,
items=q14_4 q14_5 q14_8 q14_12	q14_13 ,
nitems=5
);

data alpha_omega17;
set alpha_omega;
cohort=2017;
run;

data alpha_omega_m2;
set alpha_omega14 alpha_omega15 alpha_omega16 alpha_omega17;
Model="model2_fiveitems";
run;

data all_alpha_omega;
set alpha_omega_m1 alpha_omega_m2;
run;

proc print data = all_alpha_omega;
run;


proc export data =all_alpha_omega
outfile="C:\Users\shh6304\Google Drive\CLASSES\Conferences\AEA Conference 19\Presentation_Predicting_Retention\IOSlides_predicting_retention\all_alpha_omega.csv"
dbms=csv
replace;
run;
