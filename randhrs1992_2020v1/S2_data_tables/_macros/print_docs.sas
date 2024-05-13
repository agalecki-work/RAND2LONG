%macro mem_order;
  tt = .;
  select(memname);
   when("HLONG_TABLE")  tt=2;
   when("RLONG_TABLE")  tt=1;
   when("RSSI_TABLE")   tt=6;
   when("SLONG_TABLE")  tt=3; 
   when("REXIT_TABLE")  tt=5; 
   when("RWIDE_TABLE")  tt=4;
   otherwise tt=99;
  end; 
  mem_order =tt;
  drop tt;
%mend mem_order;


%macro print_docs;
/* Auxiliary macro creates summary datasets used by `print` macros */ 



data dt_summ;
  set SASHELP.VTABLE;
  %mem_order;

  if libname in ('_DATA');
  keep libname memname mem_order nobs nvar filesize memlabel;
run;

proc sort data=dt_summ;
 by mem_order;
run;

Title "--- XYZ";
proc print data =dt_summ;
run;

data dict_summ;
  set SASHELP.VTABLE;
  if libname in ('_DICT');
  %mem_order;
  keep libname memname mem_order nobs nvar filesize memlabel;
run;

proc sort data=dict_summ;
 by mem_order;
run;

/* Variables */
data var_summ;
  set SASHELP.VCOLUMN;
  if libname ='_DATA';
  %mem_order;
  keep libname memname mem_order memtype name type length varnum label format;
run;

proc sort data =var_summ;
by mem_order varnum;
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


/*--- README_tables file in data_table subfolder -----*/
filename fx "&xpath/data_tables/_README.&extn";
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

