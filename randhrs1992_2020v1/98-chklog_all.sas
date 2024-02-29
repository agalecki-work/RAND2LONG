%let skip= .\98-chklog.log; 
options nocenter;

filename chklog "&repo_path\05-macros";
%include chklog(checklog_dir, checklog);
filename chklog clear;

ods listing close;
ods html file = "98-chklog_all.html";

%checklog_dir(S1_populate_maps); /* Subfolder in project directory */
%checklog_dir(S2_data_tables);
%checklog_dir(S3_data_tests);
ods html close;





