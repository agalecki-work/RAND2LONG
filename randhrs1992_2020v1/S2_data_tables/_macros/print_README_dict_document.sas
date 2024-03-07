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
  put; *Filename: README.txt in `./dictionaries` subfolder;
%macro skip;
  put "Input datasets (available through HRS website https://hrs.isr.umich.edu/data-products)";
  put "  RAND Dataset (input): &DATAIN (nobs = &tnobs, nvars =&tnvars)" ;
  put "  RAND CNTLIN dataset with formats info: &rand_fmts (nobs = &tnobs1, nvars =&tnvars1)";
  put;
  put "Release info: &table_version (&xlsx_nickname)";
  put "Date stamp: &sysdate";
  put;
  put "Tables were provided by the the Design, Data and Biostistics Core";
  put "   part of the University of Michigan Claude D. Pepper Older Americans Independece Center";
%mend skip;
run;


title "Dictionaries for datasets stored in `./long tables` subfolder : Overview";
proc print data=dict_summ;
  var  memname  nobs nvar /*filesize memlabel*/;
run;



%mend print_readme_dict_document;
