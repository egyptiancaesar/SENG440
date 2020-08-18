#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "opt_main.h"
/*
* Global Variables
*/
FILE *fp;
struct WAVE wave;
struct C_WAVE cwave;

unsigned char data_array[4];
unsigned long numSamples;
unsigned int sizeOfEachSample;

time_t start, stop;
double compression_time;
double decompression_time;

/*
* main function:
*/
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
    //display_samples();
    start = clock();
    compress_samples();
    stop = clock();
    compression_time = (double) (stop - start) / CLOCKS_PER_SEC;
    
    start = clock();
    decompress_samples();
    stop = clock();
    decompression_time = (double) (stop - start) / CLOCKS_PER_SEC;
     
    printf("Compression Time:\t\t%fs sec\n", compression_time);
    printf("Decompression Time:\t%fs sec\n\n", decompression_time);

    generate_compressed_file();
    generate_decompressed_file();
    
    return 0;
}

void read_wave_file_headers() {
    printf("\nReading Wave Headers:\t\t STARTED\n");

    // Read wave header
    fread(wave.waveHeader.sGroupID,                 	sizeof(wave.waveHeader.sGroupID), 1, fp);
           
    fread(data_array,                                 sizeof(data_array), 1, fp);
    wave.waveHeader.dwFileLength = (data_array[0]) | (data_array[1] << 8) | (data_array[2] << 16) | (data_array[3] << 24);
    
    fread(wave.waveHeader.sRiffType,                	sizeof(wave.waveHeader.sRiffType), 1, fp);
    
    // Read wave format chunk
    fread(wave.waveFormatChunk.sGroupID,            	sizeof(wave.waveFormatChunk.sGroupID), 1, fp);
    
    fread(data_array,                                 sizeof(data_array), 1, fp);
    wave.waveFormatChunk.dwChunkSize = (data_array[0]) | (data_array[1] << 8) | (data_array[2] << 16) | (data_array[3] << 24);
    
    fread(data_array,                                 sizeof(__uint16_t), 1, fp);
    wave.waveFormatChunk.wFormatTag = data_array[0] | data_array[1] << 8;

    fread(data_array,                                 sizeof(__uint16_t), 1, fp);
    wave.waveFormatChunk.wChannels = (data_array[0]) | (data_array[1] << 8);

    fread(data_array,                                 sizeof(data_array), 1, fp);
    wave.waveFormatChunk.dwSamplesPerSec = (data_array[0]) | (data_array[1] << 8) | (data_array[2] << 16) | (data_array[3] << 24);

    fread(data_array,                                 sizeof(data_array), 1, fp);
    wave.waveFormatChunk.dwAvgBytesPerSec = (data_array[0]) | (data_array[1] << 8) | (data_array[2] << 16) | (data_array[3] << 24);
    
    fread(data_array,                                 sizeof(__uint16_t), 1, fp);
    wave.waveFormatChunk.wBlockAlign = (data_array[0]) | (data_array[1] << 8);
    
    fread(data_array,                                 sizeof(__uint16_t), 1, fp);
    wave.waveFormatChunk.dwBitsPerSample = (data_array[0]) | (data_array[1] << 8);


    // Read wave data chunk
    fread(data_array, sizeof(data_array), 1, fp);
    int notData = strcmp(data_array, "data");
    int fileEnd = wave.waveHeader.dwFileLength - 40;
    if (notData) {
        while (fileEnd--  >= 0) {
            fread(data_array, sizeof(data_array), 1, fp);
            notData = strcmp(data_array, "data");
            if (!notData) {
                break;
            }
            fseek(fp, -3, SEEK_CUR);
        }
    }
    strcpy(wave.waveDataChunk.sGroupID, data_array);

    fread(data_array,                              	sizeof(data_array), 1, fp);
    wave.waveDataChunk.dwChunkSize = (data_array[0]) | (data_array[1] << 8) | (data_array[2] << 16) | (data_array[3] << 24);

    printf("Reading Wave Headers:\t\tCOMPLETED\n\n");
}

