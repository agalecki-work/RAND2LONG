%macro put_init_macro_stmnts;
/*--- Label statements ---*/

%let n_vout = %attrn_nlobs(_dictionary);

data _null_;
  file map_file mod ;
  set _dictionary end = eof;
   if _n_=1 then do;
     /* Generate label statements*/
     put '%macro label_statements;';
     put "/* Table &table: Label statements for &n_vout variables */";
     put "/* Macro invoked by `create_template_longout` macro */";
   end;
    if mod(varnum, 10) = 0 then 
     put / @2 "/* --Variable " name ": # _" varnum "*/";  
    put @3  'label ' name ' = "' label +(-1) '";';
   if eof then put '%mend label_statements;';
run;


/* clength_statements */

data _null_;
  file map_file mod ;
     put /;
     put '%macro clength_statements;';
     put "/*  Table &table: Length statements for character and selected numeric vars */";
     put "/* Macro invoked by `create_template_longout` macro */";
run;


data _null_;
  file map_file mod ;
  set _dictionary;
   if clength ne "" then do;
     put @3 'length ' name clength +(-1) ";"  @45 "/* _" varnum "*/";
   end;
 run;

data _null_;
  file map_file mod ;
   put '%mend clength_statements;';
   put /;
run;


/*--- Format statements ---*/

data _fmts;
  set _dictionary(keep=name format varnum);
  if format ="" then delete;
run;

%let nfmts = %attrn_nlobs(_fmts);

data _null_;
  file map_file mod ;
     /* Generate format_statements macro*/
     put / '%macro format_statements;';
     put "/*  Table &table: format statements for &nfmts variables */";
     put "/* Macro invoked by `create_template_longout` macro */";
run;

data _null_;
  file map_file mod ;
  set _fmts  ;
    put @3  'format ' name  format +(-1) ';' @45 "/* _" varnum "*/" ;
run;

data _null_;
  file map_file mod ;
  put '%mend format_statements;';   
  put /;
run;

/* Readvar1_list */

data _null_;
  file map_file mod ;
  put / '%macro readvar1_list;'; 
  put "/* List of variables to be read from input dataset */";
run;

%if %upcase(&table) = RWIDE %then %do;
 data _null_;
  file map_file mod ;
  put '_ALL_';
 run;
 %end;
%else
  %do;

data _null_;
  file map_file mod ;
  set _dictionary;
  if varin =1 then put @3 name  @45 '/* _' +(-1) varnum '*/';
run;
 %end; 

data _null_;
  file map_file mod ;
  put '%mend readvar1_list;';   
run;


/*--- Keep_varlist ---*/

%let nkeep = %attrn_nlobs(_dictionary);
data _null_;
  file map_file mod ;
  set _dictionary  end = eof;
   if _n_=1 then do;
     /*   Generate list of vars to keep */
     put / '%macro keep_varlist;';
     put "/* Table &table: List of &nkeep variables to keep */";
   end;
   put @3  name;
   if eof then do; 
     put '%mend keep_varlist;';
   end;
run;


/*---  `template_long_data` --- */

data _null_;
  file map_file mod;
  put / '%macro create_template_longout;';
  put '/*  Table &table: Macro creates  `_template_longout` dataset*/;' ; 
  put 'data _template_longout;';
  put @3 'missing A B C D E F G H I J;';
  put @3 'missing K L M N O P Q R S T;';
  put @3 'missing U V X Y Z;';
  put @3 'missing _; /* _ reserved for variables not defined (blank cells) in map_info */'; 
  put @3 '%label_statements;';
  put @3 '%clength_statements;';
  put @3 '%format_statements;';
  put @3 'call missing(of _all_);';
  put @3 'stop;';
  put 'run;';
  put '%mend create_template_longout;';
run;

/*=== Create `append_outtable` macro ==== */


data _null_;
  file map_file mod;
  
  put / '%macro append_outtable(datain);';
  put "/*  Table &table: Macro creates and appends `_outtable` data */;" ;
  put "/*  Depends on table type through `process_data` macro */";
  put ' data _outtable;';
  put '  if 0 then set _template_longout;';
  put '   set &datain(keep = %' 'readvar1_list %' 'readvar2_list);';
  put '   %' 'process_data;';
  put '   keep %' 'keep_varlist;';
  put ' run;';
  put /;
  put ' proc append base = _base_longout';
  put '             data= _outtable;';
  put ' run;';
  put '%mend append_outtable;' /;
  
run;

/* Create `initvars` macro */

data _null_;
  file map_file mod ;
  set _dictionary end = eof;
    length txt txtx txtc  $50;
    txt  = '/* ' || strip(name ) || ' variable already included  */';     /* varin =1         */
    txtc  =  strip(name) || " = '*';";                            /* varin = 0 and type = 2 */
    txtx  =  strip(name) || " = ._;";                             /* varin =0  and type = 1 */
    if _n_=1 then do;
       put '%macro initvars;';
       put "/*  Initialize output variables, unless they are included in the input dataset */";
     end;
    if varin = 1  then put @3 txt;
       if varin = 0  then do;
         if indexc(clength,"$") then put @3 txtc;
          else put @3 txtx;
       end;

   if eof then put '%mend initvars;';
run;


%mend put_init_macro_stmnts;
