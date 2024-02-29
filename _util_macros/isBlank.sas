/*--- https://support.sas.com/resources/papers/proceedings09/022-2009.pdf ---*/
%macro isBlank(param);
  %sysevalf(%superq(param)=,boolean);
%mend isBlank;

