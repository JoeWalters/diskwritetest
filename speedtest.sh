#!/bin/bash
TIME=0
TESTFILE=testfile.img

for i in {1..3}; do
rm -f $TESTFILE
dd if=/dev/zero of=./$TESTFILE bs=4k iflag=fullblock,count_bytes count=10G > /tmp/ddresults-$i.log 2>&1
REP=$(awk '/11 GB/ {print $8}' /tmp/ddresults-$i.log)
TIME=$(echo $TIME + $REP | bc)
echo "Rep $i done - $REP
"
sleep 3
done
rm -f $TESTFILE
echo $(echo $TIME/3 | bc) average
