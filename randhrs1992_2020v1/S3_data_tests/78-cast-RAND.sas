* April 2024, WIP */
options ls = 150;

/*--- Using SAS formats */

/* Create `work.formats` catalog */
proc format lib = WORK cntlin = lib._RANDfmts_long;
run;


/* Reconstruct RAND data */
proc transpose data=out.mrg5_tables out=moltenData name=vLabel;
   by hhid pn wave_number;
   var H_ABOND H_AIRA R_YR R2_EAT R1_EAT R_EAT; * _numeric_; 
run;

proc print data=

/* Construct vname variable */

data molten2;
  set moltenData;
  length cx $2;
  length cpart2 $ 31;
  length vname $32;
  vname = vLabel;
  cx = strip(put(wave_number, 8.)); /* wave number */
  c1 = substr(vLabel,1,1);
  c2 = substr(vLabel,2,1);
  cpart2 = scan(vLabel, 2, "_"); /* part2 */
  if substr(vlabel, 2, 1) = "_"  then vname = strip(c1) ||cx || strip(cpart2);
  
  
  
  if substr(vlabel, 2, 2) = "1_" and wave_number = 1 then vname = strip(c1) ||"1" || strip(cpart2);
  if substr(vlabel, 2, 2) = "2_" and wave_number = 2 then vname = strip(c1) ||"2" || strip(cpart2);
  vname =compress(vname);
  if vlabel= "H_HHID" then vname = "H_HHID";
  drop ix cx c1 c2; 
run;

proc sort data = molten2 out= out.molten2s;
  by hhid pn wave_number vname;
run;

proc print data=out.molten2s (obs= 2000);
run;

proc transpose data=out.molten2s out=out.wide; *(drop=_name_);
by hhid pn wave_number;

var col1;
run;

proc print data=out.wide;
run;
