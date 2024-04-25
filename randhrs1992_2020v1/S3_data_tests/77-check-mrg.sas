
/*--- Using SAS formats */

/* Create `work.formats` catalog */
proc format lib = WORK cntlin = lib._RANDfmts_long;
run;

/* Merge rlong and slong tables */

data rs;
  merge lib.rlong_table lib.slong_table;
   by hhid pn studyyr;
run;

proc sort data=rs;
  by hhid subhh studyyr;
run;

/* one to many */
data rsh;
  merge lib.hlong_table rs;
  by hhid subhh studyyr;
run;



proc sort data =rsh;
 by hhid pn studyyr;
run;

data mrg5;
 merge rsh lib.rexit_table lib.rwide_table;
  by hhid pn;
run;



