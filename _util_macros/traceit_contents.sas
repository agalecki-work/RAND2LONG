%macro traceit_contents(member, libname =work, obs=50, vars = varnum memname name type length format nobs label);

%local dtnm dtnm0 _nobs txt;
%let dtnm = &libname..&member;
%let dtnm0 =%lowcase(&dtnm);
%let dtnm0 = %sysfunc(tranwrd(&dtnm0, work., %str()));

proc contents data= &dtnm out=_tmp_contents noprint;
run;

proc sort data= _tmp_contents;
by varnum;
run;

/* Prep for proc print */
%let _nobs = %attrn_nlobs(_tmp_contents);
%let txt =(nvars = &obs/&_nobs);
%if %eval(&obs ge &_nobs) %then %let txt =;  
Title "CONTENTS Data: &dtnm0. &txt";
ods proclabel = "&dtnm0 (nvars= &_nobs)";
proc print data = _tmp_contents(obs =&obs) contents = "-- contents traceit";
%if &vars ne %then
  var &vars;;
run;


%mend traceit_contents;
