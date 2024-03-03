
options mprint;

/* ==== Execution starts ==== */
%_project_setup;

libname _data "&HRSpkg_path/tables_long";

filename _macros "&dir_path/_macros"; /* Local macros */
%include _macros(zzz_include);
filename _macros clear;
%zzz_include;


/* ===  Contents document ====*/


options nocenter ls =255 formdlim=' ';
%print_contents_document;







