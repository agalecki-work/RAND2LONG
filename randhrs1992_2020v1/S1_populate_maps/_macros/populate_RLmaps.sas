%macro populate_RLmaps(table);
%put ===> Macro `populate_RLmaps` STARTS ===;
/* Macro used for RLong and Hlong maps _only_ */

/* Use `wave` variables to populate `wave_summary` and `wave_pattern` variables  */
%let map0 =_libmap0.&table._map0;
%let mapx = &table._map;
%let waves_list = hrs_wave1 - hrs_wave15;
data &mapx; 
 retain name label clength format dispatch wave_summary0 wave_summary countx wave_pattern0  wave_pattern;
 set &map0;
 length c1 $1;
 length wave_summary $40;
 length wave_pattern $40;
 put "---->>" name=;
 c1 =substr(strip(name),1,1);
 
 array _waves {*} $ &waves_list;
 
 if c1 ne ':' then 
 DO;
   put "--- DO BLOCK";
   length ci $30; 
 
   /* Default values assigned */
   cs0 = " ";
   cp0 = " ";
   if wave_summary0 ne "" then cs0 =substr(strip(wave_summary0), 1, 1);
   if wave_pattern0 ne "" then cp0 =substr(strip(wave_pattern0), 1, 1);

   if  cs0 ne "*" then wave_summary = strip(wave_summary0);
   if  cp0 ne "*" then wave_pattern = strip(wave_pattern0);

   /*---  Count non-empty cells in `_waves_ variables */
   countx =0;
   do i=1 to dim(_waves);
     ci = _waves[i];
     if ci ne "" then countx+1;
   end;
 
   put  "---" countx =;
 
   /*---  RAND variable  */
   if countx = 0 and dispatch ="" then
    do;
      if cp0 = "*" then wave_pattern = "-- RAND var";
      if cs0 = "*" then wave_summary = "-- N/A";
    end;
 
 /* ---- Derived variable */
   if countx = 0 and dispatch ne "" then 
    do;
     if cp0 = "*" then wave_pattern = "-- Derived var";
     if cs0 = "*" then wave_summary = "-- N/A";
    end;
 
 /* Populate `wave_pattern` for countx > 0 */
 
   if countx >0 and cp0 = "*" then
     do;
       put "do block countx>0 and cp0=star";
       done = 0;
       wave_pattern ="";
 
       put "---- doi i=1 to dim(_waves)";
       do i=1 to dim(_waves);
         ci = _waves[i];
         if ci ne "" and i <10 and wave_pattern = "" and done =0 then 
           do;
            done =1;
            substr(ci,2,1) = "?";
            wave_pattern =tranwrd(ci,"?","[w]"); /* ? -> [w] */ 
           end;  /* do block after if ci ..., i < 10*/
   
        if ci ne "" and i >=10 and wave_pattern = "" and done =0 then 
          do;
           done =1;
           substr(ci,2,2) = "?";
           wave_pattern =tranwrd(ci,"?","[w]"); 
          end;  /* do block after if ci ...,i>=10 and wave_pattern  */
       end; /* do i */
   end; /* do block after if countx >0 and cp0 = "*" */

if find(wave_pattern, "[w]", "i") then wave_pattern = compress(wave_pattern); /* Remove blanks */
 
 /* Populate `wave_summary`  */
  
 if countx > 0 and cs0 = "*" then 
   do;
    wave_summary ="ooooOooooOooooO";
     do i=1 to dim(_waves);
       ci = _waves[i];
       if ci ne "" then substr(wave_summary,i,1)="x";
       if ci ne "" and i in (5,10,15) then substr(wave_summary,i,1)="X";
     end; /* do i */
 
   end; /* do block after if countx >0 and cs0 = "*"  */

 
 /*--- Wave pattern exceptions */
 
 if cp0 = "*" then 
  do;
    if upcase(strip(name)) = "WAVE_NUMBER" then wave_pattern = "-- Num 1,2, ...";
    if upcase(strip(name)) = "INW" then wave_pattern = "INW[w]";
    if upcase(strip(name)) = "CYEAR" then wave_pattern = "-- yr#### string";
  end;
 
 END; /* if c1 ne : */

 drop i ci c1 done;
run;


%mend populate_RLmaps;