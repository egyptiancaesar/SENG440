/**
 *  @sGroupID:     type of file format: RIFF - generic container format
 *                , stores data in tagged chunks
 *  @dwFileLength: file size in bytes, minus 8 bits (ignores RIFF & WAVE tags)
 *  @sRiffType:    to specify Riff file type, always "WAVE"
 */
struct WAVE_HEADER{
    unsigned char sGroupID[4]; 
    __uint32_t dwFileLength; 
    unsigned char sRiffType[4]; 
};

/*
 *  @sGroupID:          Indicates format chunk of the file
 *  @dwChunkSize:       The length of the chunk, minus sGroupID and dwChunkSize
 *  @wFormatTag:        For wav files, this is always 0x1 and indicates PCM format (0x3 = IEEE FLoat, 0x6 = A-law, 0x7 = mu-law)
 *  @wChannels:         Indicates the number of channels in the audio (0x1 = mono, 0x2 = stereo, etc.)
 *  @dwSamplesPerSec:   The sampling rate (444100 for CDs, 48000 for DATs, etc.)
 *  @dwAvgBytesPerSec:   The number of multichannel audio frames/sec - used to estimate how much memory will be needed
 *  @wBlockAlign:       The number of bytes per multichannel audio fram
 *  @dwBitsPerSample:   Bit depth (bits/sample) for the audio (8,16, or 32)
 */
struct WAVE_FORMAT_CHUNK {
    unsigned char   sGroupID[4];        // sGroupID = "fmt " 
    __uint32_t      dwChunkSize;       // dwChunkSize = /* varies */ 
    __uint8_t       wFormatTag;        // wFormatTag = 1 
    __uint16_t      wChannels;         // wChannels = 1 
    __uint32_t      dwSamplesPerSec;   // dwSamplesPerSec = /* varies */ 
    __uint32_t      dwAvgBytesPerSec;  // dwAvgBytesPerSec = sampleRate * blockAlign 
    __uint16_t      wBlockAlign;       // wBlockAlign = wChannels * (dwBitsPerSample / 8) 
    __uint16_t      dwBitsPerSample;   // dwBitsPerSample = /* varies */
};

/*
 *  @sGroupID:      Indicates next data chunk
 *  @dwChunkSize:   Length of this array
 *  @sampleData:    The Data stored in this array
 */
struct WAVE_DATA_CHUNK {
    unsigned char   sGroupID[4];        // sGroupID = "data"
    __uint32_t      dwChunkSize;        // dwChunkSize = /* varies */
    short           *sampleData;        // sampleData = dwSamplesPerSec * wChannels 
};

/*
 *  @sGroupID:      Indicates next data chunk
 *  @dwChunkSize:   Length of this array
 *  @sampleData:    The Data stored in this array
 */
struct C_WAVE_DATA_CHUNK {
    unsigned char   sGroupID[4];        // sGroupID = "data"
    __uint32_t      dwChunkSize;        // dwChunkSize = /* varies */
    __uint8_t       *sampleData;        // sampleData = dwSamplesPerSec * wChannels 
};

struct WAVE {
    struct WAVE_HEADER          waveHeader;
    struct WAVE_FORMAT_CHUNK    waveFormatChunk;
    struct WAVE_DATA_CHUNK      waveDataChunk;
};

struct C_WAVE {
    struct WAVE_HEADER          waveHeader;
    struct WAVE_FORMAT_CHUNK    waveFormatChunk;
    struct C_WAVE_DATA_CHUNK    cwaveDataChunk;
};

/*
 *FUNCTIONS:
 */

//read the original wave file
void read_wave_file_headers();
void read_wave_file_data_samples();
void read_wave_file();

//Compression and Decompression
void compress_samples();
void decompress_samples();

//Helpers
short sign(short sample);
unsigned short magnitude(short sample);
unsigned short codewordToMagnitude(__uint8_t codeword);
__uint8_t codeword(short sign, unsigned short magnitude);
void LEFormat_32(__uint32_t data);
void LEFormat_16(__uint16_t data);

//Output
void display_samples();
void generate_decompressed_file();
