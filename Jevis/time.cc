#include <unistd.h>
#include <string.h>
#include <stdio.h>
int main()
{
    int i = 0;
    char bar[102];
    memset( bar, 0, 102*sizeof(char) );
    const char *label = "|/-\\";
    while (i <= 100)
    {
        printf("[%-101s] [%d%%][%c] \r", bar, i, label[i%4]);
        fflush(stdout);
        bar[i] = '#';
        i++;
        bar[i] = 0;
        usleep(100000);
    }
    printf("\n");
    return 0;
}

