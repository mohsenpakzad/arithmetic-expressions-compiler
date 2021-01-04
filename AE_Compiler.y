%{ 
    #include"headers.h"
%}
%token NUMBER
%token PLUS MINUS MULTIPLY DIVIDE
%token LEFT_PARENTHESES RIGHT_PARENTHESES
%token NEW_LINE

%start stmts
%% 
stmts:
    /* empty */ | stmt stmts
;
stmt: 
    expr NEW_LINE
;
expr:
    expr PLUS term | expr MINUS term | term
;
term:
    term MULTIPLY factor | term DIVIDE factor | factor
;
factor: 
    NUMBER | LEFT_PARENTHESES expr RIGHT_PARENTHESES
;
%% 

int main() {
    if (yyparse())
        fprintf(stdout, "Successful parsing.\n");
    else
        fprintf(stderr, "error found.\n");
}