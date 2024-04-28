/* April 2024, WIP */

 %macro skip;
/* Merge rlong and slong tables */
proc sql noprint;
select name into :slong_vars separated by " " from dictionary.columns 
where libname   ="LIB" and memtype="DATA"  and memname="SLONG_TABLE"
  and name ne "S_HHIDPN" and type = "num" ;
quit;
%put slong_vars := &slong_vars;
  
  
  missing Z;
   array _s {*} &slong_vars;

  if ins =0 then do;
    S_HHIDPN = 0;
    do i =1 to dim(_s);
     si = _s{i};
     if si = . then  si = .Z;
     _s{i} = si;
    end;
  end;
  drop i si;
run;

title "SLONG ";
data dt;
 set rs;
  if S_HHIDPN = 0;
  keep hhid pn studyyr S_HHIDPN &slong_vars;
run;

proc print data=dt (obs =10);
format _all_;
run;
%mend skip;



options ls = 150 nocenter;
%let rlong_vars1 =
R_ACGTOT R_ADL5A R_ADL5H R_ADL6A R_ADL6H R_ADLR10 R_ADLW R_AGEM_B R_AGEM_E R_AGEM_M
R_AGEY_B R_AGEY_E R_AGEY_M R_AIMR10 R_ALONE
R_ALZHE
R_ALZHEE
R_ALZHEF
R_ALZHEQ
R_ALZHES
R_AMSTOT
R_ANS3PQ
R1_ARMS
R2_ARMS
R_ARMS
R_ARMSA
R_ARMSW
R_ARTHR
R_ARTHRE
R_ARTHRF
R_ARTHRQ
;

%let slong_vars =SASSAGEB
SASSAGEM
SASSRECV
S_ACGTOT
S_ADL5A
S_ADL5H
S_ADL6A
S_ADL6H
S_ADLR10
S_ADLW
S_AGEM_B
S_AGEM_E
S_AGEM_M
S_AGEY_B
S_AGEY_E
S_AGEY_M
S_AHDSMP
S_AIMR10
S_ALONE
S_ALZHE
S_ALZHEE
S_ALZHEEF
S_ALZHEF
S_ALZHEQ
S_ALZHES
S_AMSTOT
S_ANS3PQ
S1_ARMS
S2_ARMS
S_ARMS
S_ARMSA
S_ARMSW
;

%let hlong_vars =
H_ABOND   H_ABSNS   H_ACD     H_ACHCK   H_ADEBT   H_AFBOND  H_AFBSNS   H_AFCD    H_AFCHCK   H_AFDEBT
H_AFHMLN  H_AFHOUB  H_AFHOUS  H_AFIRA   H_AFMORT  H_AFMRTB  H_AFNETHB  H_AFOTHR  H_AFRLES   H_AFSTCK
H_AFTRAN  H_AHMLN   H_AHOUB   H_AHOUS   H_AIRA    H_AMORT   H_AMRTB    H_ANETHB  H_ANYFAM   H_ANYFIN
H_AOTHR   H_ARLES   H_ASTCK   H_ATOTB   H_ATOTF   H_ATOTH   H_ATOTN    H_ATOTW   H_ATRAN    H_CHILD
H_CPL     H_HHRES   H_HHRESP  H_ICAP    H_IFCAP   H_IFIRAW  H_IFIRAWY1 H_IFOTHR  H_IFSSI    H_IFTOT
H_IFTOT2  H_IIRAW   H_IIRAWY1 H_INPOV   H_INPOVA  H_INPOVAD H_INPOVD   H_INPOVR  H_INPOVRD  H_INPVRA
H_INPVRAD H_IOTHR   H_ISSI    H_ITOT    H_ITOT2   H_NHMLIV  /* H_OHRSHH*/   H_OOPMA   H_OOPMAF   H_OOPMD
H_OOPMDF  H_POVFAM  H_POVHHI  H_POVHHID H_POVTHR  H_PVFAMA  H_PVHHIA   H_PVHHIAD H_PVTHRA   H_SSWRER
H_SSWRNR  H_SSWRXA
;


/*--- Using SAS formats */

/* Create `work.formats` catalog */
proc format lib = WORK cntlin = lib._RANDfmts_long;
run;


/* Reconstruct RAND data */
proc transpose data=out.mrg5_tables out=moltenData name=vLabel;
   by hhid pn /*subhh*/ wave_number;
   var &hlong_vars;  *H_ABOND H_AIRA R_YR R2_EAT R1_EAT R_EAT; * _numeric_; 
run;

