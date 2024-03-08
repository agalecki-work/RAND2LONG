%macro print_datasets(dataset_list,lib= WORK, var =, title_template = %str(DATA @));
    %let dataset_count = %sysfunc(countw(&dataset_list, ' '));

    %do i = 1 %to &dataset_count;
        %let dataset_name = %scan(&dataset_list, &i);
        %let titl =;
        data _null_;
          length titl $255;
          titl = tranwrd("&title_template", "@", "&dataset_name"); 
          call symputx("titl", titl);
        run;
        
        Title "&titl";
        proc print data=&lib..&dataset_name noobs;
        var  &var;
        run;
    %end;
%mend print_datasets;

