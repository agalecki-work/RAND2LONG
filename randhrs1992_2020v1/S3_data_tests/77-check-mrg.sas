options ls = 150;

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

data out.mrg5_tables;
 merge rsh lib.rexit_table lib.rwide_table;
  by hhid pn;
run;


proc print data=out.mrg5_tables(obs=2500);
run;


