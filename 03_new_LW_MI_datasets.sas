* creating a dataset resulted from a listwise deletion;
libname Field "C:\Users\Dell\Google Drive\CLASSES\2019 Spring\Professional Field Experience 1\00Field";
libname Field "C:\Users\shh6304\Google Drive\CLASSES\2019 Spring\Professional Field Experience 1\00Field";


* deleted observations that can't be matched. so, creating dataset that can be matched ;
* BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB;
* create dataset for survey only, but some variables have missing values in SIS;

proc sql;
select count (random_id)
from Field.Rdata2
where survey = 'Y';


data Field.OS_Rdata3;
set Field.Rdata2;
* removing missing data becasue observations in SIS do not belon gto survey data;
if 
survey = 'N' Then	delete;

* cleaning missing list wise response in survey;
if 
Q14_1	=. AND 	
Q14_2	=. AND 	
Q14_3	=. AND 	
Q14_4	=. AND 	
Q14_5	=. AND 	
Q14_6	=. AND 	
Q14_7	=. AND 	
Q14_8	=. AND 	
Q14_9	=. AND 	
Q14_10	=. AND 	
Q14_11	=. AND 	
Q14_12	=. AND 	
Q14_13	=. AND 	
Q14_14	=. AND 	
Q18_1 	=. AND 	
Q18_2	=. AND 	
Q18_3	=. AND 	
Q18_4	=. AND 	
Q18_5	=. AND 	
Q18_6	=. AND 	
Q18_7	=. 
then delete;
run;



Data Field.LWDel_OS_Rdata3;
set Field.OS_Rdata3;
retain;
if 
Q14_1	=. OR 	
Q14_2	=. OR 	
Q14_3	=. OR 	
Q14_4	=. OR 	
Q14_5	=. OR 	
Q14_6	=. OR 	
Q14_7	=. OR 	
Q14_8	=. OR 	
Q14_9	=. OR 	
Q14_10 =. OR 	
Q14_11 =. OR 	
Q14_12 =. OR 	
Q14_13 =. OR 	
Q14_14 =. OR

Q18_1 =. OR 	
Q18_2	=. OR 	
Q18_3	=. OR 	
Q18_4	=. OR 	
Q18_5	=. OR 	
Q18_6	=. OR 	
Q18_7	=. 

/*hsgpa =. OR*/
/*act =. OR*/
/*sat =. OR*/
/*fall_gpa =. */

Then	delete;
run;


* q14_1-q14_14 = missing and q18_1-q18_7 = 5;

proc sql;
select * 
from Field.OS_Rdata3
where 
q14_1 is  null AND	
q14_2 is  null AND	
q14_3 is  null AND	
q14_4 is  null AND	
q14_5 is  null AND	
q14_6 is  null AND	
q14_7 is  null AND	
q14_8 is  null AND	
q14_9 is  null AND	
q14_10 is  null AND	
q14_11 is  null AND	
q14_12 is  null AND	
q14_13 is  null AND	
q14_14 is  null 
/*q18_1 is not null OR	*/
/*q18_2 is not null OR	*/
/*q18_3 is not null OR	*/
/*q18_4 is not null OR	*/
/*q18_5 is not null OR	*/
/*q18_6 is not null OR	*/
/*q18_7 is not null*/
;
quit;

proc sql;
create table deL01 as (select * 
						from Field.OS_Rdata3
						where random_id ^= 6408);
quit;
proc sql;
select * 
from deL01
where random_id = 6408;
quit;


