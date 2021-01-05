#define MAX_PHARASE_VALUE_SIZE 1000

struct Phrase {
    char value[MAX_PHARASE_VALUE_SIZE];
};

struct Phrase newPhrase(char *value);