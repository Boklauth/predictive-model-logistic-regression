libname Field "C:\Users\dell\Google Drive\CLASSES\2019 Spring\Professional Field Experience 1\00Field";



* CREATING A NEW DATASET FOR EFA;
* THIS DATASET HAS SURVEY RESPONSES, BUT SOME OF THE OBSERVATIONS MAY NOT BE ABLE TO BE MATCHED WITH STUDENT DATA BECAUSE INVALID ID;
* the two codes below creates the same dataset;

* BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB;

* DATASET FOR LISTWISE DELETION;



* deleted observations that can't be matched. so, creating dataset that can be matched ;
data Rdata3;
set Field.Rdata2;
retain;
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
Q18_7	=. Then	delete;
run;
* creating a dataset resulted from a listwise deletion;

Data Field.LWDel_Rdata3;
set Rdata3;
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


* BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB;

* DATASET FOR PROC MI AND SCORE PATTERN DETECTION;

* BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB;
* deleting observations that do not contain all listwise reponses;
* for proc mi and removing score pattern;
data Rdata3EFA_;
set Field.Rdata2;
retain;
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
Q18_7	=. Then	delete;
run;


/*proc sql;*/
/*create table Field.Rdata3EFA */
/*as (select * from Field.Rdata2*/
/*where	*/
/*q14_1 is not null OR	*/
/*q14_2 is not null OR	*/
/*q14_3 is not null OR	*/
/*q14_4 is not null OR	*/
/*q14_5 is not null OR	*/
/*q14_6 is not null OR	*/
/*q14_7 is not null OR	*/
/*q14_8 is not null OR	*/
/*q14_9 is not null OR	*/
/*q14_10 is not null OR	*/
/*q14_11 is not null OR	*/
/*q14_12 is not null OR	*/
/*q14_13 is not null OR	*/
/*q14_14 is not null OR	*/
/*q18_1 is not null OR	*/
/*q18_2 is not null OR	*/
/*q18_3 is not null OR	*/
/*q18_4 is not null OR	*/
/*q18_5 is not null OR	*/
/*q18_6 is not null OR	*/
/*q18_7 is not null*/
/*);*/
/*quit;*/




* Get response pattern;
*Impute missing via EM algorithm;
proc mi data=Rdata3EFA_ nimpute=0;
em outem=em_covar_matrix /*out =imputed_DS*/;
var Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7/*_ALL_*/;
run;

proc freq data = imputed_DS;
tables Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7/*_ALL_*/;
run;

* q14_1-q14_14 = missing and q18_1-q18_7 = 5;

proc sql;
select * 
from Rdata3EFA_
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
						from Rdata3EFA_
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
if 
q18_1 =&y AND
q18_2 =&y AND
q18_3 =&y AND
q18_4 =&y AND
q18_5 =&y AND
q18_6 =&y AND
q18_7 =&y
then delete;
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
if 
q18_1 =&y AND
q18_2 =&y AND
q18_3 =&y AND
q18_4 =&y AND
q18_5 =&y AND
q18_6 =&y AND
q18_7 =&y
then delete;
run;

%let y=5;

proc sql;
select * 
/*select count(*)*/
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
if 
q18_1 =&y AND
q18_2 =&y AND
q18_3 =&y AND
q18_4 =&y AND
q18_5 =&y AND
q18_6 =&y AND
q18_7 =&y
then delete;
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
if 
q18_1 =&y AND
q18_2 =&y AND
q18_3 =&y AND
q18_4 =&y AND
q18_5 =&y AND
q18_6 =&y AND
q18_7 =&y
then delete;
run;


%let y=3;

proc sql;
select * 
/*select count(*)*/
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
if 
q18_1 =&y AND
q18_2 =&y AND
q18_3 =&y AND
q18_4 =&y AND
q18_5 =&y AND
q18_6 =&y AND
q18_7 =&y
then delete;
run;

*Impute missing via EM algorithm;
* imputing and round the imputed values to the nearest integer;
proc mi data=deL12  out =imputed01 
round = 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 /* correspondending to the number of var*/
minimum = 1 
maximum = 5 
nimpute=1;
em outem=em_covar_matrix ;
var Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7/*_ALL_*/;
run;


* ;
data Field.imputedDS;
set imputed01;
run;

proc means data = imputed01;
var hsgpa act fall_gpa;
run;


proc mi data =imputed01 out=field.imputed01
round = 0.01 1 0.01
minimum = 0 
maximum = 36 
nimpute=1;
em outem=em_covar_matrix2;
var hsgpa act fall_gpa;
run;






*Run EFA on imputed covariance matrix;
/*ods graphics on;*/
/*proc factor data = em_covar_matrix nobs=10588 nfactors = 3 method = uls*/
/*rotate=oblimin all;*/
/*var Q14_1	Q14_2	Q14_3	Q14_4	Q14_5	Q14_6	Q14_7	Q14_8	Q14_9	Q14_10	Q14_11	Q14_12	Q14_13	Q14_14	Q18_1 	Q18_2 Q18_3	Q18_4	Q18_5 Q18_6	Q18_7;*/
/*run;*/
/*ods graphics off;*/
