
libname Field "C:\Users\shh6304\Google Drive\CLASSES\2019 Spring\Professional Field Experience 1\00Field";


proc import datafile = 'C:\Users\shh6304\Google Drive\CLASSES\2019 Spring\Professional Field Experience 1\Data from will\combined_data_stripped.csv'
 out = TempoD
 dbms = csv replace
 ;
run;

* REDUCE COLUMNS TO WHAT WOULD BE NEEDED;
* A note on college choice;
* Q17 (for 2014 and 2015);
* Q17_1 to Q17_6 (for 2016 and 2017);
Data Field.ReducedData (keep=random_id	year	cohort	ftiac	ftpt	primary_ethnicity	
gender	college	dept	dept_name	hsgpa	act	sat	residency	stem county_code	county	state_code	state	
nation_code	nation	fall_gpa	fall_accum_gpa	spring_gpa	spring_accum_gpa	returned	
grad_in_4	grad_in_6	survey	registered	q14_1	q14_2	q14_3	q14_4	q14_5	q14_6	q14_7	q14_8
q14_9	q14_10	q14_11	q14_12	q14_13	q14_14	q18_1	q18_2	q18_3	q18_4	q18_5	q18_6	q18_7
q17 q17_1	q17_2	q17_3	q17_4	q17_5	q17_6);
set TempoD;
retain;
RUN;

/*
THREE RECORDS THAT CAN BE MATCHED WITH YEAR AND COHORT ARE MISSING
I TOLD WILL ABOUT THAT. I WILL UPDATE THIS ONCE I HAVE THE ANSWER;
*/
proc sql;
select * 
from Field.ReducedData
where returned IS NULL AND cohort IS NOT NULL;
quit;





* RECODE reducedData into Rdata2;
data Field.RData2(drop=total);
set Field.ReducedData;

* recoding registered; * 1 = not registered following the orientation;
	If registered='Y' then dummyRegistered=1; Else dummyRegistered=0;


/** Retained first semester or not;*/
/*	If fall_gpa=>0 AND registered ="Y" then S1Returned=1; */
/*	If (fall_gpa="" OR fall_gpa=0) AND registered ="N" then S1Returned=0; */

* Retained for the second semester or not;
	If spring_gpa=>0 then S2Returned=1; 
	If spring_gpa=0 then S2Returned=0;
	If spring_gpa="" AND registered ="Y" then S2Returned=0; 

* returned for the second year or third semester;
	If returned=1 then Y2Returned=1;
	If returned=0 then Y2Returned=0;



* recoding primary_ethnicity-to ethnic;
* reference group is White;
	If primary_ethnicity='American Indian or Alaska Native' then AIndian=1; Else AIndian=0;
	If primary_ethnicity='Asian' then Asian=1; Else Asian=0;
	If primary_ethnicity='Black or African American' then Black=1; Else Black=0;
	If primary_ethnicity='Hispanic' then Hispanic=1; Else Hispanic=0;
	If primary_ethnicity='International' then Internat=1; Else Internat=0;
	If primary_ethnicity='Native Hawaiian or Other Pacific Islander' then Hawaiian=1; Else Hawaiian=0;
	If primary_ethnicity='Two or More Races' then MultiRaces=1; Else MultiRaces=0;
	If primary_ethnicity='Unknown' then Unknownrace=1; Else Unknownrace=0;
	If primary_ethnicity='' then Unknownrace=1; Else Unknownrace=0;


* recoding gender and reference group is male;
	If gender='Female' then dummyfemale=1; Else dummyfemale=0;

* recoding residency; *resident as reference group;
	If residency='Resident' then dummyResident=1; Else dummyResident=0;

* recoding survey; * N as reference group;
	If survey='Y' then dummySurvey=1; Else dummySurvey=0;


