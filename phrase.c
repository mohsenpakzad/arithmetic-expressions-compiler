#include<string.h>
#include"phrase.h"

struct Phrase newPhrase(char *value) {
    struct Phrase pharse;
    strcpy(pharse.value, value);
    return pharse;
}