* response q18_1 to q18_7 = 3;
proc sql;
/*select * */
select count(*)
from deL01
where 
q14_1 =3 AND
q14_2 =3 AND
q14_3 =3 AND
q14_4 =3 AND
q14_5 =3 AND
q14_6 =3 AND
q14_7 =3 AND
q14_8 =3 AND
q14_9 =3 AND
q14_10 =3 AND
q14_11 =3 AND
q14_12 =3 AND
q14_13 =3 AND
q14_14 =3 AND
q18_1 =3 AND
q18_2 =3 AND
q18_3 =3 AND
q18_4 =3 AND
q18_5 =3 AND
q18_6 =3 AND
q18_7 =3
;
quit;
* delete 46 observations with responses to all questions = 3;
data deL02;
set deL01;
if q14_1 =3 AND
q14_2 =3 AND
q14_3 =3 AND
q14_4 =3 AND
q14_5 =3 AND
q14_6 =3 AND
q14_7 =3 AND
q14_8 =3 AND
q14_9 =3 AND
q14_10 =3 AND
q14_11 =3 AND
q14_12 =3 AND
q14_13 =3 AND
q14_14 =3 AND
q18_1 =3 AND
q18_2 =3 AND
q18_3 =3 AND
q18_4 =3 AND
q18_5 =3 AND
q18_6 =3 AND
q18_7 =3 Then delete;
run;


proc sql;
/*select * */
select count(*)
from deL02
where 
q14_1 =3 AND
q14_2 =3 AND
q14_3 =3 AND
q14_4 =3 AND
q14_5 =3 AND
q14_6 =3 AND
q14_7 =3 AND
q14_8 =3 AND
q14_9 =3 AND
q14_10 =3 AND
q14_11 =3 AND
q14_12 =3 AND
q14_13 =3 AND
q14_14 =3 
/*q18_1 =3 AND*/
/*q18_2 =3 AND*/
/*q18_3 =3 AND*/
/*q18_4 =3 AND*/
/*q18_5 =3 AND*/
/*q18_6 =3 AND*/
/*q18_7 =3*/
;
quit;

* delete repsonses of 3 to q14_1 to q14_14;
data deL03;
set deL02;
if q14_1 =3 AND
q14_2 =3 AND
q14_3 =3 AND
q14_4 =3 AND
q14_5 =3 AND
q14_6 =3 AND
q14_7 =3 AND
q14_8 =3 AND
q14_9 =3 AND
q14_10 =3 AND
q14_11 =3 AND
q14_12 =3 AND
q14_13 =3 AND
q14_14 =3 then delete;
run;

proc sql;
/*select * */
select count(*)
from deL03
where 
q14_1 =4 AND
q14_2 =4 AND
q14_3 =4 AND
q14_4 =4 AND
q14_5 =4 AND
q14_6 =4 AND
q14_7 =4 AND
q14_8 =4 AND
q14_9 =4 AND
q14_10 =4 AND
q14_11 =4 AND
q14_12 =4 AND
q14_13 =4 AND
q14_14 =4 
/*q18_1 =3 AND*/
/*q18_2 =3 AND*/
/*q18_3 =3 AND*/
/*q18_4 =3 AND*/
/*q18_5 =3 AND*/
/*q18_6 =3 AND*/
/*q18_7 =3*/
;
quit;

data deL04;
set deL03;
if q14_1 =4 AND
q14_2 =4 AND
q14_3 =4 AND
q14_4 =4 AND
q14_5 =4 AND
q14_6 =4 AND
q14_7 =4 AND
q14_8 =4 AND
q14_9 =4 AND
q14_10 =4 AND
q14_11 =4 AND
q14_12 =4 AND
q14_13 =4 AND
q14_14 =4  then delete;
run;

%let x=5;
proc sql;
/*select * */
select count(*)
from deL04
where 
q14_1 =&x AND
q14_2 =&x AND
q14_3 =&x AND
q14_4 =&x AND
q14_5 =&x AND
q14_6 =&x AND
q14_7 =&x AND
q14_8 =&x AND
q14_9 =&x AND
q14_10 =&x AND
q14_11 =&x AND
q14_12 =&x AND
q14_13 =&x AND
q14_14 =&x 
/*q18_1 =3 AND*/
/*q18_2 =3 AND*/
/*q18_3 =3 AND*/
/*q18_4 =3 AND*/
/*q18_5 =3 AND*/
/*q18_6 =3 AND*/
/*q18_7 =3*/
;
quit;

