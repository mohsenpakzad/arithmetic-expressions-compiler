%{ 
    #include"headers.h"

    int yylex();
    void yyerror(const char *);
    extern int currentVariableIndex;
    struct Phrase extractVariableAndIncreaseIndex();
%}

%token NUMBER
%token PLUS MINUS MULTIPLY DIVIDE
%token LEFT_PARENTHESES RIGHT_PARENTHESES
%token NEW_LINE

%start stmts
%% 
stmts:
    /* empty */ {
        puts("Goodbye, and don't pay attention to this error!");
    }
    | stmt stmts
;
stmt:
    expr NEW_LINE {
        printf("print %s\n", $1.value);
        puts("------------------------------------------");
        // currentVariableIndex = 0; // reset index or not?
    }
;
expr:
    expr PLUS term {
        printf("Assign %s Plu %s to t%d\n", $1.value, $3.value, currentVariableIndex);
        $$ = extractVariableAndIncreaseIndex();
    } 
    | expr MINUS term {
        printf("Assign %s Min %s to t%d\n", $1.value, $3.value, currentVariableIndex);
        $$ = extractVariableAndIncreaseIndex(); 
    }
    | term {
        $$ = $1;
    }
;
term:
    term MULTIPLY factor {
        printf("Assign %s Mul %s to t%d\n", $1.value, $3.value, currentVariableIndex);
        $$ = extractVariableAndIncreaseIndex(); 
    }
    | term DIVIDE factor {
        printf("Assign %s Div %s to t%d\n", $1.value, $3.value, currentVariableIndex);
        $$ = extractVariableAndIncreaseIndex();
    }
    | factor {
        $$ = $1;
    }
;
factor: 
    NUMBER {
        $$ = $1;
    } 
    | LEFT_PARENTHESES expr RIGHT_PARENTHESES {
        $$ = $2;
    }
;
%%
int currentVariableIndex = 0;

struct Phrase extractVariableAndIncreaseIndex() {
    char newVar[MAX_PHARASE_VALUE_SIZE];
    sprintf(newVar, "t%d", currentVariableIndex++);
    return newPhrase(newVar); 
}

void yyerror(const char *str) {
    fprintf(stderr, "Error: %s\n", str);
}

int main() {
    yyparse();
}