%macro traceit(member, libname =work, obs=20, vars =);
  
  %traceit_contents(&member, libname =&libname, obs= 50,
      vars =  varnum memname name type length format nobs label);
  %traceit_print(&member, libname =&libname, obs=&obs, vars =&vars);
%mend traceit;