data deL05;
set deL04;
if 
q14_1 =&x AND
q14_2 =&x AND
q14_3 =&x AND
q14_4 =&x AND
q14_5 =&x AND
q14_6 =&x AND
q14_7 =&x AND
q14_8 =&x AND
q14_9 =&x AND
q14_10 =&x AND
q14_11 =&x AND
q14_12 =&x AND
q14_13 =&x AND
q14_14 =&x 
then delete;
run;

%let x=2;
proc sql;
select * 
/*select count(*)*/
from deL04
where 
q14_1 =&x AND
q14_2 =&x AND
q14_3 =&x AND
q14_4 =&x AND
q14_5 =&x AND
q14_6 =&x AND
q14_7 =&x AND
q14_8 =&x AND
q14_9 =&x AND
q14_10 =&x AND
q14_11 =&x AND
q14_12 =&x AND
q14_13 =&x AND
q14_14 =&x 
/*q18_1 =3 AND*/
/*q18_2 =3 AND*/
/*q18_3 =3 AND*/
/*q18_4 =3 AND*/
/*q18_5 =3 AND*/
/*q18_6 =3 AND*/
/*q18_7 =3*/
;
quit;

data deL06;
set deL05;
if 
q14_1 =&x AND
q14_2 =&x AND
q14_3 =&x AND
q14_4 =&x AND
q14_5 =&x AND
q14_6 =&x AND
q14_7 =&x AND
q14_8 =&x AND
q14_9 =&x AND
q14_10 =&x AND
q14_11 =&x AND
q14_12 =&x AND
q14_13 =&x AND
q14_14 =&x 
then delete;
run;


%let x=1;
proc sql;
select * 
/*select count(*)*/
from deL06
where 
q14_1 =&x AND
q14_2 =&x AND
q14_3 =&x AND
q14_4 =&x AND
q14_5 =&x AND
q14_6 =&x AND
q14_7 =&x AND
q14_8 =&x AND
q14_9 =&x AND
q14_10 =&x AND
q14_11 =&x AND
q14_12 =&x AND
q14_13 =&x AND
q14_14 =&x 
/*q18_1 =3 AND*/
/*q18_2 =3 AND*/
/*q18_3 =3 AND*/
/*q18_4 =3 AND*/
/*q18_5 =3 AND*/
/*q18_6 =3 AND*/
/*q18_7 =3*/
;
quit;
data deL07;
set deL06;
if 
q14_1 =&x AND
q14_2 =&x AND
q14_3 =&x AND
q14_4 =&x AND
q14_5 =&x AND
q14_6 =&x AND
q14_7 =&x AND
q14_8 =&x AND
q14_9 =&x AND
q14_10 =&x AND
q14_11 =&x AND
q14_12 =&x AND
q14_13 =&x AND
q14_14 =&x 
then delete;
run;

%let y=1;

proc sql;
/*select * */
select count(*)
from deL07
where 
/*q14_1 =&x AND*/
/*q14_2 =&x AND*/
/*q14_3 =&x AND*/
/*q14_4 =&x AND*/
/*q14_5 =&x AND*/
/*q14_6 =&x AND*/
/*q14_7 =&x AND*/
/*q14_8 =&x AND*/
/*q14_9 =&x AND*/
/*q14_10 =&x AND*/
/*q14_11 =&x AND*/
/*q14_12 =&x AND*/
/*q14_13 =&x AND*/
/*q14_14 =&x */
q18_1 =&y AND
q18_2 =&y AND
q18_3 =&y AND
q18_4 =&y AND
q18_5 =&y AND
q18_6 =&y AND
q18_7 =&y
;
quit;
data deL08;
set deL07;
/*if */
/*q18_1 =&y AND*/
/*q18_2 =&y AND*/
/*q18_3 =&y AND*/
/*q18_4 =&y AND*/
/*q18_5 =&y AND*/
/*q18_6 =&y AND*/
/*q18_7 =&y*/
/*then delete;*/
run;


