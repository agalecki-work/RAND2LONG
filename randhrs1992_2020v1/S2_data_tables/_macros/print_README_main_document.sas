%macro print_README_main_document;
title;
data _null_;
  file print;
  put "Filename: _README.txt in the main folder" /;
  put "&project_title" /;   
  
  put "Data tables for this project were prepared by the the Design, Data and Biostistics Core"/ 
      "   part of the University of Michigan Claude D. Pepper Older Americans Independece Center" /;
  put "More information available in the following files:" /
      "  - project_guide.docx " /
      '  - ./dictionaries/README.txt' /
      '  - ./tables_long/README.txt' /
      '  - ./tables_long/CONTENTS.txt' /

      ;
  put "Project release info: &table_version (&xlsx_nickname)" /;

run;



%mend print_README_main_document;
