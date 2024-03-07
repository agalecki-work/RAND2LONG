%macro prep_aux_data2print;
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
filename fx "&xpath/README.&extn";
proc printto print= fx new;
run;


title "Filename: README.txt located in the main folder";
title2 "File created on &sysdate";
%print_README_main_document;

proc printto;
run;
filename fx clear;


/*--- README_tables file -----*/
filename fx "&xpath/tables_long/README.&extn";
proc printto print= fx new;
run;


title "Filename: README.txt in `./tables_long` subfolder";

%print_README_tables_document;

proc printto;
run;
filename fx clear;

/*--- README_dict file -----*/
filename fx "&xpath/dictionaries/README.&extn";
proc printto print= fx new;
run;


title "Filename: README.txt in `./dictionaries` subfolder";

%print_README_dict_document;

proc printto;
run;
filename fx clear;


/*--- README_contents_tables file -----*/
filename fx "&xpath/tables_long/CONTENTS.&extn";
proc printto print= fx new;
run;


** title "Filename: CONTENTS.txt in `./tables_long` subfolder";
title;
%print_contents_tables_document;

proc printto;
run;
filename fx clear;




%mend prep_aux_data2print;

