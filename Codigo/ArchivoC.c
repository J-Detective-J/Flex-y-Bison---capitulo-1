#include <stdio.h>
#include <ctype.h>

int main(void)
{
    int c, inword = 0;
    long chars = 0, words = 0, lines = 0;

    while ((c = getchar()) != EOF) {
        chars++;

        if (c == '\n')
            lines++;

        if (isspace(c))
            inword = 0;
        else if (!inword) {
            inword = 1;
            words++;
        }
    }

    printf("%8ld%8ld%8ld\n", lines, words, chars);
    return 0;
}
