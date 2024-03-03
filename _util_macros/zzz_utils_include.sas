%macro zzz_utils_include;
%put ===> Macro `zzz_utils_include` STARTS here;
/*-- `attrn_nlobs` */
%put  - macro `attrn_nlobs`;
%include _macros(attrn_nlobs);

/*--- ` attrn_nvars` --- */
%put  - macro `attrn_nvars`;
%include _macros(attrn_nvars);

/*-- `varExist` */
%put  - macro `varExist`;
%include _macros(varExist);


/*-- `checkdupkey` */
%put  - macro `checkdupkey`;
%include _macros(checkdupkey);


/*-- `CheckLog` */
%put  - macro `CheckLog`;
%include _macros(CheckLog);

/*-- `CheckLog_dir` */
%put  - macro `CheckLog_dir`;
%include _macros(CheckLog_dir);

/*-- `contents_data` */
%put  - macro `contents_data`;
%include _macros(contents_data);
/*-- `isBlank` */
%put  - macro `isBlank`;
%include _macros(isBlank);

/*-- `traceit_print` */
%put  - macro `traceit_print`;
%include _macros(traceit_print);

/*-- `traceit_contents` */
%put  - macro `traceit_contents`;
%include _macros(traceit_contents);

/*-- `traceit` */
%put  - macro `traceit`;
%include _macros(traceit);

/*-- `html_content_title` */
%put  - macro `html_content_title`;
%include _macros(html_content_title);


%put --- Macro `zzz_utils_include` ENDS here;
%put;

%mend zzz_utils_include;