%{
#include "Ejercicio3bison.tab.h"
#include <stdlib.h>
%}

%%

"+"        { return '+'; }
"-"        { return '-'; }
"*"        { return '*'; }
"/"        { return '/'; }

"|"        { return ABS; }
"&"        { return AND; }
"||"       { return OR; }

0x[0-9a-fA-F]+  {
    yylval.val = strtol(yytext, NULL, 16);
    return NUMBER;
}

[0-9]+ {
    yylval.val = strtol(yytext, NULL, 10);
    return NUMBER;
}

\n         { return EOL; }

[ \t]+     ;

.          { printf("Caracter desconocido: %s\n", yytext); }

%%
