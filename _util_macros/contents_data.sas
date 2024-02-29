%macro contents_data(data,  out = contents, printvars = memname name  type length label format nobs, print = Y)
      / des = "M1: Data contents";
/* ATG DEC. 2015 */
 proc contents data = &data position out = &out noprint;
 run;
 
 proc sort data = &out;
 by varnum;
 run;
 
%if (%upcase(&print) = Y) %then %do; 
 proc print data = &out;
 var &printvars;
 run;
%end; 

%mend contents_data;

