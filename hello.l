%{ 
#define NUMBER 256
#define PLUS 257
#define MINUS 258
#define DIVIDE 259
#define MULTIPLY 260
#define NEW_LINE 261
#define LEFT_PARENTHESES 262
#define RIGHT_PARENTHESES 263

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