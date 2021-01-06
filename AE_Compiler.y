%{ 
    #include"headers.h"

    int yylex();
    void yyerror(const char *);
    struct Phrase nextVar(); /* Navid chose this function name! */
    struct Phrase digitToDigitName(char); /* I (Mohsen) chose this function name! */
    void getDigitName(char *, char);

    extern int currentVariableIndex;
%}
%token ONE_DIGIT_NUMBER TWO_DIGIT_NUMBER THREE_DIGIT_NUMBER FOUR_DIGIT_NUMBER FIVE_DIGIT_NUMBER SIX_DIGIT_NUMBER
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
    | number NEW_LINE {
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
    number
    | LEFT_PARENTHESES expr RIGHT_PARENTHESES {
        $$ = $2;
    }
;
number:
    ONE_DIGIT_NUMBER {
        char newNumber[MAX_PHARASE_VALUE_SIZE];
        sprintf(newNumber, "%s", digitToDigitName($1.value[0]).value);
        $$ = newPhrase(newNumber);
    } 
    | TWO_DIGIT_NUMBER {
        char newNumber[MAX_PHARASE_VALUE_SIZE];
        sprintf(newNumber, "%sTen_%s", digitToDigitName($1.value[0]).value,
            digitToDigitName($1.value[1]).value);
        $$ = newPhrase(newNumber);
    } 
    | THREE_DIGIT_NUMBER {
        char newNumber[MAX_PHARASE_VALUE_SIZE];
        sprintf(newNumber, "%sHun_%sTen_%s", digitToDigitName($1.value[0]).value,
            digitToDigitName($1.value[1]).value,
            digitToDigitName($1.value[2]).value);
        $$ = newPhrase(newNumber);
    } 
    | FOUR_DIGIT_NUMBER {
        char newNumber[MAX_PHARASE_VALUE_SIZE];
        sprintf(newNumber, "(%s)Tou_%sHun_%sTen_%s", digitToDigitName($1.value[0]).value,
            digitToDigitName($1.value[1]).value,
            digitToDigitName($1.value[2]).value,
            digitToDigitName($1.value[3]).value);
        $$ = newPhrase(newNumber);
    } 
    | FIVE_DIGIT_NUMBER {
        char newNumber[MAX_PHARASE_VALUE_SIZE];
        sprintf(newNumber, "(%sTen_%s)Tou_%sHun_%sTen_%s", digitToDigitName($1.value[0]).value,
            digitToDigitName($1.value[1]).value,
            digitToDigitName($1.value[2]).value,
            digitToDigitName($1.value[3]).value,
            digitToDigitName($1.value[4]).value);
        $$ = newPhrase(newNumber);
    } 
    | SIX_DIGIT_NUMBER {
        char newNumber[MAX_PHARASE_VALUE_SIZE];
        sprintf(newNumber, "(%sHun_%sTen_%s)Tou_%sHun_%sTen_%s", digitToDigitName($1.value[0]).value,
            digitToDigitName($1.value[1]).value,
            digitToDigitName($1.value[2]).value,
            digitToDigitName($1.value[3]).value,
            digitToDigitName($1.value[4]).value,
            digitToDigitName($1.value[5]).value);
        $$ = newPhrase(newNumber);
    }
;
%%
int currentVariableIndex = 1;

struct Phrase nextVar() {
    char newVar[MAX_PHARASE_VALUE_SIZE];
    sprintf(newVar, "t%d", currentVariableIndex++);
    return newPhrase(newVar); 
}

struct Phrase digitToDigitName(char digit) {
    char newNumber[MAX_NUM_SIZE];
    getDigitName(newNumber, digit);
    return newPhrase(newNumber);
}

void getDigitName(char *result, char digit) {
	switch(digit) {
		case '0':
			strcpy(result, "Zer");
            break;
		case '1':
			strcpy(result, "One");
			break;
		case '2':
			strcpy(result, "Two");
			break;
		case '3':
			strcpy(result, "Thr");
			break;
		case '4':
			strcpy(result, "Fou");
			break;
		case '5':
			strcpy(result, "Fiv");
			break;	
		case '6':
			strcpy(result, "Six");
			break;
		case '7':
			strcpy(result, "Sev");
			break;
		case '8':
			strcpy(result, "Eig");
			break;
		case '9':
			strcpy(result, "Nin");
			break;
	}
}

void yyerror(const char *str) {
    fprintf(stderr, "Error: %s\n", str);
}

int main() {
    yyparse();
}