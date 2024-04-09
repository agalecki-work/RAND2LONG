options source mprint;
%global fn;

%macro mx;
%put  ====== &fn ======;
filename fn "&fn"; 
%include fn;
filename fn clear;
%mend mx;


%let fn = 10-RLong-wout-fmts.sas;
%mx;

%let fn = 10-RLong-with-fmts.sas;
%mx;

%let fn = 20-HLong-wout-fmts.sas;
%mx;

%let fn= 20-HLong-with-fmts.sas;
%mx;

%let fn = 30-Rwide-wout-fmts.sas;
%mx;

%let fn = 30-Rwide-with-fmts.sas;
%mx;

%let fn = 40-Rexit-wout-fmts.sas; 
%mx;

%let fn = 40-Rexit-with-fmts.sas; 
%mx;

%let fn = 50-RSSI-wout-fmts.sas; 
%mx;

