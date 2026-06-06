%option noyywrap case-insensitive
%{
#include "telnet.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%%

"IAC"                    { return IAC; }
"DO"                     { return DO_; }
"DONT"                   { return DONT; }
"WILL"                   { return WILL; }
"WONT"                   { return WONT; }

"ECHO"                   { yylval.str = strdup("ECHO");                  return OPTION; }
"SUPPRESS-GO-AHEAD"      { yylval.str = strdup("SUPPRESS-GO-AHEAD");     return OPTION; }
"TERMINAL-TYPE"          { yylval.str = strdup("TERMINAL-TYPE");         return OPTION; }
"NAWS"                   { yylval.str = strdup("NAWS");                  return OPTION; }
"LINEMODE"               { yylval.str = strdup("LINEMODE");              return OPTION; }
"NEW-ENVIRON"            { yylval.str = strdup("NEW-ENVIRON");           return OPTION; }
"STATUS"                 { yylval.str = strdup("STATUS");                return OPTION; }
"BINARY"                 { yylval.str = strdup("BINARY");                return OPTION; }
"SGA"                    { yylval.str = strdup("SGA");                   return OPTION; }

[a-zA-Z0-9_!.,:;()'\-]+   {
    yylval.str = strdup(yytext);
    return WORD;
}

[ \t\r]+                 { /* skip whitespace */ }

\r?\n                    { return NEWLINE; }

.                        { /* ignore unknown characters */ }

%%

