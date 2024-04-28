options ls = 150;

/*--- Using SAS formats */

/* Create `work.formats` catalog */
proc format lib = WORK cntlin = lib._RANDfmts_long;
run;


data rs;
 merge lib.rlong_table lib.slong_table;
    by hhid pn studyyr;
run;


/*--- Prep for merging with hlong_table ---*/

proc sort data=rs;
  by h_hhidc subhh studyyr; /* hhidc */
run;

proc sort data= lib.hlong_table out = hlong_table;
  by h_hhidc subhh studyyr; /* hhidc */
run;
 
/* RLONG, SLONG and HLONG merged (one to many) */
data rsh;
  merge hlong_table rs;
  by h_hhidc subhh studyyr; /* hhidc */
run;

/* Prepare to merge with REXIT and RWIDE tables */
proc sort data =rsh;
 by hhid pn studyyr;
run;

data out.mrg5_tables;
 merge rsh lib.rexit_table lib.rwide_table;
  by hhid pn;
run;

proc contents data =  out.mrg5_tables position;
run;


proc print data=out.mrg5_tables(obs=500);
var  hhid pn  H2IFIRAW H2INPOVAD;
format _all_; /* Formats ignored */
run;


