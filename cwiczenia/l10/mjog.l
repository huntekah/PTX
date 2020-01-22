%{
    #include "mjog.tab.h"
    #include <string.h>
%}

%%

v               return VERTEX;
e               return EDGE;
\"[^"]*\"       strcpy(yylval.s,yytext); return STRING;
[0-9a-zA-Z_]+   strcpy(yylval.s,yytext); return NAME;

[ \t\n]         ;
.               fprintf(stderr,"BLAD LEKSYKALNY\n"); exit(1);
