%{
int label_id=0;
int block_id=0;
%}
%union {    char*    sval;
            int     ival;
        }
%token OBCZAJ;
%token ROWNA_SIE;
%token ZMIENNA;
%token ZAPAMIETAJ;
%token LICZBA;
%token STALA;
%token POKAZ

%token GDYBY;
%token TAK;
%token CO;
%token WTEDY;
%token ALBO;

%token OPERATOR_MNIEJSZOSCI;
%token OPERATOR_ROWNOSCI;

%token OD;
%token DO;
%token DAWAJ;
%token JUZ;
%token LBRACK;
%token RBRACK;

%left '+' '-'
%left '*' '/'

%type<sval> ZMIENNA STALA OPERATOR_ROWNOSCI OPERATOR_MNIEJSZOSCI operator_porownania;
%type<ival> wyrazenie LICZBA;

%%


program : { printf(".sub main\n");
	    printf(".local pmc stos\n");
        printf("    stos = new 'ResizableFloatArray'\n");
        printf(".local num tmp\n");
        printf(".local num tmp1\n");
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
           | deklaracja_stalej
           | petla_for
           | instrukcja_warunkowa
           | drukowanie
           ;

przypisanie : ZMIENNA ROWNA_SIE wyrazenie { printf("pop tmp,stos\n%s = tmp\n",$1); } ;

deklaracja_zmiennej : OBCZAJ ZMIENNA { printf(".local num %s\n",$2); } ;

deklaracja_stalej : ZAPAMIETAJ STALA ROWNA_SIE wyrazenie { 
                  printf("pop tmp,stos\n.local num %s\n %s = tmp\n",$2,$2); };


drukowanie : POKAZ wyrazenie {printf("pop tmp,stos\nsay tmp\n");} ;

wyrazenie : LICZBA { printf("push stos,%d.0\n",$1); }
          | STALA { printf("push stos,%s\n",$1); }
          | ZMIENNA { printf("push stos,%s\n",$1); }
          | wyrazenie '+' wyrazenie   { printf("pop tmp2,stos\npop tmp3,stos\n tmp=tmp2+tmp3\n push stos,tmp\n"); }
          | wyrazenie '-' wyrazenie   { printf("pop tmp2,stos\npop tmp3,stos\n tmp=tmp3-tmp2\n push stos,tmp\n"); }
          | wyrazenie '*' wyrazenie   { printf("pop tmp2,stos\npop tmp3,stos\n tmp=tmp2*tmp3\n push stos,tmp\n"); }
          | wyrazenie '/' wyrazenie   { printf("pop tmp2,stos\npop tmp3,stos\n tmp=tmp3/tmp2\n push stos,tmp\n"); }
          ;

petla_for :
           LBRACK 
            { printf("# FOR #\n"); }
           ZMIENNA
           OD
           wyrazenie
           {
             printf("pop tmp,stos\n.local num %s\n%s = tmp\nBEGINLOOP%s:\n",$3,$3,$3);
           }
           DO
           wyrazenie
           { 
             printf("pop tmp,stos\n");
             printf("if %s > tmp goto ENDLOOP%s\n",$3,$3); 
           }
           RBRACK
           DAWAJ
           instrukcje
           JUZ
           {
             printf("inc %s\n",$3);
             printf("goto BEGINLOOP%s\n",$3);
             printf("ENDLOOP%s:\n",$3);
           }
           ;

operator_porownania : OPERATOR_ROWNOSCI
                    | OPERATOR_MNIEJSZOSCI
                    ;

instrukcja_warunkowa :  
                     instrukcja_gdyby CO 
                       {printf("NIC_JUZ_NIE_ROB%d:\n",block_id); block_id+=1;}
                     | instrukcja_gdyby instrukcje_albo CO 
                       { printf("NIC_JUZ_NIE_ROB%d:\n",block_id);block_id +=1;}
                     ;

instrukcja_gdyby : 
                 GDYBY
                 TAK
                 cialo_warunkowe
                ;

cialo_warunkowe :
                 wyrazenie
                 operator_porownania
                 wyrazenie
                    {
                    label_id+=1;
                    printf("pop tmp1,stos\n");
                    printf("pop tmp,stos\n");
                    printf("if tmp %s tmp1 goto ROB_GDYBA%d\n",$2,label_id);
                    printf("goto NIEROB_GDYBA%d\n",label_id);
                    printf("ROB_GDYBA%d:\n",label_id);
                    }
                 WTEDY
                 instrukcje
                    {
                    printf("goto NIC_JUZ_NIE_ROB%d\n",block_id);
                    printf("NIEROB_GDYBA%d:\n",label_id);
                    }
                 ;

instrukcje_albo : instrukcja_albo
                | instrukcja_albo instrukcje_albo
                ;

instrukcja_albo : ALBO cialo_warunkowe
                ;
                

%%

int main() { yyparse(); }

int yyerror(char* s) { printf("TEJ NO NIE ŻARTUJ SOBIE. TO PRZECIEZ ZLE JEST!\n"); }
