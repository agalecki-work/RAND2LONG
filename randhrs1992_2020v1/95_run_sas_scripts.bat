::: PREAMBLE starts
pushd %~dp0
:: Define `cdir`
set "cdir=%CD%"
cd %CDIR%
echo %CDIR%
set sas="C:\Program Files\SASHome\SASFoundation\9.4\sas.exe"
set proj="C:\Users\agalecki\Documents\GitHub\RAND2LONG\randhrs1992_2020v1"
set name=01-check_prj_autosetup
set pgm=%name%.sas
echo %pgm%
set log=%name%.log
%sas% -sysin %pgm% -log %log% -nosplash -nologo -icon
pause

