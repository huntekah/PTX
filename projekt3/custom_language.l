
%{
   #include "custom_language.tab.h"
%}

%%

[0-9]+               yylval.ival=atoi(yytext); return LICZBA;

==                yylval.sval=strdup(yytext); return OPERATOR_ROWNOSCI;
obczaj              return OBCZAJ;
=                   return ROWNA_SIE;
zapamietaj          return ZAPAMIETAJ;

od                  return OD;
do                  return DO;
dawaj               return DAWAJ;
juz                 return JUZ;
"("                 return LBRACK;
")"                 return RBRACK;

gdyby               return GDYBY;
tak                 return TAK;
"co?"               return CO;
wtedy               return WTEDY;
albo                return ALBO;

[+*/-]              return *yytext;
[<>]                yylval.sval=strdup(yytext); return OPERATOR_MNIEJSZOSCI;
pokaz               return POKAZ;

[a-z]([a-zA-Z0-9])*  yylval.sval=strdup(yytext); return ZMIENNA;

[A-Z]+               yylval.sval=strdup(yytext); return STALA;


[ \n\t]              ;

.                    printf("BŁĄD LEKSYKALNY!\n"); exit(1);
