// Adapted from TestU01 manual, Figure 2.2, Figure 2.4

#include "TestU01.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

FILE *fp;
unsigned long total_bytes;

unsigned int from_file (void) {
    unsigned int value;
    size_t n_bytes = fread(&value, sizeof(unsigned int), 1, (FILE*)fp);
    if (n_bytes != 1) {
        // rewinding
        fseek(fp, 0, SEEK_SET);
    }
    total_bytes += 1;

    return value;
}

int main(int argc, char *argv[])
{
    if (argc != 4) {
        printf("test_u <filename> <n_bits> [alpha/small/crush/rabbit]");
        return 1;
    }
    char *filename = argv[1];
    unsigned long n_bits = atol(argv[2]);
    char *mode = argv[3];

    if (strcmp(mode, "crush") & strcmp(mode, "small") & strcmp(mode, "alpha") & strcmp(mode, "rabbit")) {
        printf("test_u <filename> [alpha/small/crush/rabbit]");
        return 2;
    }

    fp = fopen(filename, "rb");
    // Create TestU01 PRNG object for our generator
    unif01_Gen* gen = unif01_CreateExternGenBits("From File", from_file);

    // Run the tests.
    if (strcmp(mode, "crush") == 0) {
        bbattery_Crush(gen);
        printf("%lu bytes used in total.\n", total_bytes);
    } else if (strcmp(mode, "small") == 0) {
        bbattery_SmallCrush(gen);
        printf("%lu bytes used in total.\n", total_bytes);
    } else if (strcmp(mode, "alpha") == 0) {
        bbattery_AlphabitFile(filename, n_bits);
    } else if (strcmp(mode, "rabbit") == 0) {
        bbattery_RabbitFile(filename, n_bits);
    }

    // Clean up.
    unif01_DeleteExternGenBits(gen);

    fclose(fp);
    return 0;
}