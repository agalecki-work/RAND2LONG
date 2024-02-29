
%macro  create_stmnts0_data;

/* Temporary `_stmnt0` wide dataset with SAS statements stored in `_wv` array*/
data _stmnts0;
   retain ctype;
   set &mapx;
   *length table $40;
   length tmpci tmpi $200;
   length c1 $1;
   array _waves_list{*} $45   &waves_list;
   
   %do i =1 %to  &cwaves_count;
    length wv&i $200;
   %end;
   array _wv {&cwaves_count} wv1-wv&cwaves_count;
   length ctype $2;
   stmnt_no = _n_;
/* variable ctype created: Statement type  */

    c1 = substr(strip(name), 1, 1);
   if c1 =":"   then do; 
    select(dispatch);
      when ("") ctype = "S0"; /* regular SAS statement */
      otherwise ctype = "Sx"; /* SAS statement repeated */
    end;
  
    if ctype = "Sx" and indexc(dispatch,"?") then ctype = "S?";
   end;
   if c1 ne ":" then do;
     select(dispatch);
       when ("")        ctype = "A0"; /* RAND variable used */
       when ("=?")      ctype = "A?"; /* y = ? */
       otherwise        ctype = "AD"; /* derived variable */
     end;
   end;
   if ctype ="AD" and indexc(dispatch, "?") then ctype ="A?"; /* derived variable with ? */
 
 /* --- ctype = Sx: Based on `dispatch` populate `_waves_list` vars */
 if ctype = "Sx" then do;
  do i = 1 to dim(_waves_list);
    tmpci = _waves_list{i};
    tmpci = strip(dispatch)||strip(tmpci);
    _waves_list{i} = strip(tmpci);
   end;
 end;
 
 /* --- Based on `_waves_list` populate `_wv` variables */
 do i =1 to dim(_wv);
  tmpci = _waves_list{i};
  if ctype in ("S0", "Sx") then stmnti = strip(tmpci);  /*  tmpci  -> tmpci */ 
  if ctype = "S0" and tmpci ne "" then 
        stmnti = strip(tmpci) || " /*  " || strip(label)|| "  */";
  
  if ctype ="S?" then do;
       tmpi = strip(tmpci);
       stmnti = tranwrd(strip(dispatch), "?", tmpi);   /*  xx  -> Dis[xx]patch */
  end;
  
  if ctype in ("A0") then stmnti = strip(tmpci)    || "  /* --- RAND variable:" || strip(name)    || "  included */" ; 
  if ctype in ("AD") then stmnti = strip(name)|| strip(dispatch) || "     /* --- Derived variable  */" ; 
  if ctype in ("A?") then do;
      if tmpci ne "" then stmnti = strip(name)|| "=" || strip(tranwrd(dispatch, "=?", strip(tmpci))); 
      if tmpci = "" then stmnti = "/* Empty map cell for: "|| name || "variable wave ="|| put (i, 3.)|| "*/";    
  end;
  
  _wv{i} = stmnti;
 end;

   drop c1 tmpi tmpci;
run;
%mend create_stmnts0_data;
