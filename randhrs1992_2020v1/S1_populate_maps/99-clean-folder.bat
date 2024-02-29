::: PREAMBLE starts
pushd %~dp0
:: Define `cdir`
set "cdir=%CD%"
cd %CDIR%
echo  ... xlsx,sas7bdat in this folder will be deleted
timeout /t 5
del *.xlsx
del *.log 
del *.lst
del *.xls
del *.sas7bdat
del *.html
del *.htm

del maps\*.sas7bdat
del maps0\*.sas7bdat


