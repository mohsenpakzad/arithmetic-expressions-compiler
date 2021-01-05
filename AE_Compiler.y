%{ 
    #include"headers.h"

    int yylex();
    void yyerror(const char *);
    extern int currentVariableIndex;// unnecessary
    struct Phrase nextVar();
    void digitName(char *, char);
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
    /* | character_number NEW_LINE {
        printf("Assign %s to t%d;\n", $1.value, currentVariableIndex);
        printf("print t%d\n",currentVariableIndex);
        puts("------------------------------------------");
    } */
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
    OND_DIGIT_NUMBER {
        char newNumber[MAX_PHARASE_VALUE_SIZE];
        char temp[MAX_NUM_SIZE];
        digitName(temp, $1.value[0]);
        sprintf(newNumber, "%s", temp);
        $$ = newPhrase(newNumber);
    } 
    | TWO_DIGIT_NUMBER {
        char newNumber[MAX_PHARASE_VALUE_SIZE];
        char temp1[MAX_NUM_SIZE];
        digitName(temp1, $1.value[0]);
        char temp2[MAX_NUM_SIZE];
        digitName(temp2, $1.value[1]);
        sprintf(newNumber, "%sTen_%s", temp1, temp2);
        $$ = newPhrase(newNumber);
    } 
    | THREE_DIGIT_NUMBER {
        char newNumber[MAX_PHARASE_VALUE_SIZE];
        char temp1[MAX_NUM_SIZE];
        digitName(temp1, $1.value[0]);
        char temp2[MAX_NUM_SIZE];
        digitName(temp2, $1.value[1]);
        char temp3[MAX_NUM_SIZE];
        digitName(temp3, $1.value[2]);
        sprintf(newNumber, "%sHun_%sTen_%s", temp1, temp2, temp3);
        $$ = newPhrase(newNumber);
    } 
    | FOUR_DIGIT_NUMBER {
        char newNumber[MAX_PHARASE_VALUE_SIZE];
        char temp1[MAX_NUM_SIZE];
        digitName(temp1, $1.value[0]);
        char temp2[MAX_NUM_SIZE];
        digitName(temp2, $1.value[1]);
        char temp3[MAX_NUM_SIZE];
        digitName(temp3, $1.value[2]);
        char temp4[MAX_NUM_SIZE];
        digitName(temp4, $1.value[3]);
        sprintf(newNumber, "(%s)Tou_%sHun_%sTen_%s", temp1, temp2, temp3, temp4);
        $$ = newPhrase(newNumber);
    } 
    | FIVE_DIGIT_NUMBER {
        char newNumber[MAX_PHARASE_VALUE_SIZE];
        char temp1[MAX_NUM_SIZE];
        digitName(temp1, $1.value[0]);
        char temp2[MAX_NUM_SIZE];
        digitName(temp2, $1.value[1]);
        char temp3[MAX_NUM_SIZE];
        digitName(temp3, $1.value[2]);
        char temp4[MAX_NUM_SIZE];
        digitName(temp4, $1.value[3]);
        char temp5[MAX_NUM_SIZE];
        digitName(temp5, $1.value[4]);
        sprintf(newNumber, "(%sTen_%s)Tou_%sHun_%sTen_%s", temp1, temp2, temp3, temp4, temp5);
        $$ = newPhrase(newNumber);
    } 
    | SIX_DIGIT_NUMBER {
        char newNumber[MAX_PHARASE_VALUE_SIZE];
        char temp1[MAX_NUM_SIZE];
        digitName(temp1, $1.value[0]);
        char temp2[MAX_NUM_SIZE];
        digitName(temp2, $1.value[1]);
        char temp3[MAX_NUM_SIZE];
        digitName(temp3, $1.value[2]);
        char temp4[MAX_NUM_SIZE];
        digitName(temp4, $1.value[3]);
        char temp5[MAX_NUM_SIZE];
        digitName(temp5, $1.value[4]);
        char temp6[MAX_NUM_SIZE];
        digitName(temp6, $1.value[5]);
        sprintf(newNumber, "(%sHun_%sTen_%s)Tou_%sHun_%sTen_%s", temp1, temp2, temp3, temp4, temp5, temp6);
        $$ = newPhrase(newNumber);
    } 
    | LEFT_PARENTHESES expr RIGHT_PARENTHESES {
        $$ = $2;
    }
;
%%
int currentVariableIndex = 0;

struct Phrase nextVar() {
    char newVar[MAX_PHARASE_VALUE_SIZE];
    sprintf(newVar, "t%d", currentVariableIndex++);
    return newPhrase(newVar); 
}

void digitName(char *str, char digit){
	switch(digit)
	{
		case '0':
			strcpy(str, "Zero");
            break;
		case '1':
			strcpy(str, "One");
			break;
		case '2':
			strcpy(str, "Two");
			break;
		case '3':
			strcpy(str, "Three");
			break;
		case '4':
			strcpy(str, "Four");
			break;
		case '5':
			strcpy(str, "Five");
			break;	
		case '6':
			strcpy(str, "Six");
			break;
		case '7':
			strcpy(str, "Sevev");
			break;
		case '8':
			strcpy(str, "Eight");
			break;
		case '9':
			strcpy(str, "Nine");
			break;
	}
}

void yyerror(const char *str) {
    fprintf(stderr, "Error: %s\n", str);
}

int main() {
    yyparse();
}