%{ 
    #include"headers.h"

    int yylex();
    void yyerror(const char *);
    extern int currentVariableIndex;// unnecessary
    struct Phrase extractVariableAndIncreaseIndex();
%}
%token OND_DIGIT_NUMBER TWO_DIGIT_NUMBER THREE_DIGIT_NUMBER FOUR_DIGIT_NUMBER FIVE_DIGIT_NUMBER SIX_DIGIT_NUMBER
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
    | character_number NEW_LINE {
        printf("Assign %s to t%d;\n", $1.value, currentVariableIndex);
        printf("print t%d\n",currentVariableIndex);
        puts("------------------------------------------");
    }
;
expr:
    expr PLUS term {
        printf("Assign %s Plu %s to t%d\n", $1, $3, currentVariableIndex);
        $$ = extractVariableAndIncreaseIndex();
    } 
    | expr MINUS term {
        printf("Assign %s Min %s to t%d\n", $1, $3, currentVariableIndex);
        $$ = extractVariableAndIncreaseIndex(); 
    }
    | term {
        $$ = $1;
    }
;
term:
    term MULTIPLY factor {
        printf("Assign %s Mul %s to t%d\n", $1, $3, currentVariableIndex);
        $$ = extractVariableAndIncreaseIndex(); 
    }
    | term DIVIDE factor {
        printf("Assign %s Div %s to t%d\n", $1, $3, currentVariableIndex);
        $$ = extractVariableAndIncreaseIndex();
    }
    | factor {
        $$ = $1;
    }
;
 /* OND_DIGIT_NUMBER TWO_DIGIT_NUMBER THREE_DIGIT_NUMBER FOUR_DIGIT_NUMBER FIVE_DIGIT_NUMBER SIX_DIGIT_NUMBER */
factor: 
    OND_DIGIT_NUMBER {
        char newNumber[MAX_PHARASE_VALUE_SIZE];
        sprintf(newNumber, "%s", $1);
        $$ = newNumber;
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
    return newVar; 
}

int digitName(char *str, char *digit){
	switch(digit[0])
	{
		case '0':
			strcpy(str, "Zero");
			return 0;
		case '1':
			strcpy(str, "One");
			return 1;
		case '2':
			strcpy(str, "Two");
			return 2;
		case '3':
			strcpy(str, "Three");
			return 3;
		case '4':
			strcpy(str, "Four");
			return 4;
		case '5':
			strcpy(str, "Five");
			return 5;	
		case '6':
			strcpy(str, "Six");
			return 6;
		case '7':
			strcpy(str, "Sevev");
			return 0;
		case '8':
			strcpy(str, "Eight");
			return 8;
		case '9':
			strcpy(str, "Nine");
			return 9;
	}
}

void yyerror(const char *str) {
    fprintf(stderr, "Error: %s\n", str);
}

int main() {
    yyparse();
}