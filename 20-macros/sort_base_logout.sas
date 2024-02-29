%macro sort_base_logout;
%if %eval(%length(&key_vars) > 0) %then %do;
proc sort data = _base_longout nodupkey;
by &key_vars;   *hhid pn wave_number;
run;
%end;
%mend sort_base_logout;