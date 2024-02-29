%put ===> `_project_auto.inc` STARTS;

/* Define fileref `fcmp_src` with a path to FCMP functions source */

%let fcmp_src_path = &repo_path\&prj_name\usource\FCMP_src.sas;
filename fcmp_src "&fcmp_src_path";

/*--- Include FCMP source ----*/
proc fcmp outlib = work._WIDE2LONG.all; /* 3 level name */
%include fcmp_src;
run;
quit; /* FCMP */

/*---- Load FCMP functions ----*/
options cmplib = work._WIDE2LONG;

/* ------ Load project macros ----*/
/* ===== Macro `_project_setup` loaded  ===== */;

filename _setup "&prj_path";
%include _setup(_project_setup);
filename _setup clear;

filename _macros "&repo_path\_util_macros";
%include _macros(zzz_utils_include);
%zzz_utils_include;
filename _macros clear;


filename _macros "&repo_path\05-macros";
%include _macros(zzz_05include);
%zzz_05include;
filename _macros clear;


filename _macros "&repo_path\20-macros";
%include _macros(zzz_20include);
%zzz_20include;
filename _macros clear;

%put ---- `_project_auto.inc` ENDS;
%put; 
