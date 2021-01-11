#include <string.h>
#include "string.h"

struct String newString(char *value) {
    struct String string;
    strcpy(string.value, value);
    return string;
}