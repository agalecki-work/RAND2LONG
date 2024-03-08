%macro print_readme_dict_document;
/* Macro invoked  `20-create-tables.sas` and tested using `21-test-contents.sas`*/


%local tnobs tnvars;
%let tnobs = %attrn_nlobs(&datain, libname = libin);
%let tnvars = %attrn_nvars(&datain,  libname = libin);

%let rand_fmts = %scan(&formats_cntlin, 2,.); 
%let tnobs1 = %attrn_nlobs(&rand_fmts, libname = libin);
%let tnvars1 = %attrn_nvars(&rand_fmts,  libname = libin);
Title; 
data _null_;
  file print;
  put "Filename: `README.txt` in `./dictionaries` subfolder" /;
  put "&project_title";
run;

title "Dictionaries for datasets stored in `./long tables` subfolder : Overview";
Title2 "More info is available in `_DETAILS.txt` file";
proc print data=dict_summ;
  var  memname  nobs nvar /*filesize*/ memlabel;
run;


%mend print_readme_dict_document;
