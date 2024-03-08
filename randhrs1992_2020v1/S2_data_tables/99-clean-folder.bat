::: PREAMBLE starts
pushd %~dp0
:: Define `cdir`
set "cdir=%CD%"
cd %CDIR%
echo  ... xlsx,sas7bdat in this folder will be deleted

del *.xlsx
del *.xlsx
del *.sas7bdat /s
del *.html /s
del *.htm
del *.inc /s
del *.log /s
del *.lst
del *.html
timeout /t 5



