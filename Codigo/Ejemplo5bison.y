/* calculadora simple con bison */
%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

/* tokens que llegan desde flex */
%token NUMBER
%token ADD SUB MUL DIV ABS
%token EOL

%%

calclist:
      /* vacío */
    | calclist exp EOL { printf("= %d\n", $2); }
    ;

exp:
      factor
    | exp ADD factor { $$ = $1 + $3; }
    | exp SUB factor { $$ = $1 - $3; }
    ;

factor:
      term
    | factor MUL term { $$ = $1 * $3; }
    | factor DIV term { $$ = $1 / $3; }
    ;

term:
      NUMBER
    | ABS term { $$ = ($2 >= 0) ? $2 : -$2; }
    ;

%%

int main(void)
{
    return yyparse();
}

void yyerror(const char *s)
{
    fprintf(stderr, "error: %s\n", s);
}
