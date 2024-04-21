

%let data = Rwide_table;

/*--- Using SAS formats */

/* Create `work.formats` catalog */
proc format lib = WORK cntlin = lib._RANDfmts_long;
run;



Title "Table: &data.. Selected vars (n=50)";
proc print data = lib.&data(obs=50);
var  HHID PN HACOHORT INW_SUMMARY;
run;



Title "Table: &data.. PROC FREQ";
proc freq data = lib.&data;
table RAVETRN /missing nopercent norow nocol;
run;

Title "Table: &data.. PROC FREQ with SAS formats";
Title2 "All missing data categories included";
proc freq data = lib.&data;
tables RAVETRN/ missing; 
run;

Title2 "Table: &data.. All missing values combined";
proc freq data = lib.&data;
tables RAVETRN; 

run;






