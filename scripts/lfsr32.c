#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define SIZE 4096
#define LFSR_SIZE 32
#define is_one(X) ((X) - '0')

#define GETBIT(x,i) (((x)[(i)>>3] >> ((i)&7)) & 1)
#define SETBIT(x,i,b) do {(x)[(i)>>3] |= ((b)<<((i)&7));} while (0)
#define BITS_TO_BYTES(a) (((a) + 7) / 8)

int poly[128];
char out_buf[SIZE];

int main(int argc, char **argv) {
	if (argc < 4) {
		puts("Usage: ./lfsr32 OUTPUT N_BITS SEED [POLY]");
		return 1;
	}

	FILE *output = fopen(argv[1], "w");
    int n_bits = atoi(argv[2]);
    unsigned int seed = atoi(argv[3]);
    for (int i = 4; i < argc; i++) {
        int pos = atoi(argv[i]);
        if (pos < 0 || pos > LFSR_SIZE) {
            puts("Polynomial indices of range.");
            return 2;
        }
        poly[pos] = 1;
    }

    for (int i = 0; i < n_bits; i += 8 * SIZE) {
		for (int j = 0; j < 8 * SIZE; ++j) { // TODO deal with non-multiples of buffer
            #if DEBUG
            printf("%u", seed & 1);
            #endif
			SETBIT(out_buf, j, seed & 1);
            int next_bit = poly[0];
            for (int k = 1; k <= LFSR_SIZE; ++k) {
                if (poly[k]) {
                    next_bit ^= (seed >> (k - 1)) & 1;
                }
            }
            seed = (next_bit << (LFSR_SIZE - 1)) | (seed >> 1);
		}
		fwrite(out_buf, 1, SIZE, output);
        memset(out_buf, 0, SIZE);
	}
	return 0;
}