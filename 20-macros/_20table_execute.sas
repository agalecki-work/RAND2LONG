%macro _20table_execute(table, keys);

%put ====> Macro `_20table_execute` STARTS here;
/* Create `work.formats` catalog from `&formats_cntlin` */
proc format lib = WORK cntlin = &formats_cntlin ;
run;


proc datasets lib =work memtype=cat;
run;
quit;

%put -- catalog work.formats created;


/*---- Include `map_file` macros ---*/
%include map_file;

%put --- File `map_file` included ---;

/*--- Create `_template_longout` SAS dataset template for long data (with 0 observations) ----*/
%create_template_longout;

data _base_longout(label = "Table %upcase(&tbl) created from &wide_datain (datestamp: &sysdate, Table Version:= &table_version)");
  set _template_longout;
run;

/* Macro `create_outdata` creates dataset `work._base_longout` dataset */



%put ====> Macro `_20table_execute` ENDS here;

%mend _20table_execute;
