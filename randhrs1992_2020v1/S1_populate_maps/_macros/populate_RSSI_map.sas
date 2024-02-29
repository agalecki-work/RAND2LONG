%macro populate_RSSI_map;
%let waves_list = RSSI_E1-RSSI_E11;

/* Use name and dispatch variable to populate `wave_pattern`,  `wave_summary`and `waves_list` variables */
/* Variables `wave_pattern0`,  `wave_summary0` will be ignored */
/* Macro variable `waves_list` is required  */

%put --- Macro populate_RSSI_map.  waves_list := &waves_list;
data RSSI_map; 
 retain name label clength format dispatch  wave_summary0 wave_summary wave_pattern0 wave_pattern;
 set _libmap0.RSSI_map0;
 array _waves {*} $40  &waves_list;
 
 length c2 $2;
 length ci $30; 
 length c1 $1;

 length wave_summary wave_pattern $40;
 c1 = substr(strip(name),1,1);
 if c1 =":" then do;
  wave_summary="";
  wave_pattern="";
 end;
 if c1 ne ":" then DO;
 countx = dim(_waves);
 wave_summary ="All episodes"; 
 
 if dispatch = "" then do;
  wave_summary = "N/A";
  wave_pattern = "RAND var";
 end;
 
 if dispatch in ("=?", "=") then do;
   wave_summary = "All episodes";
   wave_pattern = tranwrd(upcase(name),"_E","[E]"); 
  end;
  
 
 if upcase(name) = "RSSI_EPISODE" then wave_pattern = "Num 1,2,3";
 
  if dispatch ne "" then do;
 do i=1 to countx;
    if i < 10 then c2 = strip(put(i, 1.));
    if i >= 10 then  c2 = put(i, 2.);
   ci = tranwrd(upcase(name),"_E", c2);  
   if upcase(name) = "RSSI_EPISODE" then ci = strip(put(i,3.));
   _waves[i] =ci;
 end;
 end;
 END;
   
 drop i countx ci c2 c1 ;
 
run;
%mend populate_RSSI_map;