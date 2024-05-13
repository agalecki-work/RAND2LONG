%macro print_contents_dict_document;
/* Macro invoked  by `20-create-tables.sas` and tested using `21-test-contents.sas`*/

Title ; 
data _null_;
  file print;
  put "Filename `dictionaries.txt` in main subfolder" /;
  put "&project_title";
run;


title "Data tables: Overview";
data dt_summ0;
 set dt_summ;
  if memname = "_RANDFMTS_LONG" then delete;
run;

proc print data=dt_summ0;
  var  memname  nobs nvar filesize memlabel;
run;

%print_datasets(RLONG_DICT, lib =_dict, 
    var = varnum name clength format wave_summary wave_pattern label,
    title_template = Dictionary: @);

%print_datasets(HLONG_DICT, lib =_dict, 
    var = varnum name clength format wave_summary wave_pattern label,
    title_template = Dictionary: @);

%print_datasets(SLONG_DICT, lib =_dict, 
    var = varnum name clength format wave_summary wave_pattern label,
    title_template = Dictionary: @);
%print_datasets(RWIDE_DICT, lib =_dict, 
    var = varnum name clength format /* wave_summary wave_pattern */ label,
    title_template = Dictionary: @);
%print_datasets(REXIT_DICT, lib =_dict, 
    var = varnum name clength format /* wave_summary wave_pattern */ label,
    title_template = Dictionary: @);
%print_datasets(RSSI_DICT, lib =_dict, 
    var = varnum name clength format wave_summary wave_pattern label,
    title_template = Dictionary: @);


%macro SKIP;
data dt_summ0;
 set dt_summ;
  if memname in ("REXIT_TABLE", "RWIDE_TABLE") then dtset=0;
    else dtset = 1;
  if memname = "_RANDFMTS_LONG" then delete;
run;

proc sort data=dt_summ0;
by descending dtset mem_order;  *memname;
run;

proc print data=dt_summ0;
  var  memname  nobs nvar filesize memlabel;
run;



data _dt_nms_(keep=name dtset);
  set dict_summ (keep = memname);
  if memname in ("REXIT_DICT", "RWIDE_DICT") then dtset=0;
    else dtset = 1;
  rename memname=name;
run;

/*--- dt_list1 */

data _dt1;
 set _dt_nms_;
 if dtset=1;
run;

proc sql noprint;
        select name into :dt_list1 separated by ' ' from _dt1;
quit;

%put dt_list1 := &dt_list1;

%print_datasets(&dt_list1, lib =_dict, 
    var = varnum name clength format wave_summary wave_pattern label,
    title_template = Dictionary: @);

/*--- dt_list0 */    
data _dt0;
 set _dt_nms_;
 if dtset=0;
run;

proc sql noprint;
        select name into :dt_list0 separated by ' ' from _dt0;
quit;

%put dt_list0 := &dt_list0;

%print_datasets(&dt_list0, lib =_dict, 
    var = varnum name clength format /* wave_summary wave_pattern */ label,
    title_template = Dictionary: @);
%mend SKIP;


%mend print_contents_dict_document;
