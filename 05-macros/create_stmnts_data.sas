
%macro create_stmnts_data;
proc transpose data = &table._stmnts0
                out =&table._stmnts (rename = (col1= stmnt))
                name = wave_no
                ;
var wv1 - wv&cwaves_count;
by stmnt_no;
run;

data _stmnts;
  set &table._stmnts;
  wv_no = input(substr(wave_no,3), 8.);
  if stmnt ne "";
run;
%mend create_stmnts_data;
