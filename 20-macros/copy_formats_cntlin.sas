%macro copy_formats_cntlin;

data _formats_cntlin;
   set &formats_cntlin; 
   row_num = _n_;
run;


proc sort data= _formats_cntlin 
          out = sorted_fmts;
by fmtname;
run;

/* `sfmts1` one row per format */
data sfmts1_init;
 set sorted_fmts;
 by fmtname;
 if first.fmtname;
run;

data sfmts1;
 set sfmts1_init;
 row_num = row_num-0.1;
 /* Numeric */
 if type ="N" then do;
    start = right(put("._", $16.));
    end   = right(put("._", $16.));
    label = "._ = Not defined for this wave ";
 end; 
  if type ="C" then do;
     start = "*";
     end   = "*";
     label = "* = Variable not defined for this wave ";
  end; 

 if type in ("N", "C")  then output;
run;

proc append base = sorted_fmts
            data = sfmts1;
run;

proc sort data = sorted_fmts 
    out = &outdata_formats(drop = row_num label = "`cntlin` for &outdata (long format &sysdate)");
by row_num;
run;


%mend copy_formats_cntlin;
