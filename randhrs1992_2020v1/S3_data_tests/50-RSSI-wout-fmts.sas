
/*  Dataset name */
%let data = RSSI_table;



/* --- Code works without using SAS formats */
options nofmterr nocenter;
Title "PROC CONTENTS for &data";
proc contents data=lib.&data out= contents(keep= memname varnum name type format label nobs) noprint;
run;

proc sort data=contents;
by varnum;
run;

Title2 "Contents Part 1/2";
proc print data=contents;
var varnum name label;
run;

Title2 "Contents Part 2/2";
proc print data=contents;
var varnum name type format nobs;;
run;

Title "Number of rows (episodes) per respondent";
proc freq data = lib.&data;
table RSSI_episode /nopercent norow nocol;
run;


Title "Descriptive statistics for all SSI episodes combined";
proc means data = lib.&data n nmiss mean stddev min max nolabels maxdec=2;
var _numeric_;
run;

%macro skip;
Title "Table: &data. Selected HHIDs for all waves";
proc print data = lib.&data;
var  HHID WAVE_NUMBER H_HHIDC h_hhid PN STUDYYR INW HACOHORT H_OHRSHH H_PICKHH H_ITOT2 H_ATOTB H_CHILD H_HHRESP;
 where hhid in  ('010533','500121', '208867');
run;



Title "PROC FREQ without SAS formats";
Title2 "All missing data categories listed";
proc freq data = lib.&data;
 
tables H_PICKHH / missing; 
tables H_AFNETHB / missing; 


run;

Title2 "All missing data combined";
proc freq data = lib.&data;
tables H_PICKHH; 

run;
%mend skip;