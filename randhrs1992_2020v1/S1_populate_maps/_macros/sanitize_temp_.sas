%macro sanitize_temp_(var, x = :);

%put --- sanitize_&var starting with <&x> STARTS ---;
data _temp_;
 set _temp_;
 file print;
 if _n_= 1 then put "-- Variable &var is sanitized";
 c1 = "*";
 if &var ne "" then do;
   c1 = substr(&var,1,1);  
   if c1 = "&x" then do;
     &var = substr(&var,2);
     put  name =  "c1=`" c1 +(-1) '`'   @45 "|--> &var = `" &var  +(-1) "`";
   end;
 end;

 drop c1;
run;
%put --- sanitize_&var ENDS ---;
%put;

%mend sanitize_temp_;

