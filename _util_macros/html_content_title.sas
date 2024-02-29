%macro html_content_title(title);
 proc template;
  define style styles.custom;
    parent=styles.HTMLBlue;
    class ContentTitle /
      just=center
      font_weight=bold
      font_size=10pt
      color=black
      background=white
      textdecoration=underline
      pretext="<h1> &title </h1>";
  end;
run; 
%mend html_content_title;
