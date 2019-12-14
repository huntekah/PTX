%{
    #include <stdio.h>
    #include <math.h>
    int line_num=1;
%}

%x KOMENTARZ


ID      [a-z][a-z0-9]*
DIGIT   [0-9]
%%


"/*" BEGIN(KOMENTARZ);


"void" printf("SK_VOID\t%s\n",yytext);
if|else|"else if" printf("CONDITIONAL_STATEMENT\t%s\n",yytext);

"(" printf("%d\tLEFT_BRACKET\t%s\n",line_num,yytext);
")" printf("%d\tRIGHT_BRACKET\t%s\n",line_num,yytext);
"{" printf("%d\tLEFT_CURLY_BRACKET\t%s\n",line_num,yytext);
"}" printf("%d\tRIGHT_CURLY_BRACKET\t%s\n",line_num,yytext);
"[" printf("%d\tLEFT_SQUARE_BRACKET\t%s\n",line_num,yytext);
"]" printf("%d\tRIGHT_SQUARE_BRACKET\t%s\n",line_num,yytext);
"for" printf("%d\tLOOP\t%s\n",line_num,yytext);
"=" printf("%d\tASSIGN_OP\t%s\n",line_num,yytext);
"==" printf("%d\tCOMPARE_OP\t%s\n",line_num,yytext);
"!=" printf("%d\tNOT_EQUAL_OP\t%s\n",line_num,yytext);
">=" printf("%d\tGT_OP\t%s\n",line_num,yytext);
"<=" printf("%d\tLT_OP\t%s\n",line_num,yytext);
"++" printf("%d\tINC_OP\t%s\n",line_num,yytext);
int printf("%d\tSK_INT\t%s\n",line_num,yytext);
float printf("%d\tSK_FLOAT\t%s\n",line_num,yytext);
char printf("%d\tSK_CHAR\t%s\n",line_num,yytext);
const printf("%d\tSK_CONST\t%s\n",line_num,yytext);
; printf("%d\tSEMICOLON\t%s\n",line_num,yytext);
"//".* printf("%d\tLINE_COMMENT\t%s\n",line_num,yytext);

{ID} printf("%d\tID\t%s\n",line_num,yytext);
{DIGIT}+ printf("%d\tINT_CONST\t%s\n",line_num,yytext);
{DIGIT}+"."{DIGIT}* printf("%d\tFLOAT_CONST\t%s(%g)\n",line_num,yytext,atof(yytext));
"\"".*"\""  printf("%d\tSTRING_CONST\t%s\n",line_num,yytext);

[ \t]*

<*>\n line_num++;

. fprintf(stderr, "Lexical Error line: %d in string \'%s\'\n",line_num, yytext); exit(1);

<KOMENTARZ>"*/" BEGIN(INITIAL);
<KOMENTARZ>. ;
<KOMENTARZ><<EOF>> fprintf(stderr, "EOF in the comments %d.\n",line_num); exit(1);


%%
int main(int argc,char** argv )
    {
    ++argv, --argc;  /* skip over program name */
    if ( argc > 0 )
            yyin = fopen( argv[0], "r" );
    else
            yyin = stdin;

    yylex();
    }
