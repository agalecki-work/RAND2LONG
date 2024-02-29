/* NOTE: autoexec.sas executed */
options mprint;

libname _libmap0  "&prj_path\&dir_name\maps0" access="readonly";

libname _libmap  "&prj_path\&dir_name\maps";

* Local macros loaded;
filename macros "&prj_path\&dir_name\_macros";
%include macros(zzz_xlsx_include);
%zzz_xlsx_include;


/*=== Execution starts =====*/


/* ===== Macro `_project_setup` executed  ===== */;
%_project_setup;


 ods listing close;
 
 %html_content_title(Maps);

 ods html  path =     "&prj_path\&dir_name" (URL=NONE)
           file =     "05-updated_maps-body.html"
           contents = "05-updated_maps-contents.html"
           frame =    "05-updated_maps-frame.html"
           style     = styles.custom
 ;

/* --- Maps info */
data _libmap.maps_info;
 set _libmap0.maps_info;
run;

%traceit_print(maps_info, libname = _libmap);

/* --- Rwide map ---*/
%populate_1rps_map(Rwide);
%traceit_print(Rwide_map);

data _libmap.Rwide_map;
 set Rwide_map;
run;

/* --- Rexit map --- */
%populate_1rps_map(Rexit);
%traceit_print(Rexit_map)
data _libmap.Rexit_map;
 set Rexit_map;
run;

/* --- RSSI_map ----*/
%populate_RSSI_map;   /* RSSI_map0 -> RSSI_map */
%traceit_print(RSSI_map);
data _libmap.RSSI_map;
 set RSSI_map;
 drop  wave_summary0 wave_pattern0;
run;

/* --- RLong_map ----*/
%populate_RLmaps(RLong);
%traceit_print(RLong_map);
data _libmap.RLong_map;
 set RLong_map;
 drop countx wave_summary0 wave_pattern0;
run;

/* --- HLong_map ----*/
%populate_RLmaps(HLong);
%traceit_print(HLong_map);
data _libmap.HLong_map;
 set HLong_map;
 drop countx wave_summary0 wave_pattern0;
run;

/* --- SLong_map ----*/
%populate_RLmaps(SLong);
%traceit_print(SLong_map);
data _libmap.SLong_map;
 set SLong_map;
 drop countx wave_summary0 wave_pattern0;
run;


ods html close;






