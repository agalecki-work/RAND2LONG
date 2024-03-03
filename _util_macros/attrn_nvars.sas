%macro attrn_nvars(member, libname = work) / des = "M1: Returns number of vars in the dataset ";
%local data DSID counted anobs whstmt rc;
%let data = &libname..&member;
%let DSID = %sysfunc(open(&DATA., IS));
%if &DSID = 0 %then
%do;
 %put %sysfunc(sysmsg());
 %let counted = .;
%goto mexit;
%end;

%let anobs = %sysfunc(attrn(&DSID, ANOBS));   /* specifies whether the engine knows the number of observations.*/
%let whstmt = %sysfunc(attrn(&DSID, WHSTMT)); /* specifies the active WHERE clauses.*/
%if &anobs=1 & &whstmt = 0 %then
%do;
%let counted = %sysfunc(attrn(&DSID, NVARS)); /* specifies the number of variables */
%end;
%mexit:
%if &DSID > 0 %then %let rc = %sysfunc(close(&DSID)); /* Close dsid */
&counted
%mend attrn_nvars;
