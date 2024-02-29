
%let data = Rwide_table;

/* --- Code works without using SAS formats */
options nofmterr nocenter;
Title "Table: &data.. PROC CONTENTS for &data";
proc contents data=lib.&data out= contents(keep= memname varnum name type format label nobs) noprint;
run;

proc sort data=contents;
by varnum;
run;

Title2 "Table: &data.. Contents Part 1/2";
proc print data=contents;
var varnum name label;
run;

Title2 "Table: &data.. Contents Part 2/2";
proc print data=contents;
var varnum name type format nobs;;
run;

proc means data=lib.&data n nmiss mean stddev min max maxdec=2 nolabels;
var _numeric_;
run;


Title "Table &data.. Selected vars (n=50)";
proc print data = lib.&data(obs=50);
var  HHID PN HHIDPN HACOHORT /*RABPLACF*/;
run;


Title "Table: &data.. ";
proc freq data = lib.&data;
table RAVETRN /missing nopercent norow nocol;
run;

Title "Table: &data.. PROC FREQ without SAS formats";
Title2 "All missing data categories listed";
proc freq data = lib.&data;
tables RAVETRN /missing; 
run;

Title2 "Table: &data.. All missing values combined";
proc freq data = lib.&data;
tables RAVETRN; 

run;
