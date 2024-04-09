# !!! (FOR DEVELOPERS only, WORK IN PROGRESS)

This project aims to convert the RAND HRS Longitudinal File 2020 dataset `randhrs1992_2020v1` from wide to long format.


IMPORTANT: 

After downloading `RAND2LONG` repository modify:

* `repo_path` macro variables in `autoexec.sas` file
* `xlsx_nickname`, `xlsx_date`, `xlsx_path`, `output_path` macro variables in `project_setup.sas` file.
* path to `LIBIN` library in `project_setup.sas` file.

Structure of the output folder is as follows:

Note: Subfolders `HRS_package` and `HRS_package\data_tables` need to be created before running the scripts

```
C:\OUTPUT_FOLDER
+---dictionaries
\---HRS_package
    \---data_tables
```

After executing scripts in this repository the output folder will be populated as follows:

```
C:\OUTPUT_FOLDER
+---dictionaries
|       hlong_dict.sas7bdat
|       rexit_dict.sas7bdat
|       rlong_dict.sas7bdat
|       rssi_dict.sas7bdat
|       rwide_dict.sas7bdat
|       slong_dict.sas7bdat
|
\---HRS_package
    |   dictionaries.txt
    |   _README.txt
    |   project_guide.docx (will be added manually)
    |
    \---data_tables
            hlong_table.sas7bdat
            rexit_table.sas7bdat
            rlong_table.sas7bdat
            rssi_table.sas7bdat
            rwide_table.sas7bdat
            slong_table.sas7bdat
            _randfmts_long.sas7bdat
            _README.txt
```



  
* the project was supported by Pepper Center grant

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


## Prepare `randhrs1992_2020v1_map.xlsx`file with the information on mapping **DATAIN** MAP_INFO` dataset

* Prepare SAS dataset referred to as **MAP_INFO** that contains information about mapping of the **DATAIN** dataset from wide to long format.
* For user covenience this dataset named `randhrs1992_2020v1_map.sas7bdat` has been already prepared.

## Prepare SAS FCMP functions

* Prepare SAS FCMP functions needed for data conversion.
* For user convenience the FCMP code  has been already prepared and was stored in  the `./usource/FCMP_src.sas` file.



