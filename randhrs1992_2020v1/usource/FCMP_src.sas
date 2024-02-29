
function hrs_studyyr(wv, HA); 
/* Mapping HRS waves to study year

wv = 1                  -> 1992
wv = 2  and HA in (0,1) -> 1993
wv = 2  and HA =3       -> 1994
wv = 3  and HA in (0,1) -> 1995
wv = 3  and HA =3       -> 1996
wv = 4                  -> 1998
wv = 5                  -> 2000
...
wv = 15                 -> 2020
*/

yr = 1990 + 2*wv; /* Tentatively every two years */
 
if wv = 2 and HA in (0,1) then yr =1993;
if wv = 2 and HA = 3      then yr =1994;
if wv = 3 and HA in (0,1) then yr =1995;
if wv = 3 and HA = 3      then yr =1996;
 
 * if wv in (2,3,4,5) then put wv= HA= studyyr=;
 return (yr);
endsub;




