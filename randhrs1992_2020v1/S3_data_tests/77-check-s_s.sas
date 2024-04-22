/* Do not run */

%let data = rlong_table;

%let grp = HHID WAVE_NUMBER subhh;

/* --- Code works without using SAS formats */
options nofmterr nocenter;

proc contents data =lib.&data out=cont(keep =varnum name type label) noprint;
run;


proc sort data= lib.&data out=dt;
by &grp;
run;

/* wave #3 omitted */
data dt;
 set dt;
 if wave_number=3 then delete;
run;



proc summary data = dt min max noprint;
var _numeric_;
by &grp;
output out = _summ; * (keep = &grp _TYPE_ _FREQ_ _STAT_;
run;

proc contents data = _summ position;
run;



proc transpose data=_summ out =_tsumm;
id _stat_;
by &grp;
run;

data _tsumm2d (rename = (_name_= name));
 set _tsumm;
 rnge = max- min; 
 if min ne max;
run;


proc print data= _tsumm2d  (obs=50);
run;

proc sort data = _tsumm2d nodupkey;
by name &grp;
run;

proc print data= _tsumm2d  (obs=50);
run;

proc sort data = _tsumm2d nodupkey;
by name ;
run;

proc sort data= cont;
by name;
run;

data mrg; 
 merge cont _tsumm2d(in =in2);
 by name;
 tmp1 = 1- in2;
 if type = 2 then tmp1=.;
 subhh_var =tmp1;
run;

proc sort data = mrg;
by varnum;
run;

Title "subhh_var=1 indicates a candidate for a subhousehold level variable";

proc print data= mrg;
var varnum name type  subhh_var label;
run;