%let y=2;

proc sql;
/*select * */
select count(*)
from deL08
where 
/*q14_1 =&x AND*/
/*q14_2 =&x AND*/
/*q14_3 =&x AND*/
/*q14_4 =&x AND*/
/*q14_5 =&x AND*/
/*q14_6 =&x AND*/
/*q14_7 =&x AND*/
/*q14_8 =&x AND*/
/*q14_9 =&x AND*/
/*q14_10 =&x AND*/
/*q14_11 =&x AND*/
/*q14_12 =&x AND*/
/*q14_13 =&x AND*/
/*q14_14 =&x */
q18_1 =&y AND
q18_2 =&y AND
q18_3 =&y AND
q18_4 =&y AND
q18_5 =&y AND
q18_6 =&y AND
q18_7 =&y
;
quit;
data deL09;
set deL08;
/*if */
/*q18_1 =&y AND*/
/*q18_2 =&y AND*/
/*q18_3 =&y AND*/
/*q18_4 =&y AND*/
/*q18_5 =&y AND*/
/*q18_6 =&y AND*/
/*q18_7 =&y*/
/*then delete;*/
run;

%let y=5;

proc sql;
/*select * */
select count(*)
from deL09
where 
/*q14_1 =&x AND*/
/*q14_2 =&x AND*/
/*q14_3 =&x AND*/
/*q14_4 =&x AND*/
/*q14_5 =&x AND*/
/*q14_6 =&x AND*/
/*q14_7 =&x AND*/
/*q14_8 =&x AND*/
/*q14_9 =&x AND*/
/*q14_10 =&x AND*/
/*q14_11 =&x AND*/
/*q14_12 =&x AND*/
/*q14_13 =&x AND*/
/*q14_14 =&x */
q18_1 =&y AND
q18_2 =&y AND
q18_3 =&y AND
q18_4 =&y AND
q18_5 =&y AND
q18_6 =&y AND
q18_7 =&y
;
quit;
data deL10;
set deL09;
/*if */
/*q18_1 =&y AND*/
/*q18_2 =&y AND*/
/*q18_3 =&y AND*/
/*q18_4 =&y AND*/
/*q18_5 =&y AND*/
/*q18_6 =&y AND*/
/*q18_7 =&y*/
/*then delete;*/
run;

%let y=4;

proc sql;
/*select * */
select count(*)
from deL10
where 
/*q14_1 =&x AND*/
/*q14_2 =&x AND*/
/*q14_3 =&x AND*/
/*q14_4 =&x AND*/
/*q14_5 =&x AND*/
/*q14_6 =&x AND*/
/*q14_7 =&x AND*/
/*q14_8 =&x AND*/
/*q14_9 =&x AND*/
/*q14_10 =&x AND*/
/*q14_11 =&x AND*/
/*q14_12 =&x AND*/
/*q14_13 =&x AND*/
/*q14_14 =&x */
q18_1 =&y AND
q18_2 =&y AND
q18_3 =&y AND
q18_4 =&y AND
q18_5 =&y AND
q18_6 =&y AND
q18_7 =&y
;
quit;
data deL11;
set deL10;
/*if */
/*q18_1 =&y AND*/
/*q18_2 =&y AND*/
/*q18_3 =&y AND*/
/*q18_4 =&y AND*/
/*q18_5 =&y AND*/
/*q18_6 =&y AND*/
/*q18_7 =&y*/
/*then delete;*/
run;


%let y=3;