* recoding first choice, second choice, beyond_second choice;
* recoding choice of college;
	* coding for cohort 2014 and 2015;
	If q17=1 then dummy1stChoice=1; Else dummy1stChoice=0;
	If q17=2 then dummy2ndChoice=1; Else dummy2ndChoice=0;
	If q17>2 then dummyOtherChoice=1; Else dummyOtherChoice=0;
	* coding for cohort 2016 adn 2017;
	if q17_1=1 then dummy1stChoice=1;
	If q17_2=1 then dummy2ndChoice=1;
	If q17_3=1 then dummyOtherChoice=1;
	If q17_4=1 then dummyOtherChoice=1;
	If q17_5=1 then dummyOtherChoice=1;
	If q17_6=1 then dummyOtherChoice=1;

	* fixing multiresponse options;
	total=sum(of q17_1--q17_6);
	* 1st choice with 2nd choice =>2nd choice;
	If total=2 AND q17_1=1 AND q17_2=1 then do;
		dummy1stChoice=0;
		dummy2ndChoice=1;
		end;
	* 1st choice with any other choice=>other choice;
	If total=2 AND q17_1=1 AND q17_2="" then do; 
		dummy1stChoice=0;
		dummy2ndChoice=0;
		dummyOtherChoice=1;
		end;
		* Any two commbination not involved 1st choice and 2nd choice=> Other choice;
	If total=2 AND q17_1="" AND q17_2="" then do;
		dummy1stChoice=0;
		dummy2ndChoice=0;
		dummyOtherChoice=1;
		end;
		* Any combination not involved 1st choice => other choice;
	If total=2 AND q17_1="" AND q17_2=1 then do;
		dummy1stChoice=0;
		dummy2ndChoice=0;
		dummyOtherChoice=1;
		end;
		* total >= 3 => other choice;
	If total>=3 then do;
		dummy1stChoice=0;
		dummy2ndChoice=0;
		dummyOtherChoice=1 ;
		end;

		* Converting SAT score to ACT score;
		* https://www.princetonreview.com/college-advice/act-to-sat-conversion;
		* This sat-act conversion only applied to 2017 dataset because SAT only exists for that year.

		if sat =< 	1600	 AND sat > 	1590	then act = 	36	;
		if sat =< 	1590	 AND sat > 	1580	then act = 	35	;
		if sat =< 	1580	 AND sat > 	1570	then act = 	35	;
		if sat =< 	1570	 AND sat > 	1560	then act = 	35	;
		if sat =< 	1560	 AND sat > 	1550	then act = 	35	;
		if sat =< 	1550	 AND sat > 	1540	then act = 	34	;
		if sat =< 	1540	 AND sat > 	1530	then act = 	34	;
		if sat =< 	1530	 AND sat > 	1520	then act = 	34	;
		if sat =< 	1520	 AND sat > 	1510	then act = 	34	;
		if sat =< 	1510	 AND sat > 	1500	then act = 	33	;
		if sat =< 	1500	 AND sat > 	1490	then act = 	33	;
		if sat =< 	1490	 AND sat > 	1480	then act = 	33	;
		if sat =< 	1480	 AND sat > 	1470	then act = 	32	;
		if sat =< 	1470	 AND sat > 	1460	then act = 	32	;
		if sat =< 	1460	 AND sat > 	1450	then act = 	32	;
		if sat =< 	1450	 AND sat > 	1440	then act = 	32	;
		if sat =< 	1440	 AND sat > 	1430	then act = 	31	;
		if sat =< 	1430	 AND sat > 	1420	then act = 	31	;
		if sat =< 	1420	 AND sat > 	1410	then act = 	31	;
		if sat =< 	1410	 AND sat > 	1400	then act = 	30	;
		if sat =< 	1400	 AND sat > 	1390	then act = 	30	;
		if sat =< 	1390	 AND sat > 	1380	then act = 	30	;
		if sat =< 	1380	 AND sat > 	1370	then act = 	29	;
		if sat =< 	1370	 AND sat > 	1360	then act = 	29	;
		if sat =< 	1360	 AND sat > 	1350	then act = 	29	;
		if sat =< 	1350	 AND sat > 	1340	then act = 	29	;
		if sat =< 	1340	 AND sat > 	1330	then act = 	28	;
		if sat =< 	1330	 AND sat > 	1320	then act = 	28	;
		if sat =< 	1320	 AND sat > 	1310	then act = 	28	;
		if sat =< 	1310	 AND sat > 	1300	then act = 	28	;
		if sat =< 	1300	 AND sat > 	1290	then act = 	27	;
		if sat =< 	1290	 AND sat > 	1280	then act = 	27	;
		if sat =< 	1280	 AND sat > 	1270	then act = 	27	;
		if sat =< 	1270	 AND sat > 	1260	then act = 	26	;
		if sat =< 	1260	 AND sat > 	1250	then act = 	26	;
		if sat =< 	1250	 AND sat > 	1240	then act = 	26	;
		if sat =< 	1240	 AND sat > 	1230	then act = 	26	;
		if sat =< 	1230	 AND sat > 	1220	then act = 	25	;
		if sat =< 	1220	 AND sat > 	1210	then act = 	25	;
		if sat =< 	1210	 AND sat > 	1200	then act = 	25	;
		if sat =< 	1200	 AND sat > 	1190	then act = 	25	;
		if sat =< 	1190	 AND sat > 	1180	then act = 	24	;
		if sat =< 	1180	 AND sat > 	1170	then act = 	24	;
		if sat =< 	1170	 AND sat > 	1160	then act = 	24	;
		if sat =< 	1160	 AND sat > 	1150	then act = 	24	;
		if sat =< 	1150	 AND sat > 	1140	then act = 	23	;
		if sat =< 	1140	 AND sat > 	1130	then act = 	23	;
		if sat =< 	1130	 AND sat > 	1120	then act = 	23	;
		if sat =< 	1120	 AND sat > 	1110	then act = 	22	;
		if sat =< 	1110	 AND sat > 	1100	then act = 	22	;
		if sat =< 	1100	 AND sat > 	1090	then act = 	22	;
		if sat =< 	1090	 AND sat > 	1080	then act = 	21	;
		if sat =< 	1080	 AND sat > 	1070	then act = 	21	;
		if sat =< 	1070	 AND sat > 	1060	then act = 	21	;
		if sat =< 	1060	 AND sat > 	1050	then act = 	21	;
		if sat =< 	1050	 AND sat > 	1040	then act = 	20	;
		if sat =< 	1040	 AND sat > 	1030	then act = 	20	;
		if sat =< 	1030	 AND sat > 	1020	then act = 	20	;
		if sat =< 	1020	 AND sat > 	1010	then act = 	20	;
		if sat =< 	1010	 AND sat > 	1000	then act = 	19	;
		if sat =< 	1000	 AND sat > 	990	then act = 	19	;
		if sat =< 	990	 AND sat > 	980	then act = 	19	;
		if sat =< 	980	 AND sat > 	970	then act = 	19	;
		if sat =< 	970	 AND sat > 	960	then act = 	18	;
		if sat =< 	960	 AND sat > 	950	then act = 	18	;
		if sat =< 	950	 AND sat > 	940	then act = 	18	;
		if sat =< 	940	 AND sat > 	930	then act = 	18	;
		if sat =< 	930	 AND sat > 	920	then act = 	17	;
		if sat =< 	920	 AND sat > 	910	then act = 	17	;
		if sat =< 	910	 AND sat > 	900	then act = 	17	;
		if sat =< 	900	 AND sat > 	890	then act = 	17	;
		if sat =< 	890	 AND sat > 	880	then act = 	16	;
		if sat =< 	880	 AND sat > 	870	then act = 	16	;
		if sat =< 	870	 AND sat > 	860	then act = 	16	;
		if sat =< 	860	 AND sat > 	850	then act = 	16	;
		if sat =< 	850	 AND sat > 	840	then act = 	15	;
		if sat =< 	840	 AND sat > 	830	then act = 	15	;
		if sat =< 	830	 AND sat > 	820	then act = 	15	;
		if sat =< 	820	 AND sat > 	810	then act = 	15	;
		if sat =< 	810	 AND sat > 	800	then act = 	15	;
		if sat =< 	800	 AND sat > 	790	then act = 	14	;
		if sat =< 	790	 AND sat > 	780	then act = 	14	;
		if sat =< 	780	 AND sat > 	770	then act = 	14	;
		if sat =< 	770	 AND sat > 	760	then act = 	14	;
		if sat =< 	760	 AND sat > 	750	then act = 	14	;
		if sat =< 	750	 AND sat > 	740	then act = 	13	;
		if sat =< 	740	 AND sat > 	730	then act = 	13	;
		if sat =< 	730	 AND sat > 	720	then act = 	13	;
		if sat =< 	720	 AND sat > 	710	then act = 	13	;
		if sat =< 	710	 AND sat > 	700	then act = 	12	;
		if sat =< 	700	 AND sat > 	690	then act = 	12	;
		if sat =< 	690	 AND sat > 	680	then act = 	12	;
		if sat =< 	680	 AND sat > 	670	then act = 	12	;
		if sat =< 	670	 AND sat > 	660	then act = 	12	;
		if sat =< 	660	 AND sat > 	650	then act = 	12	;
		if sat =< 	650	 AND sat > 	640	then act = 	12	;
		if sat =< 	640	 AND sat > 	630	then act = 	12	;
		if sat =< 	630	 AND sat > 	620	then act = 	12	;
		if sat =< 	620	 AND sat > 	610	then act = 	11	;
		if sat =< 	610	 AND sat > 	600	then act = 	11	;
		if sat =< 	600	 AND sat > 	590	then act = 	11	;
		if sat =< 	590	 AND sat > 	580	then act = 	11	;
		if sat =< 	580	 AND sat > 	570	then act = 	11	;
		if sat =< 	570	 AND sat > 	560	then act = 	11	;
		if sat =< 	560	 AND sat > 	0	then act = 	11	;

