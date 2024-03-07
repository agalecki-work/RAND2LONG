
options mprint;

/* ==== Execution starts ==== */
%_project_setup;

libname _data "&HRSpkg_path/tables_long";
libname _dict "&HRSpkg_path/dictionaries";

filename _macros "&dir_path/_macros"; /* Local macros */
%include _macros(zzz_include);
filename _macros clear;
%zzz_include;



/* ===  Contents documents ====*/


options nocenter ls =255 formdlim=' ';

%let xpath = &dir_path/21-tests;
%let extn =log;

%prep_aux_data2print;

