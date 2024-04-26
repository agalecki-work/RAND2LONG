options ls = 150;

/*--- Using SAS formats */

/* Create `work.formats` catalog */
proc format lib = WORK cntlin = lib._RANDfmts_long;
run;


/* Reconstruct RAND data */
proc transpose data=out.mrg5_tables out=moltenData name=vLabel;
   by hhid pn wave_number;
   var H_ABOND H_AIRA R_YR R2_EAT R1_EAT; * _numeric_; 
run;

/* Construct vname variable */

data molten2;
  set moltenData;
  length cx $2;
  length cpart2 $ 31;
  length vname $32;
  vname = vLabel;
  cx = strip(put(wave_number, 8.)); /* wave number */
  c1 = substr(vLabel,1,1);
  c2 = substr(vLabel,1,1);
  cpart2 = scan(vLabel, 2, "_"); /* part2 */
  
  if substr(vlabel, 2, 1) = "_"  then vname = strip(c1) ||c2 || strip(cpart2);
  
  ix =0;
  
  if substr(vlabel, 2, 2) = "1_"  then ix+1;
  if substr(vlabel, 2, 2) = "2_"  then ix+1;
  if ix>0 then vname = strip(c1) ||c2 || strip(cpart2);
  vname =compress(vname);
  if vlabel= "H_HHID" then vname = "H_HHID";
  drop ix cx c1 c2; 
run;

proc print data=molten2 (obs= 2000);
run;


proc sort data = molten2 out= out.molten2s;
by hhid pn wave_number vname;
run;

proc transpose data=out.molten2s out=wide(drop=_name_);
by hhid pn wave_number;
id vname;
var col1;
run;

proc print data=wide;
run;
