%macro print_README_main_document;

data _null_;
  file print;
  put "This document contains basic information on" 
      " a data product derived from RAND Longitudinal Data" /;
  put "RAND Longitudinal (input) dataset: %upcase(&datain) ";
      
  put "Release info: &table_version (&xlsx_nickname)" /;
  
  put "Note: Data product described here was prepared by the the Design, Data and Biostistics Core"/ 
      "   part of the University of Michigan Claude D. Pepper Older Americans Independece Center" /;
  put "For more information see the following files:" /
      "  - xyz.docx " /
      '  - ./dictionaries/README.txt' /
      '  - ./tables_long/README.txt' /
      '  - ./tables_long/CONTENTS.txt' /

      ;
   

run;



%mend print_README_main_document;
