%{
    #include <stdio.h>

    #define YYSTYPE float
%}

%token LICZBA
%token ID

%left '-' '+'
%left '*' '/'
%nonassoc NEG

%{
   #include <stdio.h>
%}


%%

wyr0 : wyr { printf("=%f", $1); }

wyr  :  wyr '+' wyr { $$ = $1 + $3; }
     |  wyr '-' wyr { $$ = $1 - $3; }
     |  wyr '*' wyr { $$ = $1 * $3; } 
     |  wyr '/' wyr { $$ = $1 / $3; } 
     |  '(' wyr ')' { $$ = $2; } 
     |  '-' wyr     { $$ = - $2; }       %prec NEG 
     |  LICZBA      { $$ = $1; printf("<%f>",$1);} 
     ;

%%

int yyerror(char* s)
{ printf("%s\n",s); return 1; }

int main()
{ yyparse(); }
