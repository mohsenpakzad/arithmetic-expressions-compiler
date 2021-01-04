#define MAX_PHARASE_VALUE_SIZE 100

struct Phrase {
    int number; //TODO: if number is useless in the end, remove it!
    char value[MAX_PHARASE_VALUE_SIZE]; //TODO: refactor this name!
};

struct Phrase newPhrase(char *value);

struct Phrase newPhraseWithNumber(char *value, int number);