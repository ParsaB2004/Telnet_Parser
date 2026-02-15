%option noyywrap
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

"ECHO"                   { yylval.str = strdup("ECHO"); return OPTION; }
"SUPPRESS-GO-AHEAD"      { yylval.str = strdup("SUPPRESS-GO-AHEAD"); return OPTION; }

[a-zA-Z0-9_!.,:;()'\-]+   {
    yylval.str = strdup(yytext);
    return WORD;
}

[ \t\r]+                 { /* skip */ }

\r?\n                    { return NEWLINE; }

.                        { /* ignore */ }

%%

