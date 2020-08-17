#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "opt_main.h"
#include <time.h>

unsigned char buffer[4];
unsigned int size_of_example;

double compress_E_time;
double decompress_E_time;
time_t start, stop;

int main(int argc, char **argv){
    if (argc < 2){
        perror("\nPlease input a valid .wave file\n");
        return printf("\nPlease input a valid .wav file\n");
    }
    pritnf("Input Wave Filename:\t\t%s\n", argv[1]);
    
    FILE *fp;
    fp = fopen(argv[1], "rb");
    if (fp == null){
        return printf ("Error opening file %s", argv[1]);
    }

    struct WAVE *wave;
    struct C_WAVE c_wave;

    __uint64_t numSamples = read_wave_file();


}


void read_wave_file_headers(FILE *fp, struct WAVE *wave){
    printf("\nReading WAve Headers:\t\t STARTED\n");

    //read wave header
    fread(wave->waveHeader.sGroupID,                 sizeof(wave->waveHeader.sGroupID), 1, fp);

    fread(buffer,                                   sizeof(buffer), 1, fp);
    wave->waveHeader.dwFileLength = (buffer[0]) | (buffer[1] << 8) | (buffer[2] << 16) | (buffer[3] << 24);

    fread(wave->waveHeader.sRiffType,                sizeof(wave->waveHeader.sRiffType), 1, fp);


    // Read wave format chunk
    fread(wave->waveFormatChunk.sGroupID,            sizeof(wave->waveFormatChunk.sGroupID), 1, fp);

    fread(buffer,                                   sizeof(buffer), 1, fp);
    wave->waveFormatChunk.dwChunkSize = (buffer[0]) | (buffer[1] << 8) | (buffer[2] << 16) | (buffer[3] << 24);

    fread(buffer,                                   sizeof(__uint16_t), 1, fp);
    wave->waveFormatChunk.wFormatTag = buffer[0] | buffer[1] << 8;

    fread(buffer,                                   sizeof(__uint16_t), 1, fp);
    wave->waveFormatChunk.wChannels = (buffer[0]) | (buffer[1] << 8);

    fread(buffer,                                   sizeof(buffer), 1, fp);
    wave->waveFormatChunk.dwSamplesPerSec = (buffer[0]) | (buffer[1] << 8) | (buffer[2] << 16) | (buffer[3] << 24);

    fread(buffer,                                   sizeof(buffer), 1, fp);
    wave->waveFormatChunk.dwAvgBytesPerSec = (buffer[0]) | (buffer[1] << 8) | (buffer[2] << 16) | (buffer[3] << 24);

    fread(buffer,                                   sizeof(__uint16_t), 1, fp);
    wave->waveFormatChunk.wBlockAlign = (buffer[0]) | (buffer[1] << 8);

    fread(buffer,                                   sizeof(__uint16_t), 1, fp);
    wave->waveFormatChunk.dwBitsPerSample = (buffer[0]) | (buffer[1] << 8);


    // Read wave data chunk
    fread(buffer, sizeof(buffer), 1, fp);
    int notData = strcmp(buffer, "data");
    int fileEnd = wave->waveHeader.dwFileLength - 40;
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
    //at this point, the value stored in the 4bytes held by buffer 
    //defines the SGroup of the dataChunk belonging to this sample
    strcpy(wave->waveDataChunk.sGroupIG, buffer);

    fread(buffer,                                sizeof(buffer), 1, fp);
    wave->waveDataChunk.dwChunkSize = (buffer[0]) | (buffer[1] << 8) | (buffer[2] << 16) | (buffer[3] << 24);

    printf("Reading Wave Headers:\t\tCOMPLETE\n\n");
}

__uint64_t read_wave_file(FILE* fp, struct WAVE *wave){
    read_wave_file_headers(fp, wave);
}


