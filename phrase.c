#include<string.h>
#include"phrase.h"

struct Phrase newPhrase(char *value) {
    struct Phrase pharse;

    strcpy(pharse.value, value);
    pharse.number = 0;

    return pharse;
}

struct Phrase newPhraseWithNumber(char *value, int number) {
     struct Phrase pharse;

    strcpy(pharse.value, value);
    pharse.number = number;

    return pharse;
}