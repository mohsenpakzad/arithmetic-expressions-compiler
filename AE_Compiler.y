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
    expr PLUS term {
        printf("Assign %s Plu %s to t%d\n", $1, $3, getCurrentVariableIndex());
    } 
    | expr MINUS term {
        printf("Assign %s Min %s to t%d\n", $1, $3, getCurrentVariableIndex());
    }
    | term 
;
term:
    term MULTIPLY factor {
        printf("Assign %s Mul %s to t%d\n", $1, $3, getCurrentVariableIndex());
    }
    | term DIVIDE factor {
        printf("Assign %s Div %s to t%d\n", $1, $3, getCurrentVariableIndex());
    }
    | factor
;
factor: 
    NUMBER 
    | LEFT_PARENTHESES expr RIGHT_PARENTHESES
;
%%
int currentVariableIndex = 0;

int getCurrentVariableIndex(){
    return currentVariableIndex++;
}

int yyerror(char *s) {
  printf("%s\n", s);
}

int main() {
    if (yyparse())
        fprintf(stdout, "Successful parsing.\n");
    else
        fprintf(stderr, "error found.\n");
}