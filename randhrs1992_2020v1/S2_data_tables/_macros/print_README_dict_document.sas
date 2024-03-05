%macro print_readme_dict_document;
/* Macro invoked  `20-create-tables.sas` and tested using `21-test-contents.sas`*/
%local tnobs tnvars;
%let tnobs = %attrn_nlobs(&datain, libname = libin);
%let tnvars = %attrn_nvars(&datain,  libname = libin);

%let rand_fmts = %scan(&formats_cntlin, 2,.); 
%let tnobs1 = %attrn_nlobs(&rand_fmts, libname = libin);
%let tnvars1 = %attrn_nvars(&rand_fmts,  libname = libin);

data _null_;
  file print;
  put;
  put "Input datasets (available through HRS website https://hrs.isr.umich.edu/data-products)";
  put "  RAND Dataset (input): &DATAIN (nobs = &tnobs, nvars =&tnvars)" ;
  put "  RAND CNTLIN dataset with formats info: &rand_fmts (nobs = &tnobs1, nvars =&tnvars1)";
  put;
  put "Release info: &table_version (&xlsx_nickname)";
  put "Date stamp: &sysdate";
  put;
  put "Tables were provided by the the Design, Data and Biostistics Core";
  put "   part of the University of Michigan Claude D. Pepper Older Americans Independece Center";
run;

*proc contents data=SASHELP.VTABLE;
run;


data dt_summ;
  set SASHELP.VTABLE;
  if libname in ('_DATA');
  keep libname memname  nobs nvar filesize memlabel;
run;

title "Long tables: Overview";
proc print data=dt_summ;
  var libname memname  nobs nvar filesize sortname memlabel;
run;



/* Variables */
data var_summ;
  set SASHELP.VCOLUMN;
  if libname ='_DATA';
  keep libname memname memtype name type length varnum label format;
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

%mend print_readme_dict_document;