* Converting ACT to SAT;


run;

/*proc print data=Field.ReducedData;*/
/*var dept;*/
/*where college="";*/
/*run;*/
/** Testing data;*/
/*data x;*/
/*set Rdata2;*/
/*run;*/
/*proc print data=x;*/
/*var total q17_1--q17_6 dummy1stChoice dummy2ndChoice dummyOtherChoice;*/
/*where total>1;*/
/*run;*/

* checking frequency to varify data;
/*proc freq data =Field.Rdata2;*/
/*Table (q17 q17_1	q17_2	q17_3	q17_4	q17_5	q17_6 dummy1stChoice dummy2ndChoice dummyOtherChoice)*cohort;*/
/*run;*/
/*proc freq data=Field.Rdata2;*/
/*Table residency dummyResident survey dummySurvey registered dummyRegistered returned dummyY1Returned;*/
/*run; */

* Need to recode data to all numbers. Then covern separate the file.; 



/** recoding gender; *Female as the reference group;*/
/*	If gender='Male' then male=1; Else male=0;*/
/**/
/** recoding college; * Arts & Sciences as reference group;*/
/*	If college='Engineering & Applied Sciences' then ceas=1; Else ceas=0;*/
/*	If college='Haworth College of Business' then cob=1; Else cob=0;*/
/*	If college='Fine Arts' then cfa=1; Else cfa=0;*/
/*	If college='Other' then other=1; Else other=0;*/
/*	If college='Education & Human Development' then cehd=1; Else cehd=0;*/
/*	If college='Health & Human Services' then chhs=1; Else chhs=0;*/
/*	If college='Aviation' then coa=1; Else coa=0;*/
/**/
/*	* recoding dept; * ACTY as reference group;*/
/**reference;*/
/*	If dept='ANTH' then ANTH=1; Else ANTH=0;*/
/*	If dept='ART' then ART=1; Else ART=0;*/
/*	If dept='AVS' then AVS=1; Else AVS=0;*/
/*	If dept='BIOS' then BIOS=1; Else BIOS=0;*/
/*	If dept='BIS' then BIS=1; Else BIS=0;*/
/*	If dept='CCE' then CCE=1; Else CCE=0;*/
/*	If dept='CHEM' then CHEM=1; Else CHEM=0;*/
/*	If dept='COM' then COM=1; Else COM=0;*/
/*	If dept='CS' then CS=1; Else CS=0;*/
/*	If dept='DANC' then DANC=1; Else DANC=0;*/
/*	If dept='ECE' then ECE=1; Else ECE=0;*/
/*	If dept='ECON' then ECON=1; Else ECON=0;*/
/*	If dept='EDMM' then EDMM=1; Else EDMM=0;*/
/*	If dept='ENGL' then ENGL=1; Else ENGL=0;*/
/*	If dept='ENVS' then ENVS=1; Else ENVS=0;*/
/*	If dept='FCL' then FCL=1; Else FCL=0;*/
/*	If dept='FCS' then FCS=1; Else FCS=0;*/
/*	If dept='GEOG' then GEOG=1; Else GEOG=0;*/
/*	If dept='GEOS' then GEOS=1; Else GEOS=0;*/
/*	If dept='GWS' then GWS=1; Else GWS=0;*/
/*	If dept='HIST' then HIST=1; Else HIST=0;*/
/*	If dept='HPHE' then HPHE=1; Else HPHE=0;*/
/*	If dept='IEM' then IEM=1; Else IEM=0;*/
/*	If dept='IHP' then IHP=1; Else IHP=0;*/
/*	If dept='INTA' then INTA=1; Else INTA=0;*/
/*	If dept='INTB' then INTB=1; Else INTB=0;*/
/*	If dept='INTD' then INTD=1; Else INTD=0;*/
/*	If dept='INTE' then INTE=1; Else INTE=0;*/
/*	If dept='INTH' then INTH=1; Else INTH=0;*/
/*	If dept='INTO' then INTO=1; Else INTO=0;*/
/*	If dept='LANG' then LANG=1; Else LANG=0;*/
/*	If dept='MATH' then MATH=1; Else MATH=0;*/
/*	If dept='ME' then ME=1; Else ME=0;*/
/*	If dept='MGMT' then MGMT=1; Else MGMT=0;*/
/*	If dept='MKTG' then MKTG=1; Else MKTG=0;*/
/*	If dept='MUS' then MUS=1; Else MUS=0;*/
/*	If dept='NUR' then NUR=1; Else NUR=0;*/
/*	If dept='PAPR' then PAPR=1; Else PAPR=0;*/
/*	If dept='PHIL' then PHIL=1; Else PHIL=0;*/
/*	If dept='PHYS' then PHYS=1; Else PHYS=0;*/
/*	If dept='PSCI' then PSCI=1; Else PSCI=0;*/
/*	If dept='PSY' then PSY=1; Else PSY=0;*/
/*	If dept='SOC' then SOC=1; Else SOC=0;*/
/*	If dept='SPAN' then SPAN=1; Else SPAN=0;*/
/*	If dept='SPLS' then SPLS=1; Else SPLS=0;*/
/*	If dept='SPPA' then SPPA=1; Else SPPA=0;*/
/*	If dept='STAT' then STAT=1; Else STAT=0;*/
/*	If dept='SWRK' then SWRK=1; Else SWRK=0;*/
/*	If dept='THEA' then THEA=1; Else THEA=0;*/
/*	If dept='TLES' then TLES=1; Else TLES=0;*/




