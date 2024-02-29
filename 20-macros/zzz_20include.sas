%macro zzz_20include;

%put ===> Macro `zzz_20include` STARTS here ======;
%put Macros listed below will be loaded:; 

/*-- `_20table_execute` */
%put  - macro `_20table_execute`;
%include _macros(_20table_execute);

/*-- `copy_formats_cntlin` */
%put  - macro `copy_formats_cntlin`;
%include _macros(copy_formats_cntlin);

/*-- `rename_base_longout` */
%put  - macro `rename_base_longout`;
%include _macros(rename_base_longout);

/*-- `sort_base_logout` */
%put  - macro `sort_base_logout`;
%include _macros(sort_base_logout);

%put --- Macro `zzz_20include` ENDS here ======;
%put;
%mend zzz_20include;

