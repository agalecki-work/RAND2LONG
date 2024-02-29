/* NOTE: autoexec.sas executed */
options mprint formdlim=" ";

libname _libmap0  "&prj_path\&dir_name\maps0";

* Local macros loaded;
filename macros "&prj_path\&dir_name\_macros";
%include macros(zzz_xlsx_include);
%zzz_xlsx_include;

/* ==== Execution starts =====*/
%_project_setup;


%html_content_title(Maps0);

 ods listing close;
 ods html  path =     "&prj_path\&dir_name" (URL=NONE)
           file =     "00-create_maps0-body.html"
           contents = "00-create_maps0-contents.html"
           frame =    "00-create_maps0-frame.html"
           style     = styles.custom

;

%import_xlsx_maps_info;

data _libmap0.maps_info;
 set maps_info;
 length cwaves_count $3;
 cwaves_count = strip(put(waves_count, 3.));
run;

%traceit_print(maps_info, libname =_libmap0);

%import_xlsx_map(RLong);
%import_xlsx_map(HLong);
%import_xlsx_map(Rwide);
%import_xlsx_map(Rexit);
%import_xlsx_map(RSSI);
%import_xlsx_map(SLong);
ods html close;



