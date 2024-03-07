%macro print_contents_tables_document;
/* Macro invoked  by `20-create-tables.sas` and tested using `21-test-contents.sas`*/

data _null_;
  file print;
  put "Filename CONTENTS.txt in `tables_long` subfolder";
run;


title "Long tables: Overview";
proc print data=dt_summ;
  var  memname  nobs nvar filesize memlabel;
run;

options nobyline;
Title "Variable attributes for #byline";
proc print data=var_summ noobs;
var varnum /*libname*/ memname /* memtype*/ name type length format label; * name label; 
by memname;
run;

options byline;
%mend print_contents_tables_document;
