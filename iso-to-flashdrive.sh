#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Usage: $0 <file>"
    exit 1
fi
FILE=$1

if [ ! -f "$FILE" ]; then
  echo "$FILE is not found."
  exit 1
fi

echo sudo dd if=${FILE} of=/dev/sdc bs=4M status=progress && sync

exit 0
