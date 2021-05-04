#pragma MIME image/png

struct pngSignature{
	u8 highBitByte;
	char signature[3];
	char dosLineEnding[2];
	char dosEOF;
	char unixLineEnding;
};

pngSignature header @ 0x00;

bitfield CRC{
	crc:32;
};

struct chunkIHDR{
	be u32 chunkLength [[color("00000000"), comment("Chunk length (excluding chunk name)")]];
	char chunkName[4];
	be u32 width [[comment("Image width")]];
	be u32 height [[comment("Image height")]];
	u8 bitDepth;
	u8 colorType;
	u8 compressionMethod;
	u8 filterMethod;
	u8 interlaceMethod [[comment("values 0 \"no interlace\" or 1 \"Adam7 interlace\"")]];
	CRC CRC32 [[color("00000000"), comment("cyclic redundancy code/checksum; 4 bytes")]];
};

chunkIHDR IHDR @ 0x08 [[name("IHDR chunk")]];