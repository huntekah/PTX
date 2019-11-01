 
HELP_ME_PLEASE= <<HEREDOC
  --help, -h      show this help message
  --file, -f      specify the file that should be read
  --author, -a    show the author of the code
  --recurrent, -r use the recurrent mode (recommended, cause this is how C preprocessor works)

  To run preprocessing type:
    ruby preprocessor.rb filename
  You can give it either the switch -r to use recursive substitution (correct behaviur)
  or just leav it be and let the program swap the first occurence of defined variable. It works with defines like:

 #define A B 

 as well as with:

 #define A(B,C) (B+C) - 78(C+BB)
 
Please contact author for further instructions.
HEREDOC

AUTHOR= <<-HEREDOC 
 Author: Krzysztof Jurkiewicz 
 Indeks: 452088 
 e-mail: krzjur2@st.amu.edu.pl 
HEREDOC

