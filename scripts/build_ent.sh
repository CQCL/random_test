#/bin/bash
mkdir ENT
cd ENT
wget https://www.fourmilab.ch/random/random.zip
unzip random.zip -d build
cd build
make
cp ./ent ../../
cd ../..
rm -rf ENT