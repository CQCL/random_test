#!/bin/bash

FILE=$1
DIR="$(dirname "${FILE}")" ;

COUNT_BYTES=$(<${FILE} wc -c)
COUNT_BITS=$(( COUNT_BYTES * 8))

echo ${COUNT_BITS} ${COUNT_BYTES}

set -x

./ent ${FILE} > "${DIR}/test_ent.log"
cat ${FILE} | ./pr stdin64 -tlmin 25 -tlmax 30 > "${DIR}/test_practrand.log"

./testu ${FILE} ${COUNT_BITS} small > "${DIR}/test_small.log"
./testu ${FILE} ${COUNT_BITS} alpha  > "${DIR}/test_alpha.log"
./testu ${FILE} ${COUNT_BITS} rabbit  > "${DIR}/test_rabbit.log"

echo -n "Running Dieharder..."
set +x
while :; do cat ${FILE} || exit; done | dieharder -a -g 200 | head -n 26 > "${DIR}/test_dieharder.log"
echo "done."
while :; do cat ../stat_tests/data/launch/1/entropy1.bin || exit; done | dieharder -a -g 200 | head -n 26 > "../stat_tests/data/launch/1/test_dieharder.log"
