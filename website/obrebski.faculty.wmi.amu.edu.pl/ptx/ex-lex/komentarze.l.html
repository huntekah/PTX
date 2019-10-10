DIGIT	[0-9]
LETTER	[a-zA-Z]


%s INLINECOMMENT INCOMMENT

%%

<INITIAL>{DIGIT}*              printf("liczba");
<INITIAL>{LETTER}*	       printf("s³owo");

<INITIAL>[#]                   ECHO; BEGIN(INLINECOMMENT);
<INLINECOMMENT>\n              ECHO; BEGIN(INITIAL);
<INLINECOMMENT>.               ECHO;

<INITIAL>"/*"                  ECHO; BEGIN(INCOMMENT);
<INCOMMENT>(.|\n)              ECHO;
<INCOMMENT>"*/"                ECHO; BEGIN(INITIAL);
