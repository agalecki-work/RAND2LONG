%macro print_README_main_document;

title;
data _null_;
  file print;
  put "Filename: _README.txt in the main folder" /;
  put "Date: &sysdate" /;

  put "&project_title" ;   
  
  put "Data tables for this project were prepared by the the Design, Data and Biostistics Core"/ 
      "   part of the University of Michigan Claude D. Pepper Older Americans Independence Center" /;
  put "More information available in the following files:" /
      "  - project_guide.docx " /
      '  - dictionaries.txt' /
      '  - ./data_tables/README.txt' /
      ;
  put "Project release info: &table_version (&xlsx_nickname)" /;

run;



%mend print_README_main_document;
