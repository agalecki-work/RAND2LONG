%macro populate_stmnt;
 /* Inserted into data step  */
 if c1 = ":" then DO;
  do i = 1 to dim(_waves);
   tmpci = _waves{i};
   if dispatch ne "" then tmpci = strip(dispatch)||strip(tmpci);
   _waves{i} = strip(tmpci);
  end;
 END;
 drop tmpci;
%mend populate_stmnt;
