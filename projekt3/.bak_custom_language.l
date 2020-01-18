
%{
   #include "pjp.tab.h"
%}

%%

[0-9]+               yylval=atoi(yytext); return LICZBA;

jest                 return JEST;
zmienną              return ZMIENNOM;
jeśli                return JESLI;
umieść               return UMIESC;
w                    return W;
dla                  return DLA;
od                   return OD;
do                   return DO;
wykonaj              return WYKONAJ;
dotąd                return DOTAD;


[+*/-]               return *yytext;


[a-z]                yylval = *yytext; return ZMIENNA;

[A-Z]                yylval = *yytext; return STALA;

pokaż                return POKAZ;

[ \n\t]              ;

.                    printf("BŁĄD LEKSYKALNY!\n"); exit(1);
