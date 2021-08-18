#!/bin/bash

mkdir PractRand
cd PractRand
curl -OL https://downloads.sourceforge.net/project/pracrand/PractRand_0.93.zip
unzip -q PractRand_0.93.zip
curl -sL http://www.pcg-random.org/downloads/practrand-0.93-bigbuffer.patch | patch -p0
g++ -std=c++14 -c src/*.cpp src/RNGs/*.cpp src/RNGs/other/*.cpp -Iinclude -pthread
ar rcs libPractRand.a *.o
rm *.o
g++ -std=c++14 -o ../pr tools/RNG_test.cpp libPractRand.a -Iinclude -pthread
cd ..
rm -rf PractRand