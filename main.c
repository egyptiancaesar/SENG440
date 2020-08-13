#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "main.h"

FILE *fp;
struct WAVE wave;
unsigned char buffer[4];

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
    read_wave_file(); 
    return 0;
}

void readWaveFileHeaders() {
    printf("\nBegin Reading Wave Headers:\t...\n");

    // Read wave header
    fread(wave.waveHeader.sGroupID,                 sizeof(wave.waveHeader.sGroupID), 1, fp);
    
    fread(buffer,                                   sizeof(buffer), 1, fp);
    wave.waveHeader.dwFileLength = (buffer[0]) | (buffer[1] << 8) | (buffer[2] << 16) | (buffer[3] << 24);
    
    fread(wave.waveHeader.sRiffType,                sizeof(wave.waveHeader.sRiffType), 1, fp);
    

    // Read wave format chunk
    fread(wave.waveFormatChunk.sGroupID,            sizeof(wave.waveFormatChunk.sGroupID), 1, fp);
    
    fread(buffer,                                   sizeof(buffer), 1, fp);
    wave.waveFormatChunk.dwChunkSize = (buffer[0]) | (buffer[1] << 8) | (buffer[2] << 16) | (buffer[3] << 24);
    
    fread(buffer,                                   sizeof(__uint16_t), 1, fp);
    wave.waveFormatChunk.wFormatTag = buffer[0] | buffer[1] << 8;

    fread(buffer,                                   sizeof(__uint16_t), 1, fp);
    wave.waveFormatChunk.wChannels = (buffer[0]) | (buffer[1] << 8);

    fread(buffer,                                   sizeof(buffer), 1, fp);
    wave.waveFormatChunk.dwSamplesPerSec = (buffer[0]) | (buffer[1] << 8) | (buffer[2] << 16) | (buffer[3] << 24);

    fread(buffer,                                   sizeof(buffer), 1, fp);
    wave.waveFormatChunk.dwAvgBytesPerSec = (buffer[0]) | (buffer[1] << 8) | (buffer[2] << 16) | (buffer[3] << 24);
    
    fread(buffer,                                   sizeof(__uint16_t), 1, fp);
    wave.waveFormatChunk.wBlockAlign = (buffer[0]) | (buffer[1] << 8);
    
    fread(buffer,                                   sizeof(__uint16_t), 1, fp);
    wave.waveFormatChunk.dwBitsPerSample = (buffer[0]) | (buffer[1] << 8);


    // Read wave data chunk
    fread(buffer, sizeof(buffer), 1, fp);
    int notData = strcmp(buffer, "data");
    int fileEnd = wave.waveHeader.dwFileLength - 40;
    if (notData) {
        while (fileEnd--  >= 0) {
            fread(buffer, sizeof(buffer), 1, fp);
            notData = strcmp(buffer, "data");
            if (!notData) {
                break;
            }
            fseek(fp, -3, SEEK_CUR);
        }
    }
    strcpy(wave.waveDataChunk.sGroupID, buffer);

    fread(buffer,                                sizeof(buffer), 1, fp);
    wave.waveDataChunk.dwChunkSize = (buffer[0]) | (buffer[1] << 8) | (buffer[2] << 16) | (buffer[3] << 24);

    printf("Reading Wave Headers:\t\tCOMPLETE\n\n");
}

void read_wave_file(){
    read_wave_file_headers();
}
