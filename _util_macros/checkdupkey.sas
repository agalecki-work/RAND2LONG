%macro checkdupkey(data, keys, opt = S, keepall =Y, out =_mrgd_dupkey_) / des = "M1: Check data for dupkeys";  
/* By default dataset _mrgd_dupkey_ created */
%put --> checkdupkey macro for %UPCASE(&data) dataset STARTS;
%put keys = &keys;

%if %upcase(&keepall) = Y %then %let keep_var =_all_; %else %let keep_var = &keys;    
data _checked_dupkey_;
  set &data(keep = &keep_var);
  _tempone_ = 1;
  obs_no =_n_;
run;
%put : data = &data;
%put : keys = &keys;
proc sort data = _checked_dupkey_;    /* Data sorted for merging */
by &keys;
run;

proc freq data = _checked_dupkey_ noprint;
table _tempone_ / out = _freq_dupkey_;
by &keys;
run;

/* By default opt = S, so SHORT version of _mrgd_dupkey is created */
%if (&opt = S) %then %do;
  data _freq_dupkey_;
    set _freq_dupkey_;
    if count > 1; 
  run;
%end;

data &out;
  merge _checked_dupkey_ (in = in1) _freq_dupkey_ (in = in2);
  by &keys;
  if in2;
  drop _tempone_;
run;
%put : Option := &opt. If Option = S verify whether number of observations in &out data  is 0;


%if %sysfunc(find(&out, .)) eq 0 %then %let out = work.&out;;
%let libnm = %scan(&out,1, %str(.) );
%let dtnm   = %scan(&out,2, %str(.) );

%let nobs = %attrn_nlobs(&dtnm, libname = &libnm);
%if (&nobs ne 0) %then %put WARNING: Duplicate keys &keys (n= &nobs) in &data dataset detected;; 

%put : ===> checkdupkey macro for %UPCASE(&data) dataset ENDS;

%mend checkdupkey;

