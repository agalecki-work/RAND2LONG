%macro _project_setup;
/* Macro vars `repo_name`, `repo_path`, `prj_name`, `dir_name` defined in `_project_auto.inc` */
%put ===> `_project_setup` macro STARTS here;

/* Declare global macro variables */
%global repo_path repo_name prj_name dir_name;
%global xlsx_path xlsx_name dir_path table_version;
%global datain formats_cntlin wide_datain;
%global fcmp_src_path;
%global HRSpkg_path;

%let HRSpkg_path=C:\tempout\HRS_package;

%let prj_path = &repo_path\&prj_name;

/*------ Excel file multiple maps ------*/
%let xlsx_nickname = test3_maps;   /* */
%let xlsx_date =25JAN2024;
%let xlsx_path = C:\temp;
%let xlsx_name =&xlsx_nickname&xlsx_date;   
%let table_version = &repo_version-&xlsx_date;


/*--------- RAND and cntlin datasets in `LIBIN` libref    -----------*/

libname LIBIN "C:\temp" access=readonly;

%let DATAIN = randhrs1992_2020v1;
%let wide_datain = libin.&datain;
%let formats_cntlin = libin.sasfmts;


%put --- Global macro vars defined in `project_setup.inc`;
%put repo_version    := &repo_version;
%put repo_path       := &repo_path;
%put HRSpkg_path     := &HRSpkg_path;
%put prj_name        := &prj_name;
%put;

%put xlsx_nickname   := &xlsx_nickname;
%put xlsx_date       := &xlsx_date;
%put xlsx_name       := &xlsx_name;
%put xlsx_path       := &xlsx_path;
%put xlsx_name       := &xlsx_name;
%put table_version   := &table_version;
%put; 
%put libin_path      := %sysfunc(pathname(libin,L));
%put DATAIN          := &datain;
%put formats_cntlin  := &formats_cntlin;
%put fcmp_src_path   := &fcmp_src_path;
%put --- `project_setup` macro ENDS here`;
%put; 
%mend _project_setup;






