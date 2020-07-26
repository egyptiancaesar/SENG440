#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

FILE *fp;

int main(int argc, char** argv){
    if (argc <2){
        perror("\nPlease input a .wav file\n");
            return printf("\nPlease input a .wav file\n");
    }
    printf("\nInput .wav Filename:\t\t%s\n", argv[1]);
    fp = fopen(argv[1], "rb");
    if (fp ==NULL){
        printf("Error opening .wav file %s", argv[1]);
    }
    printf("Hello, World!");
    return 0;
}
