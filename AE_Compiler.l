%{ 
    #include "shared.h"
    #include "AE_Compiler.tab.h"

    struct String digitToDigitName(char); /* I (Mohsen) chose this function name! */
    void getDigitName(char *, char);
%}
%option noyywrap


digit [0-9]
one_digit_number      {digit}{1}
two_digit_number      {digit}{2}
three_digit_number    {digit}{3}
four_digit_number     {digit}{4}
five_digit_number     {digit}{5}
six_digit_number      {digit}{6}
%%     
{one_digit_number}    { 
                        char newNumber[MAX_STRING_VALUE_SIZE];
                        sprintf(newNumber, "%s", 
                            digitToDigitName(yytext[0]).value
                        );
                        yylval = newString(newNumber);
                        return NUMBER; 
                      }
{two_digit_number}    { 
                        char newNumber[MAX_STRING_VALUE_SIZE];
                        sprintf(newNumber, "%sTen_%s", 
                            digitToDigitName(yytext[0]).value,
                            digitToDigitName(yytext[1]).value
                        );
                        yylval = newString(newNumber);
                        return NUMBER; 
                      }
{three_digit_number}  {
                        char newNumber[MAX_STRING_VALUE_SIZE];
                        sprintf(newNumber, "%sHun_%sTen_%s", 
                            digitToDigitName(yytext[0]).value,
                            digitToDigitName(yytext[1]).value,
                            digitToDigitName(yytext[2]).value
                        );
                        yylval = newString(newNumber);
                        return NUMBER; 
                      }
{four_digit_number}   {
                        char newNumber[MAX_STRING_VALUE_SIZE];
                        sprintf(newNumber, "(%s)Tou_%sHun_%sTen_%s",
                            digitToDigitName(yytext[0]).value,
                            digitToDigitName(yytext[1]).value,
                            digitToDigitName(yytext[2]).value,
                            digitToDigitName(yytext[3]).value
                        );
                        yylval = newString(newNumber);
                        return NUMBER; 
                      }
{five_digit_number}   {
                        char newNumber[MAX_STRING_VALUE_SIZE];
                        sprintf(newNumber, "(%sTen_%s)Tou_%sHun_%sTen_%s", 
                            digitToDigitName(yytext[0]).value,
                            digitToDigitName(yytext[1]).value,
                            digitToDigitName(yytext[2]).value,
                            digitToDigitName(yytext[3]).value,
                            digitToDigitName(yytext[4]).value
                        );
                        yylval = newString(newNumber);
                        return NUMBER; 
                      }
{six_digit_number}    {
                        char newNumber[MAX_STRING_VALUE_SIZE];
                        sprintf(newNumber, "(%sHun_%sTen_%s)Tou_%sHun_%sTen_%s", 
                            digitToDigitName(yytext[0]).value,
                            digitToDigitName(yytext[1]).value,
                            digitToDigitName(yytext[2]).value,
                            digitToDigitName(yytext[3]).value,
                            digitToDigitName(yytext[4]).value,
                            digitToDigitName(yytext[5]).value
                        );
                        yylval = newString(newNumber);
                        return NUMBER; 
                      }
"+"                   { return PLUS; }
"-"                   { return MINUS; }
"*"                   { return MULTIPLY; }
"/"                   { return DIVIDE; }
"("                   { return LEFT_PARENTHESES; }
")"                   { return RIGHT_PARENTHESES; }
"\n"                  { return NEW_LINE; }
%%
struct String digitToDigitName(char digit) {
    char newNumber[MAX_DIGIT_NAME_SIZE];
    getDigitName(newNumber, digit);
    return newString(newNumber);
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