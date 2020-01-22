%token VERTEX EDGE 
%token <s> NAME STRING

%union { char s[100]; }

%%

graph : { printf("digraf noname {\n"); } vertices edges { printf("}\n");};

vertices : 
         | vertices vertex
         ;

vertex : VERTEX NAME STRING { printf("%s [label=%s]",$2,$3);};

edges :
      | edges edge
      ;

edge : EDGE NAME NAME STRING ;

%%
int yyerror(char* s){ printf("%s\n",s);}

int main() { yyparse(); }