void read_wave_file_data_samples(){
    if (wave.waveFormatChunk.wFormatTag ==1){
        printf("Reading PCM Data:\t\t STARTED\n");

        numSamples = (wave.waveDataChunk.dwChunkSize * 8)/(wave.waveFormatChunk.dwBitsPerSample * wave.waveFormatChunk.wChannels);
        printf("\tNumber of Samples:\t%  lu\n", numSamples);

        sizeOfEachSample = (wave.waveFormatChunk.dwBitsPerSample * wave.waveFormatChunk.wChannels)/8;
        printf("\tSize of Each Sample:\t%    lu\n",sizeOfEachSample);
        wave.waveDataChunk.sampleData = calloc(numSamples, sizeOfEachSample);

        if (wave.waveDataChunk.sampleData == NULL) {
            printf("\tCould not allocate enough memory to read data samples\n");
            return;
        }

        int i;
        for (i = numSamples; i != 0; i--) {
            fread(data_array, sizeOfEachSample, 1, fp);
            wave.waveDataChunk.sampleData[i] = (data_array[0]) | (data_array[1] << 8);
        }
        printf("Reading PCM data:\t\tComplete\n");
    }else {
        printf("\tOnly use PCM data format please!");
        exit(1);
    }
}

void read_wave_file(){
    read_wave_file_headers();
    read_wave_file_data_samples();
}

void display_samples(){

    printf("Wave Samples...\n\n");

    int i = 0;

    while(i < numSamples){
        printf("Sample %d : %hhx\n", i, wave.waveDataChunk.sampleData[i]); 
        i = i + 1;
    }


}

void compress_samples(){
    short sample;
    short sample_sign;
    unsigned short sample_magnitude;
    unsigned short sample_threshold;
    __uint8_t sample_codeword;

    printf("\n");
    printf("Start audio Compression...\n\n");
    
    //Assign memory for compressed samples array
    cwave.cwaveDataChunk.sampleData = malloc(numSamples * sizeof(char));
    
    if (cwave.cwaveDataChunk.sampleData == NULL) {
        printf("Memory allocation failed.\n");
        return;
    }

    int i = 0;

    while(i<numSamples){
    
        //Convert sample from 16 bit 2's complement to 13 bit signed integer 
        sample = wave.waveDataChunk.sampleData[i] >> 2; 
        //Extract sign of sample
        sample_sign = sign(sample);
        //Calculate absolute value of sample
        sample_magnitude = magnitude(sample);

        //Use 33 bias for magnitude to modify threshold
        sample_threshold = sample_magnitude + 33;
        //Generate codeword
        sample_codeword = codeword(sample_sign, sample_magnitude);
    
        //Bit-wise inversion of codeword
        sample_codeword = ~sample_codeword;
        //Save codeword to sample array    
        cwave.cwaveDataChunk.sampleData[i] = sample_codeword;

        i = i + 1;
    }

    printf("Audio compression successful\n\n");

}

void decompress_samples(){
    short sample;
    short sample_sign;
    unsigned short sample_magnitude;
    unsigned short sample_threshold;
    __uint8_t sample_codeword;

    printf("\n");
    printf("Start audio Decompression...\n\n");

    int i = 0;

    while(i<numSamples){
    
        //Retrieve codeword from sample array
        sample_codeword = cwave.cwaveDataChunk.sampleData[i]; 
        //Bit-wise inversion of codeword        
        sample_codeword = ~sample_codeword;
        //Obtain magnitude from codeword
        sample_threshold = codewordToMagnitude(sample_codeword); 
    
        sample_magnitude = sample_threshold - 33;
        sample_sign = (sample_codeword & 0x80) >> 7;

        //Attach sign
        if(sample_sign){
            sample = sample_magnitude;
        }else{
            sample = -sample_magnitude;
        }
        
        //Restore to 16 bit sample
        wave.waveDataChunk.sampleData[i] = sample << 2;

        i = i + 1;
    }
    
    printf("Audio decompression successful\n\n");

}

