%macro zzz_include;
%put ---- Macro zzz_include STARTS here;

%put - macro prep_aux_data2print;
%include _macros(prep_aux_data2print);


%put - macro create_dictionary;
%include _macros(create_dictionary);


%put - macro print_readme_main_document;
%include _macros(print_readme_main_document);

%put - macro print_readme_tables_document;
%include _macros(print_readme_tables_document);

%put - macro print_readme_dict_document;
%include _macros(print_readme_dict_document);

%put - macro print_contents_tables_document;
%include _macros(print_contents_tables_document);
%put ---- Macro zzz_include ENDS here;
%mend zzz_include;
