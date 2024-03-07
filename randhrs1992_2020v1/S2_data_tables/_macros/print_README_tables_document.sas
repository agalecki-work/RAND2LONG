%macro print_readme_tables_document;
%let tnobs = %attrn_nlobs(&datain, libname = libin);
%let tnvars = %attrn_nvars(&datain,  libname = libin);

%let rand_fmts = %scan(&formats_cntlin, 2,.);
%let tnobs1 = %attrn_nlobs(&rand_fmts, libname = libin);
%let tnvars1 = %attrn_nvars(&rand_fmts,  libname = libin);


data _null_;
  file print;
  put / "Datasets used as input are available at HRS website https://hrs.isr.umich.edu/data-products";
  put "  - RAND Dataset: %upcase(&DATAIN) (nobs = &tnobs, nvars = &tnvars)" ;
  put "  - RAND CNTLIN dataset with formats info: &rand_fmts (nobs = &tnobs1, nvars =&tnvars1)";
  put;
run;

title "Long tables (output): Overview";
proc print data=dt_summ;
  var memname  nobs nvar filesize memlabel;
run;

title;
data _null_;
 file print;
 put "For more details about the contents of the created tables see `CONTENTS.txt`  file";
run;

%mend print_readme_tables_document;