#include <stdio.h>

#define SIZE 4096
#define is_one(X) ((X) - '0')

int main(int argc, char **argv) {
	if (argc != 3) {
		puts("Usage: ./pack INPUT OUTPUT");
		return 1;
	}

	FILE *input = fopen(argv[1], "r");
	FILE *output = fopen(argv[2], "w");

	char in_buf[8*SIZE];
	char out_buf[SIZE];
	while (!feof(input)) {
		int size = fread(in_buf, 1, 8*SIZE, input) / 8;
		for (int i = 0; i < size; ++i) {  // TODO if file length not multiple of 8
			int j = 8*i;
			out_buf[i] = is_one(in_buf[j]) << 7 |
				is_one(in_buf[j+1]) << 6 |
				is_one(in_buf[j+2]) << 5 |
				is_one(in_buf[j+3]) << 4 |
				is_one(in_buf[j+4]) << 3 |
				is_one(in_buf[j+5]) << 2 |
				is_one(in_buf[j+6]) << 1 |
				is_one(in_buf[j+7]);
		}
		fwrite(out_buf, 1, size, output);
	}
	return 0;
}