unsigned short codewordToMagnitude(__uint8_t codeword){
    int chord = (codeword & 0x70) >> 4;
    int step = codeword & 0x0F;
    int magnitude;
    int bit = 1;
//Extract magnitude from codeword guided by decode table
//Check lower values, large values less likely to occur
    switch(chord) {
        
        default:
        case 0x0:   magnitude = bit | (step << 1) | (bit << 5);
        break;

        case 0x1:   magnitude = (bit << 1) | (step << 2) | (bit << 6);
        break;
        
        case 0x2:   magnitude = (bit << 2) | (step << 3) | (bit << 7);
        break;
        
        case 0x3:   magnitude = (bit << 3) | (step << 4) | (bit << 8);
        break;
        
        case 0x4:   magnitude = (bit << 4) | (step << 5) | (bit << 9);
        break;
        
        case 0x5:   magnitude = (bit << 5) | (step << 6) | (bit << 10);
        break;
        
        case 0x6:   magnitude = (bit << 6) | (step << 7) | (bit << 11);
        break;
        
        case 0x7:   magnitude = (bit << 7) | (step << 8) | (bit << 12);
        break;
    }
    return (unsigned short) magnitude;

}

inline short sign(short sample){
        //0 for -ve and 1 +ve
        return sample >= 0;
}

inline unsigned short magnitude(short sample){
    //Returned magnitude part of sample
    return (unsigned short) (sample < 0 ? -sample : sample);
}

__uint8_t codeword(short sign, unsigned short magnitude){

    int chord = 0x0;
    int step = magnitude;
    __uint8_t codeword;

    int shift;

    for(shift = 5; shift <= 12; shift++){
        //Determine codeword from magnitude, checking smaller values first
        if(magnitude & (1 << shift)) {
            //if most significant bit of 1 occurs here, assign chord and step according to table
            chord = shift - 5;
            //Extract four step bits from magnitude by masking
            step = (magnitude >> (shift - 4)) & 0xF;
            break;
        }        
    
    }

    //Assemble sign, chord and step bits into codeword
    codeword = (sign << 7) | (chord << 4) | step;
    
    return (__uint8_t) codeword;

}

void generate_decompressed_file(){

    printf("Generating decompressed audio to output.wav\n\n");

    FILE *f = fopen("output.wav", "w");
    if (f == NULL) {
        printf("File write failed!\n\n");
        return;
    }

    //Write original header information into output.wav in original byte arrangement
    fwrite(wave.waveHeader.sGroupID, 			sizeof(wave.waveHeader.sGroupID), 1, f);
    
    LE_format_32(wave.waveHeader.dwFileLength); 
    
    fwrite(data_array, 				sizeof(data_array), 1, f);

    fwrite(wave.waveHeader.sRiffType, 		sizeof(wave.waveHeader.sRiffType), 1, f);

    fwrite(wave.waveFormatChunk.sGroupID, 		sizeof(wave.waveFormatChunk.sGroupID), 1, f);

    LE_format_32(wave.waveFormatChunk.dwChunkSize); 
    fwrite(data_array, 				sizeof(data_array), 1, f);

    LE_format_16(wave.waveFormatChunk.wFormatTag); 
    fwrite(data_array, 				sizeof(__uint16_t), 1, f);

    LE_format_16(wave.waveFormatChunk.wChannels); 
    fwrite(data_array, 				sizeof(__uint16_t), 1, f);
    
    LE_format_32(wave.waveFormatChunk.dwSamplesPerSec); 
    fwrite(data_array, 				sizeof(data_array), 1, f);

    LE_format_32(wave.waveFormatChunk.dwAvgBytesPerSec); 
    fwrite(data_array, 				sizeof(data_array), 1, f);

    LE_format_16(wave.waveFormatChunk.wBlockAlign); 
    fwrite(data_array, 				sizeof(__uint16_t), 1, f);

    LE_format_16(wave.waveFormatChunk.dwBitsPerSample); 
    fwrite(data_array, 				sizeof(__uint16_t), 1, f);

    fwrite(wave.waveDataChunk.sGroupID, 		sizeof(wave.waveDataChunk.sGroupID), 1, f);

    LE_format_32(wave.waveDataChunk.dwChunkSize); 
    fwrite(data_array, 				sizeof(data_array), 1, f);

    //Write converted chunks of data to output.wav in original byte arrangement
    
    int i;
    
    for (i = numSamples; i != 0; i--) {
        LE_format_16(wave.waveDataChunk.sampleData[i]);
        fwrite(data_array, sizeOfEachSample, 1, f);
    }

    fclose(f);

    printf("Output Generated -- output.wav\n\n");

}

