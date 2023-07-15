#include <stdio.h>

int main()
{
    extern char *_say();
    _say();
    return 0;
}