
%macro checklog_dir(subdir);
Title "Project &prj_name: Subdirectory &subdir";
%let dir = &prj_path\&subdir;
%checklog(&dir, pm=N);

data log_issues;
  set log_issues;
  log = tranwrd(log,"&prj_path",".");
  if lowcase(log) = "&skip" then delete;
run;


proc print data=log_issues;
run; 

%mend checklog_dir;
