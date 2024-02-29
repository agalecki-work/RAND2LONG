%macro create_dictionary;
%let tbl = %upcase(&table);
%let keep1=;
%if (&tbl = RLONG or &tbl = HLONG or &tbl = RSSI) %then %let keep1= wave_pattern wave_summary; 
data _dictionary_init;
  set _stmnts0(keep= name ctype label clength format dispatch &keep1);
  if substr(ctype,1,1)= "A";
run;

data _dictionary;
  retain varnum;
  set _dictionary_init;
 varnum = _n_;
 valid_name = nvalid(name,'v7');
 if  ctype='A0' then varin =1; else varin =0;

run;

%mend create_dictionary;

