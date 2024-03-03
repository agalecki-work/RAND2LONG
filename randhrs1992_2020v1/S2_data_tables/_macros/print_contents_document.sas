%macro print_contents_document;
/* Macro invoked  `20-create-tables.sas` and tested using `21-test-contents.sas`*/
%local tnobs tnvars;
title "RAND Longitudinal dataset organized in several tables using long format";
%let tnobs = %attrn_nlobs(&datain, libname = libin);
%let tnvars = %attrn_nvars(&datain,  libname = libin);

data _null_;
  file print;
  put "RAND Dataset (input): &DATAIN (nobs = &tnobs, nvars =&tnvars)" ;
  put "Prepared by the Design, Data and Biostistics Core";
  put "   at the University of Michigan Older American Independece Center";
  put "Release info: &table_version (&xlsx_nickname)";
  put "Date stamp: &sysdate";
run;


data dt_summ;
  set SASHELP.VTABLE;
  if libname in ('_DATA');
  keep libname memname  nobs nvar filesize memlabel;
run;


/* Variables */
data var_summ;
  set SASHELP.VCOLUMN;
  if libname ='_DATA';
  keep libname memname memtype name type length varnum label format;
run;

*proc contents data= var_summ;
run;

proc sort data =var_summ;
by memname varnum;
run;


Title "Long Tables: Overview";
proc print data=dt_summ;
var  memname  nobs nvar filesize memlabel;
run;

Title "Variable attributes";
proc print data=var_summ noobs;
var varnum /*libname*/ memname /* memtype*/ name type length format label; * name label; 
by memname;
run;

%mend print_contents_document;
