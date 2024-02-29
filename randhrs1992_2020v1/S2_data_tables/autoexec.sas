%put :=== autoexec.sas (local) STARTS;
filename _auto "..\autoexec.sas";
%include _auto;
filename _auto clear;


filename prj_auto "..\_project_auto.inc";
%include prj_auto;
filename prj_auto clear;


/* Path to current directory */
%let dir_name = S2_data_tables;    /* !!! */
%let dir_path= &prj_path\&dir_name;

%put :=== autoexec.sas in subdirectory `&dir_name` ENDS;




