%{ 
    #include "shared.h"

    int yylex();
    void yyerror(const char *);
    struct String nextVar(); /* Navid chose this function name! */

    extern int currentVariableIndex;
%}
%token NUMBER
%token PLUS MINUS MULTIPLY DIVIDE
%token LEFT_PARENTHESES RIGHT_PARENTHESES
%token NEW_LINE

%start stmts
%% 
stmts:
    /* empty */ {
        puts("Goodbye");
    }
    | stmt stmts
;
stmt:
    expr NEW_LINE {
        printf("print %s\n", $1.value);
        puts("------------------------------------------");
        currentVariableIndex = 1; //reset starting index
    }
    | NUMBER NEW_LINE {
        printf("Assign %s to t%d;\n", $1.value, currentVariableIndex);
        printf("print t%d\n",currentVariableIndex);
        puts("------------------------------------------");
    }
;
expr:
    expr PLUS term {
        printf("Assign %s Plu %s to t%d\n", $1.value, $3.value, currentVariableIndex);
        $$ = nextVar();
    } 
    | expr MINUS term {
        printf("Assign %s Min %s to t%d\n", $1.value, $3.value, currentVariableIndex);
        $$ = nextVar(); 
    }
    | term {
        $$ = $1;
    }
;
term:
    term MULTIPLY factor {
        printf("Assign %s Mul %s to t%d\n", $1.value, $3.value, currentVariableIndex);
        $$ = nextVar(); 
    }
    | term DIVIDE factor {
        printf("Assign %s Div %s to t%d\n", $1.value, $3.value, currentVariableIndex);
        $$ = nextVar();
    }
    | factor {
        $$ = $1;
    }
;
factor: 
    NUMBER
    | LEFT_PARENTHESES expr RIGHT_PARENTHESES {
        $$ = $2;
    }
;
%%
int currentVariableIndex = 1;

struct String nextVar() {
    char newVar[MAX_STRING_VALUE_SIZE];
    sprintf(newVar, "t%d", currentVariableIndex++);
    return newString(newVar); 
}

void yyerror(const char *str) {
    fprintf(stderr, "Error: %s\n", str);
}

int main() {
    yyparse();
}