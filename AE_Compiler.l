%{ 
    #include"headers.h"
    #include"AE_Compiler.tab.h"
%}
%option noyywrap


digit [0-9]
one_digit_number   {digit}{1}
two_digit_number   {digit}{2}
three_digit_number {digit}{3}
four_digit_number  {digit}{4}
five_digit_number  {digit}{5}
six_digit_number   {digit}{6}
%%     
{one_digit_number}   { yylval = newPhrase(yytext); return OND_DIGIT_NUMBER; }
{two_digit_number}   { yylval = newPhrase(yytext); return TWO_DIGIT_NUMBER; }
{three_digit_number} { yylval = newPhrase(yytext); return THREE_DIGIT_NUMBER; }
{four_digit_number}  { yylval = newPhrase(yytext); return FOUR_DIGIT_NUMBER; }
{five_digit_number}  { yylval = newPhrase(yytext); return FIVE_DIGIT_NUMBER; }
{six_digit_number}   { yylval = newPhrase(yytext); return SIX_DIGIT_NUMBER; }
"+"                  { return PLUS; }
"-"                  { return MINUS; }
"*"                  { return MULTIPLY; }
"/"                  { return DIVIDE; }
"("                  { return LEFT_PARENTHESES; }
")"                  { return RIGHT_PARENTHESES; }
"\n"                 { return NEW_LINE; }