Title "moltenData";
proc print data=moltenData (obs=100);
run;


/* Construct vname variable */

data molten2;
  set moltenData;
  missing _;
  row_no = _n_;
  missing _;
  length cx $2;
  length cpart2 $ 31;
  length vname $32;
  if col1 = ._ then delete;
  vname = vLabel;
  cx = strip(put(wave_number, 8.)); /* wave number */
  c1 = substr(vLabel,1,1);
  c2 = substr(vLabel,2,1);
  idx0 = find(vlabel,"_");
  len = length(vLabel);
  if idx0>0 then cpart2 = substr(vLabel, idx0+1, len -idx0); else cpart2 =""; /* part2 */
  if substr(vlabel, 2, 1) = "_"  then vname = strip(c1) ||cx || strip(cpart2);
  
  if substr(vlabel, 2, 2) = "1_" and wave_number = 1 then vname = strip(c1) ||"1" || strip(cpart2);
  if substr(vlabel, 2, 2) = "2_" and wave_number = 2 then vname = strip(c1) ||"2" || strip(cpart2);
  vname =compress(vname);
  if vlabel= "H_HHID" then vname = "H_HHID";
  one=1;
 
  drop cx; 
run;

Title "molten2";
proc print data= molten2 (drop = _label_);
var row_no hhid pn wave_number vlabel c1 c2 cpart2 vname col1;
where col1 = .;
run;


proc freq data= molten2 noprint;
tables vname/out = m2vars (drop=percent);
run;

title "VARS: list of variables in `molten2`";
proc print data = m2vars(where=(count<10));
run;

/* identify rows */

proc sort data = molten2;
by vname;
run;

proc sort data = m2vars;
by vname;
run;

data molten2(drop=count);
 merge molten2 m2vars;
 by vname;
 count1 = count;
 if count1 > 10;
run;

title "chk1 -molten2";
proc print data = molten2;
where count1 <10;
run;


proc sort data = molten2 out= molten2s;
  by hhid pn wave_number cpart2;
run;

proc freq data =molten2s noprint;
 by hhid pn wave_number cpart2; 
 tables one/ out=outfreq;
run;

data molten2s;
  merge molten2s outfreq (drop= percent one);
  by hhid pn wave_number cpart2;
run;

Title "outfreq";
proc print data=outfreq(obs=100);
run;

proc contents data=outfreq;
run;

Title "molten2s";
proc print data= molten2s (obs=1000);
var hhid pn wave_number vlabel c1 c2 cpart2 vname col1;
run;


data molten2x;
 set molten2s;
 by hhid pn wave_number cpart2;
 if count > 1 then 
    do;
    if wave_number = 1 and c2 ne "1" then delete;
    if wave_number = 2 and c2 ne "2" then delete;
    if 3 <= wave_number <= 15  and c2 ne "_" then delete;
 end;
 
run;

Title "molten2x";
proc print data= molten2x (obs=1000);
var hhid pn wave_number vlabel c1 c2 cpart2 vname col1;
run;

proc freq data= molten2x noprint;
tables vname/out = m2xvars (drop=percent);
run;

title "VARS: list of variables in `molten2x`";
proc print data = m2xvars (where= (count <20));
run;


proc transpose data=molten2x out=out.wide(drop=_name_);
by hhid pn;
id vname;
var col1;
run;

%macro skip2;
data out.wide;
  set wide;
    missing U V Z;
    
    
  array _s1{*} 
    S14ADL5A  S14ADL5H   S14ADL6A  S14ADL6H   S14ALONE   S14ALZHE   S14ALZHEE  S14ALZHEEF S14ALZHEF  S14ALZHEQ  
    S14ALZHES S14ANS3PQ  S14ARMS   S14ARMSA   S15ADL5A   S15ADL5H   S15ADL6A   S15ADL6H   S15ALONE   S15ALZHE   
    S15ALZHEE S15ALZHEEF S15ALZHEF S15ALZHEQ  S15ALZHES  S15ANS3PQ  S15ARMS    S15ARMSA
   ;
   
    do i =1 to dim(_s1);
      if S_HHIDPN = 0  and _s{i} = .U  then _s{i} = .V; 
      if S_HHIDPN = 0  and _s{i} = .Z  then _s{i} = .U; 
    end; 

run;
%mend skip2; 

title "wide";
proc print data=out.wide (obs=1000);
run;

title "compare";
proc compare data =out.wide compare= libmain.randhrs1992_2020v1 listbasevar LISTEQUALVAR;
id hhid pn;
run;