proc sql;
/*select * */
select count(*)
from deL11
where 
/*q14_1 =&x AND*/
/*q14_2 =&x AND*/
/*q14_3 =&x AND*/
/*q14_4 =&x AND*/
/*q14_5 =&x AND*/
/*q14_6 =&x AND*/
/*q14_7 =&x AND*/
/*q14_8 =&x AND*/
/*q14_9 =&x AND*/
/*q14_10 =&x AND*/
/*q14_11 =&x AND*/
/*q14_12 =&x AND*/
/*q14_13 =&x AND*/
/*q14_14 =&x */
q18_1 =&y AND
q18_2 =&y AND
q18_3 =&y AND
q18_4 =&y AND
q18_5 =&y AND
q18_6 =&y AND
q18_7 =&y
;
quit;
data deL12;
set deL11;
/*if */
/*q18_1 =&y AND*/
/*q18_2 =&y AND*/
/*q18_3 =&y AND*/
/*q18_4 =&y AND*/
/*q18_5 =&y AND*/
/*q18_6 =&y AND*/
/*q18_7 =&y*/
/*then delete;*/
run;

data Field.deL12;
set deL12;
*recode reverse coded items;
array dum Q14_1	Q14_2	Q14_6	Q14_9	Q14_10	Q14_11;
do over dum;
	dum=6-dum;
end; 
run;
* Field.DeL12 is the common dataset before lsit wise deletion and MI.;

data Field.deL13;
set Field.del12;
* make unique id;
id = _n_;
run;

data field.deL12;
set Field.deL13;
run;

* create listwise deletion;



data Field.LW_OSfinal;
set Field.deL12;
if 
Q14_1	=. OR 	
Q14_2	=. OR 	
Q14_3	=. OR 	
Q14_4	=. OR 	
Q14_5	=. OR 	
Q14_6	=. OR 	
Q14_7	=. OR 	
Q14_8	=. OR 	
Q14_9	=. OR 	
Q14_10 =. OR 	
Q14_11 =. OR 	
Q14_12 =. OR 	
Q14_13 =. OR 	
Q14_14 =. OR 	
Q18_1 =. OR 	
Q18_2	=. OR 	
Q18_3	=. OR 	
Q18_4	=. OR 	
Q18_5	=. OR 	
Q18_6	=. OR 	
Q18_7	=. 
then delete;
run; 





*Impute missing via EM algorithm;
* imputing and round the imputed values to the nearest integer;
proc mi data=Field.deL12  out =Field.imputed01 
round = 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 /* correspondending to the number of var*/
minimum = 1 
maximum = 5 
nimpute=1;
em outem=em_covar_matrix ;
var Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7/*_ALL_*/;
run;

proc mi data=Field.deL12  out =Field.imputed02 
round = 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 /* correspondending to the number of var*/
minimum = 1 
maximum = 5 
nimpute=1;
em outem=em_covar_matrix ;
var Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7/*_ALL_*/;
run;
proc mi data=Field.deL12  out =Field.imputed03 
round = 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 /* correspondending to the number of var*/
minimum = 1 
maximum = 5 
nimpute=1;
em outem=em_covar_matrix ;
var Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7/*_ALL_*/;
run;
proc mi data=Field.deL12  out =Field.imputed04 
round = 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 /* correspondending to the number of var*/
minimum = 1 
maximum = 5 
nimpute=1;
em outem=em_covar_matrix ;
var Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7/*_ALL_*/;
run;
proc mi data=Field.deL12  out =Field.imputed05 
round = 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 /* correspondending to the number of var*/
minimum = 1 
maximum = 5 
nimpute=1;
em outem=em_covar_matrix ;
var Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7/*_ALL_*/;
run;

proc mi data=Field.deL12  out =Field.imputed_five_times 
round = 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 /* correspondending to the number of var*/
minimum = 1 
maximum = 5 
nimpute=5;
em outem=em_covar_matrix ;
var Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7/*_ALL_*/;
run;

