%macro zzz_05include;

%put ===> Macro `zzz_05include` STARTS here ======;
%put --- Macros listed below will be loaded:; 


/*-- `create_stmnts0_data` */
%put  - macro `create_stmnts0_data`;
%include _macros(create_stmnts0_data);

/*-- `create_stmnts_data` */
%put  - macro `create_stmnts_data`;
%include _macros(create_stmnts_data);





/*-- `put_init_macro_stmnts` */
%put  - macro `put_init_macro_stmnts`;
%include _macros(put_init_macro_stmnts);



%put --- Macro `zzz_05include` ENDS here ======;
%put;
%mend zzz_05include;

