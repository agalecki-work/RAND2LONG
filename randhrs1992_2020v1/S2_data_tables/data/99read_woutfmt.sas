options nofmterr;
ods hmtl;
libname lib '.';
proc print data=lib.rlong_table(obs=100);
var wave_number wave_name;
run;
ods html close;