/*CHECKING IMPUTED RESPONSES*/
proc freq data = Field.imputed_five_times;
tables Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	
Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7;
run;
/*RESULTS: RESPONSES COMPLIED*/


proc mi data=Field.deL12  out =Field.imputed_five_times_notRound 
/*round = 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1  correspondending to the number of var*/
minimum = 1 
maximum = 5 
nimpute=5;
em outem=em_covar_matrix ;
var Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7/*_ALL_*/;
run;

* Imputation by Mean;
/* https://blogs.sas.com/content/iml/2017/12/04/mean-imputation-sas.html*/
/* Mean imputation: Use PROC STDIZE to replace missing values with mean */
proc stdize data=Field.deL12 out=Field.Imputed_Mean_NotRounded 
      oprefix=Orig_         /* prefix for original variables */
      reponly               /* only replace; do not standardize */
      method=MEAN;          /* or MEDIAN, MINIMUM, MIDRANGE, etc. */
   var Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	
Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7;              /* you can list multiple variables to impute */
run;

* Rounding the imputed value;
data Field.Imputed_Mean_Rounded;
set Field.Imputed_Mean_NotRounded;
format 
Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	
Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7 1.0;
run;

/*CHECKING IMPUTED RESPONSES*/
proc freq data = Field.Imputed_Mean_Rounded;
tables Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	
Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7;
run;
/**RESULTS: RESPONSES COMPLIED/

/* https://support.sas.com/documentation/cdl/en/statug/63033/HTML/default/viewer.htm#statug_mi_sect043.htm */
* Using MCMC method;
* Method 1: produce monotone pattern and use regression to impute data;
PROC MI data=Field.deL12  seed = 21355417 out = imputed_Monotone;
mcmc impute = monotone;
var Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	
Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7;              /* you can list multiple variables to impute */
run;
* checking monotone pattern;
 proc mi data=imputed_Monotone  nimpute=0;
 var Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	
Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7;              /* you can list multiple variables to impute */
run;
* using regression to impute data;
* This is just imple regression. It can be done because the pattern is monotone;
 proc mi data=imputed_Monotone nimpute=1 seed=51343672 out=A_reg_imputed;
      monotone method=reg;
 var Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	
Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7;              /* you can list multiple variables to impute */
 by _Imputation_;
run;
* GET DATA OUT TO LIBRARY FIELD.;
* 25 imputation;
DATA FIELD.A_reg_imputed;
SET A_reg_imputed;
RUN;
/*CHECKING IMPUTED RESPONSES*/
proc freq data = FIELD.A_reg_imputed;
tables Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	
Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7;
run;
/*RESULTS: VALUES ARE FROM NEGATIVE TO GREATER THAN 5*/



DATA FIELD.A_reg_imputed_rounded;
SET FIELD.A_reg_imputed;
format 
Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	
Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7 1.0;

ARRAY ROUND Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	
Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7;
DO OVER ROUND;
IF ROUND <1.50 THEN ROUND =1;
IF ROUND >=1.50 AND ROUND <2.50 THEN ROUND = 2;
IF ROUND >=2.50 AND ROUND <3.50 THEN ROUND =3;
IF ROUND >=3.50 AND ROUND <4.50 THEN ROUND =4;
IF ROUND >=4.50 THEN ROUND = 5;
END;
RUN;
/*CHECKING IMPUTED RESPONSES*/
proc freq data = FIELD.A_reg_imputed_rounded;
tables Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	
Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7;
run;

/*RESULTS: ROUNDED VALUES ARE FROM 1 TO 5*/

* checking imputed values;
/* proc freq data=A_reg_imputed  ;*/
/* tables Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	*/
/*Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7;              /* you can list multiple variables to impute */*/
/*run;*/
;
* Creating sample means and standard errors for the variabes in each imputed data;
 proc univariate data=Field.A_reg_imputed noprint;
var Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	
Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7;          
      output out=outuni mean= Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	
Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7

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
/* read more to know how to interprete the results
 https://support.sas.com/documentation/cdl/en/statug/63033/HTML/default/viewer.htm#statug_mianalyze_sect012.htm
 https://support.sas.com/documentation/cdl/en/statug/63033/HTML/default/viewer.htm#statug_mianalyze_sect019.htm
* About relative efficiencies;
 https://support.sas.com/documentation/cdl/en/statug/63033/HTML/default/viewer.htm#statug_mianalyze_sect013.htm 
 */

*method 2: using MCMC approach to impute data fully (without creating a monotone pattern);
 title1; title2;
PROC MI data=Field.deL12  seed = 21355417 nimpute=5 out = imputed_MCMC;
mcmc nbiter=500 niter=200 plots=all timeplot(WLF);
*mcmc chain = multiple displayinit initial = em(itprint) plots=all timeplot(WLF);
var Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	
Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7;              /* you can list multiple variables to impute */
ods output Varianceinfo=out_var;
run;


data Field.imputed_mcmc;
set imputed_mcmc;
run;
/*CHECK IMPUTED VALUES*/
proc freq data=field.imputed_mcmc;
tables Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	
Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7;
run;
/*RESULTS: IMPUTED VALUES ARE FROM NEGATIVE TO GREATER THAN 5*/


/*rounding field.imputed_mcmc*/
DATA Field.imputed_mcmc_rounded;
SET Field.imputed_mcmc;
format 
Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	
Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7 1.0;

ARRAY ROUND Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	
Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7;
DO OVER ROUND;
IF ROUND <1.50 THEN ROUND =1;
IF ROUND >=1.50 AND ROUND <2.50 THEN ROUND = 2;
IF ROUND >=2.50 AND ROUND <3.50 THEN ROUND =3;
IF ROUND >=3.50 AND ROUND <4.50 THEN ROUND =4;
IF ROUND >=4.50 THEN ROUND = 5;
END;
RUN;
/*CHECK ROUNDED IMPUTED VALUES*/
proc freq data=field.imputed_mcmc_rounded;
tables Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	
Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7;
run;
/*RESULTS: ROUNDED IMPUTED VALUES ARE WITHIN THE RANGE OF 1 AND 5*/





* Imputing with Predictive mean matching ;
* I think this is similar to group mean imputation;
 


* Fully conditional specification (FCS) method;
/*
Number of Imputations 25 
Number of Burn-in Iterations 5 
It requires a continuous variable in the list to work
It didnt' work for many variables.
. 
/**/*/
/*proc mi data=Field.deL12 seed=1000 out=Imputed_FCS;*/
/*   class Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	*/
/*Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6 q18_7;*/
/*    fcs nbiter=5 discrim(Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	*/
/*Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	q18_7/details) reg(hsgpa/details);*/
/*   var Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	*/
/*Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7 hsgpa;*/
/**/
/*run;*/
/**/
/*data Field.Imputed_FCS;*/
/*set Imputed_FCS;*/
/*format*/
/*Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	*/
/*Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7 1.0;*/
/*run;*/
/**/
/** checking values of imputed data;*/
/*proc freq data = Field.Imputed_FCS;*/
/*tables Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	*/
/*Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7;*/
/*run;*/
* imputing with MCMC;

/*proc means data = imputed01;*/
/*var hsgpa act fall_gpa;*/
/*run;*/
/**/
/**/
/*proc mi data =imputed01 out=field.imputed01*/
/*round = 0.01 1 0.01*/
/*minimum = 0 */
/*maximum = 36 */
/*nimpute=1;*/
/*em outem=em_covar_matrix2;*/
/*var hsgpa act fall_gpa;*/
/*run;*/






*Run EFA on imputed covariance matrix;
/*ods graphics on;*/
/*proc factor data = em_covar_matrix nobs=10588 nfactors = 3 method = uls*/
/*rotate=oblimin all;*/
/*var Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7;*/
/*run;*/
/*ods graphics off;*/
