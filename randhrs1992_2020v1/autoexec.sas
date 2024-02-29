%put ===> autoexec.sas (PROJECT) STARTS;

%global repo_name repo_path prj_name prj_path;
%global repo_name repo_path prj_name prj_path;

/* Current working directory in SAS */

data _null_;
      rc=dlgcdir();
      put rc=;
run;

%let repo_name = RAND2LONG;
%let repo_path = C:\Users\agalecki\Documents\GitHub\&repo_name;  


filename _desc "&repo_path";
%include _desc(description);
%description;
filename _desc clear;

/* ------ Project name  (name of the repo subdirectory)----------*/
%let prj_name  = randhrs1992_2020v1;
%let prj_path = &repo_path\&prj_name;

%put repo_name := &repo_name;
%put repo_path := &repo_path;
%put prj_name  := &prj_name;
%put prj_path  := &prj_path;

%put --- autoexec.sas (PROJECT) ENDS;
%put; 



