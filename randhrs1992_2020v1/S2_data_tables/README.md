IMPORTANT:

* Provide path in `libname _data` statement


# Main programs

RAND data conversion is performed in two steps:

* Step 1: Generate file with auxiliary SAS macros.
* Step 2: Create **OUTDATA** dataset in long format.

## Step 1: Generate **MAP_FILE** file with auxiliary SAS macros

Run `05-create-map_file.sas`

* Input: *MAP_INFO* and *DATAIN* datasets      
* Output: 
    - Text file referred to as **MAP_FILE** that contains SAS macros used in Step 2.
    - (Optional) auxiliary output in `./05-aux_out` subfolder 
      
## Step 2: Create **OUTDATA** dataset in long format.

Run `20-wide2long.sas`

* Input: **MAP_FILE** created in Step 1, **DATAIN** and **FORMATS_CNTLIN** datasets
         FCMP code (see above)
* Output: **OUTDATA** and  **OUTDATA_FORMATS** datasets stored in `./20-out` subfolder
    - 
# Auxiliary programs

* `25-read-wout-fmts.sas` Reads **OUTDATA** dataset without using SAS formats
* `26-read-with-fmts.sas` Reads **OUTDATA** dataset with SAS formats