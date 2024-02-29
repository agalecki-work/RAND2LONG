%macro traceit_print(member, libname =work, obs=20, vars =);
%local dtnm dtnm0 _nobs txt;
%let dtnm = &libname..&member;
%let dtnm0 =%lowcase(&dtnm);
%let dtnm0 = %sysfunc(tranwrd(&dtnm0, work., %str()));



/* Prep for proc print */
%let _nobs = %attrn_nlobs(&member, libname = &libname);
%let txt =(nobs = &obs/&_nobs);
%if %eval(&obs ge &_nobs) %then %let txt =;  

Title "PRINT Data: &dtnm0. &txt ";
ods proclabel = "&dtnm0 (n= &_nobs)";
proc print data = &dtnm0(obs =&obs) contents = "-- print traceit";
%if &vars ne %then
  var &vars;;
run;
%mend traceit_print;