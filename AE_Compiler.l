%{ 
#include"hello.tab.c"

int num;
%} 
digit [0-9]
number {digit}+
%%
{number}  { num = atoi(yytext); return NUMBER; }
"+"       { return PLUS; }
"-"       { return MINUS; }
"*"       { return MULTIPLY; }
"/"       { return DIVIDE; }
"\n"      { return NEW_LINE; }
"("       { return LEFT_PARENTHESES; }
")"       { return RIGHT_PARENTHESES; }
%% 
int yywrap(){} 
int main(){ 
       printf("%d\n", yylex()); 
       return 0; 
}