%{ 
    #include"headers.h"
    #include"AE_Compiler.tab.h"
%}
%option noyywrap


digit [0-9]
number {digit}+
%%
{number}  { yylval = newPhrase(yytext); return NUMBER; }
"+"       { return PLUS; }
"-"       { return MINUS; }
"*"       { return MULTIPLY; }
"/"       { return DIVIDE; }
"("       { return LEFT_PARENTHESES; }
")"       { return RIGHT_PARENTHESES; }
"\n"      { return NEW_LINE; }
