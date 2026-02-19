%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

/* tipo semántico */
%union {
    long val;
}

/* tokens */
%token <val> NUMBER
%token EOL
%token ABS
%token AND
%token OR

/* precedencias */
%left OR
%left AND
%left '+' '-'
%left '*' '/'
%right UMINUS

%type <val> expr

%%

input:
      /* vacío */
    | input line
    ;

line:
      EOL
    | expr EOL { printf("= %ld (0x%lX)\n", $1, $1); }
    ;

expr:
      NUMBER              { $$ = $1; }
    | expr '+' expr       { $$ = $1 + $3; }
    | expr '-' expr       { $$ = $1 - $3; }
    | expr '*' expr       { $$ = $1 * $3; }
    | expr '/' expr       { $$ = $1 / $3; }
    | '-' expr %prec UMINUS { $$ = -$2; }

    /* valor absoluto con |expr| */
    | ABS expr ABS        { $$ = ($2 >= 0) ? $2 : -$2; }

    /* operadores bit a bit */
    | expr AND expr       { $$ = $1 & $3; }
    | expr OR expr        { $$ = $1 | $3; }

    | '(' expr ')'        { $$ = $2; }
    ;

%%

void yyerror(const char *s)
{
    fprintf(stderr, "Error: %s\n", s);
}

int main(void)
{
    return yyparse();
}
