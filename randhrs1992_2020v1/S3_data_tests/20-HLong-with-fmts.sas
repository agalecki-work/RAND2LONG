
%let data = Hlong_table;

/*--- Using SAS formats */

/* Create `work.formats` catalog from cntlin dataset*/
proc format lib = WORK cntlin = lib._randfmts_long;
run;



Title "Table: &data.. Selected HHIDs.";
proc print data = lib.&data;
var  HHID WAVE_NUMBER H_HHIDC  h_hhid  STUDYYR  H_ITOT2 H_HHRESP H_CHILD;
 where hhid in  ('010533','500121', '208867');
run;


Title "Table: &data..Number of rows (subhh) per study yesr";
proc freq data = lib.&data;
table studyyr;
run;

Title "Table: &data.. PROC FREQ with SAS formats";
Title2 "All missing data categories included";
proc freq data = lib.&data;
tables H_CHILD / missing; 
tables H_CPL / missing; 

run;

Title2 "Table: &data.. All missing values combined";
proc freq data = lib.&data;
tables H_CHILD; 

run;






