# !!! (FOR DEVELOPERS only, WORK IN PROGRESS)

This project aims to reshape and recode the RAND HRS Longitudinal File 2020 dataset `randhrs1992_2020v1` from wide to long format.


IMPORTANT: 

After downloading `RAND2LONG` repository modify:

* `repo_path` macro variables in `autoexec.sas` file
* `xlsx_nickname`, `xlsx_date`, `xlsx_path`, `HRSpkg_path` macro variables in `project_setup.sas` file.
* path to LIBIN library in `project_setup.sas` file.

  
* The Pepper Center grant has supported the project;

* Programs in this repository were written by:  Jinkyung Ha, Mohammed Kabeto, and Andrzej Galecki 

In this document we describe step-by-step on how to convert **RAND HRS Longitudinal File 2020** from wide format to a long format.

# Prerequisites

##  Download RAND HRS Longitudinal File 2020
 
* Download `randhrs1992_2020v1_SAS.zip` file available 
[here](https://hrsdata.isr.umich.edu/data-products/rand-hrs-longitudinal-file-2020). 
* Store `randhrs1992_2020v1.sas7bdat` and `sasfmts.sas7bdat` files in a folder of your preference.

Notes: 

* You will need to register with HRS website to access the data
* We will refer to `randhrs1992_2020v1.sas7bdat` and `sasfmts.sas7bdat` datasets
as **DATAIN** and **FORMATS_CNTLIN**, respectively.


## Prepare `randhrs1992_2020v1_map.xlsx`file with information on mapping **DATAIN** MAP_INFO` dataset

* Prepare SAS dataset referred to as **MAP_INFO** that contains information about mapping of the **DATAIN** dataset from wide to long format.
* For user covenience this dataset named `randhrs1992_2020v1_map.sas7bdat` has been already prepared.

## Prepare SAS FCMP functions

* Prepare SAS FCMP functions needed for data conversion.
* For user convenience the FCMP code  has been already prepared and was stored in  the `./usource/FCMP_src.sas` file.



