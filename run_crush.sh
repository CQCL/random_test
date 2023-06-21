#!/bin/bash

FILE=$1
DIR="$(dirname "${FILE}")" ;

BASE="$(dirname "$(realpath $0)")"

COUNT_BYTES=$(<${FILE} wc -c)
COUNT_BITS=$(( COUNT_BYTES * 8))

echo ${COUNT_BITS} ${COUNT_BYTES}

set -x

$BASE/testu ${FILE} ${COUNT_BITS} crush > "${DIR}/test_crush.log"
echo "done."
