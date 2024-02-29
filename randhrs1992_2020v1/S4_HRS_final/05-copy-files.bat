::: PREAMBLE starts
pushd %~dp0
:: Define `cdir`
set "cdir=%CD%"
cd %CDIR%

:: Copy FCMP_src.sas  
set "fx=..\usource\FCMP_src.sas"
echo %fx%
copy %fx% %CDIR%\HRS_package\pgm


:: Copy map files from \S2_data_tables\map_files folder
set "pathx=..\S2_data_tables"
echo %pathx%

copy %pathx%\map_files\*_map_file.inc %CDIR%\HRS_package\pgm\map_files


:: Copy SAS formats
copy %pathx%\data\_randfmts_long.sas7bdat %CDIR%\HRS_package\data

:: Copy SAS data tables 
copy %pathx%\data\*_table.sas7bdat %CDIR%\HRS_package\data


timeout /t 25