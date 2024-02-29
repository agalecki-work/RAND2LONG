%macro populate_1rps_map(table);

/* For Rexit and Rwide tables */
%let map0 =_libmap0.&table._map0;
%let mapx =&table._map;
%***let waves_list = base;

data &mapx; 
 set &map0;
run;
%mend populate_1rps_map;

