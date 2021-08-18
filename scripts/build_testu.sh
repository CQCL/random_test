#/bin/bash

mkdir testu01
cd testu01
basedir=`pwd`

curl -OL http://simul.iro.umontreal.ca/testu01/TestU01.zip
unzip -q TestU01.zip
cd TestU01-1.2.3
./configure --prefix="$basedir"
make -j 6
make -j 6 install

cd ..
mkdir lib-so
mv lib/*.so lib-so/.

PWD=$(pwd)

export LD_LIBRARY_PATH=$PWD/lib:${LD_LIBRARY_PATH}
export LIBRARY_PATH=$PWD/lib:${LIBRARY_PATH}
export C_INCLUDE_PATH=$PWD/include:${C_INCLUDE_PATH}

gcc -std=c99 -Wall -O3 -o ../testu ../scripts/test.c -Iinclude -Llib -ltestu01 -lprobdist -lmylib -lm
cd ..
rm -rf testu01