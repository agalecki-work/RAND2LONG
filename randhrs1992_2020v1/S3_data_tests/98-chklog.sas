/* check log files in current directory */
/* Requires dir_path and dir_name */
%let skip= .\98-chklog.log; 
options nocenter;

filename chklog "&repo_path\_util_macros";
%include chklog(checklog_dir, checklog);
filename chklog clear;



ods listing close;

ods html file = "98-checklog.html"; 
%checklog_dir(&dir_name);

ods html close;