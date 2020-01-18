%token LICZBA;
%token JESLI;
%token UMIESC
%token W
%token ZMIENNA
%token STALA
%token POKAZ
%token JEST
%token ZMIENNOM
%token DLA
%token OD
%token DO
%token WYKONAJ
%token DOTAD

%left '+' '-'
%left '*' '/'


%%


program : { printf(".sub main\n");
	    printf(".local pmc stos\n");
            printf("    stos = new 'ResizableFloatArray'\n");
            printf(".local num tmp\n");
            printf(".local num tmp2\n");
            printf(".local num tmp3\n");
	  }
          instrukcje
          { printf(".end\n"); } ;

instrukcje : instrukcja
           | instrukcja instrukcje
           ;

instrukcja : przypisanie
           | deklaracja_zmiennej
           | drukowanie
           | petladla
           ;

deklaracja_zmiennej : ZMIENNA JEST ZMIENNOM { printf(".local num %c\n",$1); } ;

przypisanie : UMIESC wyrazenie W ZMIENNA { printf("pop tmp,stos\n%c = tmp\n",$4); } ;

drukowanie : POKAZ wyrazenie {printf("pop tmp,stos\nsay tmp\n");} ;

petladla : DLA
           ZMIENNA
           OD
           wyrazenie
           {
             printf("pop tmp,stos\n%c = tmp\nBEGINLOOP:\n",$2);
           }
           DO
           wyrazenie
           { 
             printf("pop tmp,stos\n");
             printf("if %c > tmp goto ENDLOOP\n",$2); 
           }
           WYKONAJ
           instrukcje
           DOTAD
           {
             printf("inc %c\n",$2);
             printf("goto BEGINLOOP\n");
             printf("ENDLOOP:\n");
           }
           ;


wyrazenie : LICZBA { printf("push stos,%d.0\n",$1); }
          | STALA
          | ZMIENNA { printf("push stos,%c\n",$1); }
          | wyrazenie '+' wyrazenie   { printf("pop tmp2,stos\npop tmp3,stos\n tmp=tmp2+tmp3\n push stos,tmp\n"); }
          | wyrazenie '-' wyrazenie   { printf("pop tmp2,stos\npop tmp3,stos\n tmp=tmp3-tmp2\n push stos,tmp\n"); }
          | wyrazenie '*' wyrazenie   { printf("pop tmp2,stos\npop tmp3,stos\n tmp=tmp2*tmp3\n push stos,tmp\n"); }
          | wyrazenie '/' wyrazenie   { printf("pop tmp2,stos\npop tmp3,stos\n tmp=tmp3/tmp2\n push stos,tmp\n"); }
          ;


%%

int main() { yyparse(); }

int yyerror(char* s) { printf("BŁĄD SKŁADNIOWY!\n"); }
