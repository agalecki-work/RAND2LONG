
options nocenter mprint;

libname _data  "&prj_path\&dir_name\data";

filename _macros "&repo_path\20-macros";
%include _macros(zzz_20include);
filename _macros clear;



%macro _20create_table(table, key_vars);
%put ====> Macro `_20create_table` STARTS here;

 filename map_file "&prj_path\&dir_name\map_files\&table._map_file.inc";
 %include map_file;
 filename map_file clear; 

 %let tbl_name= &table._table;
 %let outdata = _data.&tbl_name;
 %let outdata_formats =_data._RANDfmts_long;
 %****zzz_20main_execute;
 
  
 /* copy formats_cntlin from libin to libout */
  
  %copy_formats_cntlin;

 /* Create `work.formats` catalog from cntlin dataset*/
 proc format lib = WORK cntlin = &outdata_formats;
 run;
  
 proc datasets lib = work memtype=cat;
 run;
 quit;


 %put -- catalog work.formats created;
/*--- Create `_template_longout` SAS dataset template (zero observations) for long data ----*/
%create_template_longout;

data _base_longout(label = "Table %upcase(&table) created from &wide_datain (datestamp: &sysdate, Table Version:= &table_version)");
  set _template_longout;
run;

%append_outtable (libin.&datain);   /* RAND data -> _base_longout */
 %put ====> Macro `_20create_table` ENDS here;
 
proc sort data = _base_longout nodupkey;
by &key_vars;   
run;

/* Move and rename  `_base_longout` from `work` to `libout` SAS library */
 %rename_base_longout;

/*--- Cleanup */
proc datasets library=work;
    delete _outtable _TEMPLATE_LONGOUT;
run;

%mend _20create_table;


/* Execution starts */
%_project_setup;



%_20create_table(RLong, hhid  PN wave_number);

%*macro skip;
%_20create_table(HLong, hhid  wave_number subhh descending H_PICKHH PN);
%_20create_table(Rwide, hhid  PN);
%_20create_table(Rexit, hhid  PN);
%*mend  skip;

%_20create_table(RSSI,  hhid  PN RSSI_EPISODE);
