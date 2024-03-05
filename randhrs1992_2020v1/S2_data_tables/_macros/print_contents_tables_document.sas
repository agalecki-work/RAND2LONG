%macro print_contents_tables_document;
/* Macro invoked  by `20-create-tables.sas` and tested using `21-test-contents.sas`*/


*proc contents data=SASHELP.VTABLE;
run;


data dt_summ;
  set SASHELP.VTABLE;
  if libname in ('_DATA');
  keep libname memname  nobs nvar filesize memlabel;
run;

title "Long tables: Overview";
proc print data=dt_summ;
  var libname memname  nobs nvar filesize memlabel;
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


Title "Variable attributes";
proc print data=var_summ noobs;
var varnum /*libname*/ memname /* memtype*/ name type length format label; * name label; 
by memname;
run;

%mend print_contents_tables_document;
