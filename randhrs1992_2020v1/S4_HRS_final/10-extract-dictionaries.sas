libname libout "&dir_path/HRS_package/data/dict";


%let path_aux = &prj_path\S2_data_tables\_05aux;

/* One libname statement dataset with map info  */

libname auxHLong "&path_aux\HLong";
libname auxRLong "&path_aux\RLong";

libname auxRexit "&path_aux\Rexit";

libname auxRwide "&path_aux\Rwide";

libname auxRSSI "&path_aux\RSSI";

/* Combine libraries */

libname aux_all (auxHLong auxRLong auxRexit auxRwide auxRSSI);

%macro modify_dict_info(dict);

data libout.&dict;
  set aux_all.&dict;
  drop ctype valid_name varin;  
run;

%mend modify_dict_info;

%modify_dict_info(RLong_dict);
%modify_dict_info(HLong_dict);
%modify_dict_info(Rexit_dict);
%modify_dict_info(RSSI_dict);
%modify_dict_info(Rwide_dict);