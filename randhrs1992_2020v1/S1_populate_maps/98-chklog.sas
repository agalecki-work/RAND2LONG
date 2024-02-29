/* chek log files in current directory */
%let skip= .\98-chklog.log; 
options nocenter;


ods listing close;

ods html file = "98-checklog.html"; 
%checklog_dir(&dir_name);

ods html close;