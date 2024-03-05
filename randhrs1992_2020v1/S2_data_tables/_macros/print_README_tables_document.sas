%macro print_readme_tables_document;
%print_init_document;
dara _null_;
  put "INPUT: Datasets (not included, available at HRS website https://hrs.isr.umich.edu/data-products)";
  put "  RAND Dataset (input): &DATAIN (nobs = &tnobs, nvars =&tnvars)" ;
  put "  RAND CNTLIN dataset with formats info: &rand_fmts (nobs = &tnobs1, nvars =&tnvars1)";
  put;
run;


data dt_summ;
  set SASHELP.VTABLE;
  if libname in ('_DATA');
  keep libname memname  nobs nvar filesize memlabel;
run;

title "Long tables (output): Overview";
proc print data=dt_summ;
  var libname memname  nobs nvar filesize memlabel;
run;


%mend print_readme_tables_document;
