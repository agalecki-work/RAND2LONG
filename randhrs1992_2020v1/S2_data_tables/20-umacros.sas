%macro rwide_summary_vars;

/* Auxiliary macro */

/* Variable _inw_summary */
 length _inw_summary $ 15;
 length inwc $1;
 array _inw{*} inw1-inw15;
 
 do i=1 to dim(_inw);
   inwi =_inw{i};
   inwc = strip(put(inwi, 8.));
   substr(_inw_summary, i) = inwc;
 end;
 drop i inwi inwc;
 
%mend  rwide_summary_vars;