

%let data = Rexit_table;


/*--- Using SAS formats */

/* Create `work.formats` catalog */
proc format lib = WORK cntlin = lib._RANDfmts_long;
run;


Title "Table `&data`. PROC FREQ with SAS formats";
Title2 "All missing data categories listed";
proc freq data = lib.&data;
 table hacohort /missing;
 table REBATHH /missing;
run;

Title "Table `&data`. PROC FREQ";
Title2 "All missing data combined";
proc freq data = lib.&data;
table hacohort; * /nopercent norow nocol;
table REBATHH;
run;


