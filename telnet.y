%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);
%}

%union { char *str; }

%token IAC
%token DO_ DONT WILL WONT
%token <str> OPTION WORD
%token NEWLINE

%type <str> command option body iac_line

%%

input:
    /* empty */
  | input line
  ;

line:
    iac_line NEWLINE     { printf("[IAC] %s\n", $1); free($1); }
  | body NEWLINE         { printf("[Body] %s\n", $1); free($1); }
  | NEWLINE              { /* blank */ }
  ;

iac_line:
    IAC command option {
        size_t n=strlen($2)+strlen($3)+2;
        char *s=malloc(n);
        snprintf(s,n,"%s %s",$2,$3);
        free($2); free($3);
        $$=s;
    }
  ;

command:
    DO_   { $$ = strdup("DO"); }
  | DONT  { $$ = strdup("DONT"); }
  | WILL  { $$ = strdup("WILL"); }
  | WONT  { $$ = strdup("WONT"); }
  ;

option:
    OPTION { $$ = $1; }
  | WORD   { $$ = $1; }
  ;

body:
    WORD { $$ = $1; }
  | body WORD {
        size_t n = strlen($1)+strlen($2)+2;
        char *s = malloc(n);
        snprintf(s,n,"%s %s",$1,$2);
        free($1); free($2);
        $$ = s;
    }
  ;

%%

void yyerror(const char *s) { fprintf(stderr,"Parse error: %s\n", s); }
int main(void) { return yyparse(); }
