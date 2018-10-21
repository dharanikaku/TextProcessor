%{
#include <stdio.h>
#include<stdlib.h>
#include <string.h>
#include "y.tab.h"


%}



%%


[0-9a-zA-Z]+  {yylval.p=strdup(yytext); return ip;}
[\^\&\*\?\%\~] {return yytext[0];}
[\@\#\=] {return yytext[0];}
[\<] {return yytext[0];}
[\>] {return yytext[0];}
[ \t\f\v] {;}
[\n] {return NEWLINE;}
[\(] {return yytext[0];}
[\)] {return yytext[0];}


%%

int yywrap() { return 1;}


