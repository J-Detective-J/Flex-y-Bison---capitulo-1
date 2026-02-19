%{
#include "Ejemplo5bison.tab.h"
#include <stdlib.h>
%}

%%

"+"        { return ADD; }
"-"        { return SUB; }
"*"        { return MUL; }
"/"        { return DIV; }
"|"        { return ABS; }

[0-9]+     { yylval = atoi(yytext); return NUMBER; }
\n         { return EOL; }

[ \t]+     { /* ignorar espacios */ }

.          { printf("Caracter desconocido: %s\n", yytext); }

%%
