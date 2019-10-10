/* TRANSLACJA STEROWANA SK£ADNI¡ */

/* translator przetwarzaj±cy wyra¿enie regularne   */
/* na automat w notacji zgodnej z AT&T FSM Library */

%{
    #include <stdio.h>
    int s=1;
%}

%union { char sym;  struct { int i,f; } aut; }

%nonassoc '('
%nonassoc <sym> SYMBOL
%left '|'
%left CONCAT
%right '*'

%type <aut> re

%%

input : re      { printf("%d\t%d\t%s\n", 0, $1.i, "<epsilon>"); 
		  printf("%d\n",$1.f); }
;


re
: SYMBOL	{ $$.i=s++; $$.f=s++;
		  printf("%d\t%d\t%c\n", $$.i, $$.f, $1); 
		}


| re '|' re	{ $$.i=s++; $$.f=s++;
		  printf("%d\t%d\t%s\n", $$.i, $1.i, "<epsilon>");
		  printf("%d\t%d\t%s\n", $$.i, $3.i, "<epsilon>");
		  printf("%d\t%d\t%s\n", $1.f, $$.f, "<epsilon>");
		  printf("%d\t%d\t%s\n", $3.f, $$.f, "<epsilon>");
		}

| re re		{ $$.i=$1.i; $$.f=$2.f;
		  printf("%d\t%d\t%s\n", $1.f, $2.i, "<epsilon>");
		} %prec CONCAT

| re '*'	{ $$.i=$1.i; $$.f=$1.f;
		  printf("%d\t%d\t%s\n", $$.i, $$.f, "<epsilon>");
		  printf("%d\t%d\t%s\n", $$.f, $$.i, "<epsilon>");
		}

| '(' re ')'    { $$.i=$2.i; $$.f=$2.f; }
;

%%

yyerror(char* s)
{
  printf("%s\n",s);
}

main()
{
  yyparse();
}
