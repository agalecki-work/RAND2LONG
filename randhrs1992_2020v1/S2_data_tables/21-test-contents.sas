
options mprint;

/* ==== Execution starts ==== */
%_project_setup;

libname _data "&HRSpkg_path/tables_long";

filename _macros "&dir_path/_macros"; /* Local macros */
%include _macros(zzz_include);
filename _macros clear;
%zzz_include;



/* ===  Contents documents ====*/

options nocenter ls =255 formdlim=' ';


/*--- README_MAIN file -----*/
filename fx "21-test_README_main.log";
proc printto print= fx new;
run;


title "Filename: README_main.txt (created on: &sysdate)";

%print_README_main_document;

proc printto;
run;
filename fx clear;

/*--- README_tables file -----*/
filename fx "21-test_README_tables.log";
proc printto print= fx new;
run;


title "Filename: README.txt in `./tables_long` subfolder";

%print_README_tables_document;

proc printto;
run;
filename fx clear;

/*--- README_contents_tables file -----*/
filename fx "21-test_contents_tables.log";
proc printto print= fx new;
run;


title "Filename: TABLES_CONTENTS.txt in `./tables_long` subfolder";

%print_contents_tables_document;

proc printto;
run;
filename fx clear;


endsas;


/*--- Contents  file -----*/
filename f2 "21-test_README2.txt";
proc printto print= f2 new;
run;

title "Title: RAND Longitudinal dataset stored using several tables in a long format";
%print_readme_document;
++%print_contents_document;

proc printto;
run;
