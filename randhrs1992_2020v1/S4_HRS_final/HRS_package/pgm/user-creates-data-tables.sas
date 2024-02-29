
options nocenter mprint;

/* ---- DEFINE LIBRARIES */

/*--------- RAND and cntlin datasets in `LIBIN` libref    -----------*/

libname LIBIN "C:\temp" access=readonly;

%let DATAIN = randhrs1992_2020v1;
%let wide_datain = libin.&datain;
%let formats_cntlin = libin.sasfmts;
%let outdata =;

%let fcmp_src_path = FCMP_src.sas;
filename fcmp_src "&fcmp_src_path";


libname libout  "C:\tempout";
%let outdata_formats = libout.fmts_long;


%macro _create_table(table, key_vars);
%put ====> Macro `_create_table` STARTS here;

 filename map_file "./map_files/&table._map_file.inc";
 %include map_file;
 filename map_file clear; 

 %let tbl_name= &table._table;
 %let outdata = libout.&tbl_name;
 %******let outdata_formats =libout._RANDfmts_long;


/*--- Create `_template_longout` SAS dataset template (zero observations) for long data ----*/
%create_template_longout;

data _base_longout(label = "Table %upcase(&table) created from &wide_datain (datestamp: &sysdate, Table Version:= &table_version)");
  set _template_longout;
run;

%append_outtable (libin.&datain);   /* RAND data -> _base_longout */

%macro skip; 
proc sort data = _base_longout nodupkey;
by &key_vars;   
run;
%mend skip;

/* Move and rename  `_base_longout` from `work` to `libout` SAS library (rename_base_longout)*/
/* Sort respondent data by &sortby (sort_base_logout )*/
 %if %eval(%length(&key_vars) > 0) %then %do;
 proc sort data = _base_longout nodupkey;
 by &key_vars;   *Example: hhid pn wave_number;
 run;
 %end;

 
 
 /* Move and rename  `_base_longout` from `work` to `libout` SAS library */

 %put outdata= &outdata;
 %*let res = %sysfunc(tranwrd(&outdata, _data., %str()));
 %let res = %sysfunc(tranwrd(&outdata, libout., %str()));
 
 %put outdata_name := &res;
 
 proc datasets library = work nolist;
    change _base_longout = &res;
 run; 
    copy in=work out=libout memtype=data move;
    select &res;
 run;
 quit;

 

/*--- Cleanup */
proc datasets library=work;
    delete _outtable _TEMPLATE_LONGOUT;
run;

%put ====> Macro `_create_table` ENDS here;

%mend _create_table;


/* ==== Execution starts ==== */
/* ===== Create SAS formats ====== */
data _formats_cntlin;
   set &formats_cntlin; 
   row_num = _n_;
run;

proc sort data= _formats_cntlin 
          out = sorted_fmts;
by fmtname;
run;

/* `sfmts1` one row per format */
data sfmts1_init;
 set sorted_fmts;
 by fmtname;
 if first.fmtname;
run;

data sfmts1;
 set sfmts1_init;
 row_num = row_num-0.1;
 /* Numeric */
 if type ="N" then do;
    start = right(put("._", $16.));
    end   = right(put("._", $16.));
    label = "._ = Not defined for this wave ";
 end; 
 /* Character */
  if type ="C" then do;
     start = "*";
     end   = "*";
     label = "* = Variable not defined for this wave ";
  end; 

 if type in ("N", "C")  then output;
run;

proc append base = sorted_fmts
            data = sfmts1;
run;

proc sort data = sorted_fmts 
    out = &outdata_formats(drop = row_num label = "`cntlin` for &outdata (long format &sysdate)");
by row_num;
run;

  
 /* copy formats_cntlin from libin to libout */
  
 /* Create `work.formats` catalog from cntlin dataset*/
 proc format lib = WORK cntlin = &outdata_formats;
 run;
  
 proc datasets lib = work memtype=cat;
 run;
 quit;
 
 %put -- catalog work.formats created;




/* ----   FCMP_src.sas ----*/

/*--- Include FCMP source ----*/
proc fcmp outlib = work._WIDE2LONG.all; /* 3 level name */
%include fcmp_src;
run;
quit; /* FCMP */

/*---- Load FCMP functions ----*/
options cmplib = work._WIDE2LONG;



%_create_table(RLong, hhid  PN wave_number);

%_create_table(HLong, hhid  wave_number subhh descending H_PICKHH PN);
%_create_table(Rwide, hhid  PN);
%_create_table(Rexit, hhid  PN);
%_create_table(RSSI,  hhid  PN RSSI_EPISODE);

