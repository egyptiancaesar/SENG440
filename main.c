#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "main.h"

FILE *fp;
struct WAVE wave;
struct WAVE dwave;
struct C_WAVE cwave;
unsigned char buffer[4];

unsigned long numSamples;
unsigned int sizeOfEachSample;

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
    display_samples();
    compress_samples();
    decompress_samples(); 
    return 0;
}

void read_wave_file_headers() {
    printf("\nReading Wave Headers:\t\t STARTED\n");

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
        dwave.waveDataChunk.sampleData = calloc(numSamples, sizeOfEachSample);
        if (wave.waveDataChunk.sampleData == NULL) {
            printf("\tCould not allocate enough memory to read data samples\n");
            return;
        }

        int i;
        for (i = 0; i < numSamples; i++) {
            fread(buffer, sizeOfEachSample, 1, fp);
            wave.waveDataChunk.sampleData[i] = (buffer[0]) | (buffer[1] << 8);
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
        dwave.waveDataChunk.sampleData[i] = sample << 2;

        i = i + 1;
    }
    
    printf("Audio decompression successful\n\n");

}

unsigned short codewordToMagnitude(__uint8_t codeword){
    int chord = (codeword & 0x70) >> 4;
    int step = codeword & 0x0F;
    int magnitude;

    for(int shift = 12; shift >= 5; shift--){
    
        if (chord == shift - 5){
            
            magnitude = (1 << (shift - 5)) | (step << (shift - 4)) | (1 << shift);
        }
    
    } 

    return (unsigned short) magnitude;
}

short sign(short sample){
    if(sample < 0)
        //+ve sign sample
        return 0;
    else
        //-ve sign sample
        return 1;
}

unsigned short magnitude(short sample){
    if(sample < 0){
        sample = -sample;
    }
    //Returned magnitude part of sample
    return sample;
}

__uint8_t codeword(short sign, unsigned short magnitude){

    int chord;
    int step = magnitude;
    __uint8_t codeword;

    for(int shift = 12; shift >= 5; shift--){
        //compare 1 bit to 12th significant bit of magnitude to determine if first 1 bit occurs there
        //then 11th down to 5th 
        //i.e. magnitude & 1000000000000
        if(magnitude & (1 << shift)) {
            //if most significant bit of 1 occurs here, assign chor and step according to table
            chord = shift - 5;
            //Extract four step bits from magnitude by masking
            step = (magnitude >> (shift - 4)) & 0xF;
            break;
        }        
    
    }

    //Assemble sign, chord and step bits into codeword
    int dec_codeword = (sign << 7) | (chord << 4) | step;
    codeword = (__uint8_t) dec_codeword; 
    
    return codeword;

}

void generate_decompressed_file(){

    printf("Generating decompressed audio to output.wav");

    FILE *f = fopen("output.wav", "w");
    if (f == NULL) {
        printf("File write failed!\n\n");
        return;
    }

    // headers
    fwrite(wave.waveHeader.sGroupID, sizeof(wave.waveHeader.sGroupID), 1, f);
    
    convertIntToLittleEndian(wave.waveHeader.dwFileLength); 
    fwrite(buffer, sizeof(buffer), 1, f);

    fwrite(wave.waveHeader.sRiffType, sizeof(wave.waveHeader.sRiffType), 1, f);

    fwrite(wave.waveFormatChunk.sGroupID, sizeof(wave.waveFormatChunk.sGroupID), 1, f);

    convertIntToLittleEndian(wave.waveFormatChunk.dwChunkSize); 
    fwrite(buffer, sizeof(buffer), 1, f);

    convertShortToLittleEndian(wave.waveFormatChunk.wFormatTag); 
    fwrite(buffer, sizeof(__uint16_t), 1, f);

    convertShortToLittleEndian(wave.waveFormatChunk.wChannels); 
    fwrite(buffer, sizeof(__uint16_t), 1, f);
    
    convertIntToLittleEndian(wave.waveFormatChunk.dwSamplesPerSec); 
    fwrite(buffer, sizeof(buffer), 1, f);

    convertIntToLittleEndian(wave.waveFormatChunk.dwAvgBytesPerSec); 
    fwrite(buffer, sizeof(buffer), 1, f);

    convertShortToLittleEndian(wave.waveFormatChunk.wBlockAlign); 
    fwrite(buffer, sizeof(__uint16_t), 1, f);

    convertShortToLittleEndian(wave.waveFormatChunk.dwBitsPerSample); 
    fwrite(buffer, sizeof(__uint16_t), 1, f);

    fwrite(wave.waveDataChunk.sGroupID, sizeof(wave.waveDataChunk.sGroupID), 1, f);

    convertIntToLittleEndian(wave.waveDataChunk.dwChunkSize); 
    fwrite(buffer, sizeof(buffer), 1, f);

    // data
    for (int i = 0; i < numSamples; i++) {
        convertShortToLittleEndian(wave.waveDataChunk.sampleData[i]);
        // if (i > 18100 && i < 18105) {
        //     printf("Data Buffer: %.2x %.2x %.2x %.2x\n", buffer[0], buffer[1], buffer[2], buffer[3]);
        // }
        fwrite(buffer, sizeOfEachSample, 1, f);
    }

    fclose(f);

    printf("Output Generated -- output.wav\n\n");

}