void generate_compressed_file(){


    printf("Generating compressed audio to compressed_output.wav\n\n");

    FILE *f = fopen("compressed_output.wav", "w");
    if (f == NULL) {
        printf("File write failed!\n\n");
        return;
    }

    //Write original header information into output.wav in original byte arrangement
    fwrite(wave.waveHeader.sGroupID, sizeof(wave.waveHeader.sGroupID), 1, f);

    LE_format_32(wave.waveHeader.dwFileLength);
    fwrite(data_array, sizeof(data_array), 1, f);

    fwrite(wave.waveHeader.sRiffType, sizeof(wave.waveHeader.sRiffType), 1, f);

    fwrite(wave.waveFormatChunk.sGroupID, sizeof(wave.waveFormatChunk.sGroupID), 1, f);

    LE_format_32(wave.waveFormatChunk.dwChunkSize);
    fwrite(data_array, sizeof(data_array), 1, f);

    LE_format_16(wave.waveFormatChunk.wFormatTag);
    fwrite(data_array, sizeof(__uint16_t), 1, f);

    LE_format_16(wave.waveFormatChunk.wChannels);
    fwrite(data_array, sizeof(__uint16_t), 1, f);

    LE_format_32(wave.waveFormatChunk.dwSamplesPerSec);
    fwrite(data_array, sizeof(data_array), 1, f);

    LE_format_32(wave.waveFormatChunk.dwAvgBytesPerSec);
    fwrite(data_array, sizeof(data_array), 1, f);

    LE_format_16(wave.waveFormatChunk.wBlockAlign);
    fwrite(data_array, sizeof(__uint16_t), 1, f);

    LE_format_16(wave.waveFormatChunk.dwBitsPerSample);
    fwrite(data_array, sizeof(__uint16_t), 1, f);

    fwrite(wave.waveDataChunk.sGroupID, sizeof(wave.waveDataChunk.sGroupID), 1, f);

    LE_format_32(wave.waveDataChunk.dwChunkSize);
    fwrite(data_array, sizeof(data_array), 1, f);

    //Write converted chunks of data to output.wav in original byte arrangement
    
    int i;

    for (i = numSamples; i != 0; i--) {
        LE_format_16(cwave.cwaveDataChunk.sampleData[i]);
        fwrite(data_array, sizeof(__uint16_t), 1, f);
    }

    fclose(f);

    printf("Output Generated -- compressed_output.wav\n\n");

}

// converts 32 bit data to little endian form
void LE_format_32(__uint32_t data) {
    data_array[0] =  data & 0x000000FF;
    data_array[1] = (data & 0x0000FF00) >> 8;
    data_array[2] = (data & 0x00FF0000) >> 16;
    data_array[3] = (data & 0xFF000000) >> 24;
}


// converts 16 bit data to little endian form
void LE_format_16(__uint16_t data) {
    data_array[0] =  data & 0x000000FF;
    data_array[1] = (data & 0x0000FF00) >> 8;
}


