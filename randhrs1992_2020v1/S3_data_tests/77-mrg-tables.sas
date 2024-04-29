options ls = 150 nocenter;

/*--- Using SAS formats */

/* Create `work.formats` catalog */
proc format lib = WORK cntlin = lib._RANDfmts_long;
run;

data rsh;
 merge lib.rlong_table lib.slong_table lib.hlong_table ;
    by hhid pn studyyr;
run;

data out.mrg5_tables;
 merge rsh lib.rexit_table lib.rwide_table;
  by hhid pn;
run;

proc contents data =  out.mrg5_tables position;
run;


proc print data=out.mrg5_tables(obs=500);
var  hhid pn studyyr S_HHIDPN R_BPPULS H_IFIRAW H_INPOVAD S_ACGTOT READL5H RABDATE INW_SUMMARY;
format _all_; /* Formats ignored */
format RABDATE  mmddyy8.;
run;


