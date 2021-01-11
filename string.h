#define MAX_STRING_VALUE_SIZE 256

struct String {
    char value[MAX_STRING_VALUE_SIZE];
};

struct String newString(char *value);