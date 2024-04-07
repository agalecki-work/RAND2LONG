%macro print_docs;
/* Auxiliary macro creates summary datasets used by `print` macros */ 

data dt_summ;
  set SASHELP.VTABLE;
  if libname in ('_DATA');
  keep libname memname  nobs nvar filesize memlabel;
run;

data dict_summ;
  set SASHELP.VTABLE;
  if libname in ('_DICT');
  keep libname memname  nobs nvar filesize memlabel;
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

/*================*/
/*--- README_MAIN file -----*/
filename fx "&xpath/_README.&extn";
proc printto print= fx new;
run;


title  "&project_title";

%print_README_main_document;

proc printto;
run;
filename fx clear;


/*--- README_tables file in table_long subfolder -----*/
filename fx "&xpath/tables_long/_README.&extn";
proc printto print= fx new;
run;


%print_README_tables_document;

proc printto;
run;
filename fx clear;

/*--- README_dict file in `./dictionaries` subfolder-----*/

%macro skip;
filename fx "&xpath/dictionaries/_README.&extn";
proc printto print= fx new;
run;
%print_README_dict_document;

proc printto;
run;
filename fx clear;
%mend skip;

%macro skip;
/*--- _contents file in `/tables_long` subfolder -----*/
filename fx "&xpath/tables_long/_CONTENTS.&extn";
proc printto print= fx new;
run;
%print_contents_tables_document;

proc printto;
run;
filename fx clear;
%mend skip;

/*--- _details file in `/_dictionaries` file -----*/
filename fx "&xpath/dictionaries.&extn";
proc printto print= fx new;
run;
%print_contents_dict_document;

proc printto;
run;
filename fx clear;
%mend print_docs;

