#!/bin/bash

FILE=$1
DIR="$(dirname "${FILE}")" ;

BASE="$(dirname "$(realpath $0)")"

function log2 {
    local x=0
    for (( y=$1-1 ; $y > 0; y >>= 1 )) ; do
        let x=$x+1
    done
    echo $x
}

COUNT_BYTES=$(<${FILE} wc -c)
COUNT_BITS=$(( COUNT_BYTES * 8))
COUNT_LOG_BITS=$(log2 $COUNT_BITS)

echo $COUNT_BITS $COUNT_BYTES $COUNT_LOG_BITS

PR_STEPS=5
MIN_PR=$(( COUNT_LOG_BITS - PR_STEPS ))
MAX_PR=$(( MIN_PR + PR_STEPS - 1 ))

set -x

time $BASE/ent $FILE > "$DIR/test_ent.log"
time (cat $FILE | $BASE/pr stdin64 -tlmin $MIN_PR -tlmax $MAX_PR > "$DIR/test_practrand.log")

time $BASE/testu $FILE $COUNT_BITS rabbit  > "$DIR/test_rabbit.log"

echo -n "Running Dieharder..."
set +x
time while :; do cat $FILE || exit; done | dieharder -a -g 200 | head -n 26 > "$DIR/test_dieharder.log"
echo "done."
