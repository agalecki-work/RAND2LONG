options mprint;
filename _auto1 "..\autoexec.sas";
%include _auto1;

libname libmain "C:\temp";           
libname lib "C:\tempout\HRS_package\data_tables";
libname out "C:\tempout"; 
%let dir_name = S3_data_tests;
%let dir_path =&prj_path\&dir_name;





