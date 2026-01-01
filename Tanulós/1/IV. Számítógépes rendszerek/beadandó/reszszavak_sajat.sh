#!/bin/bash

INPUT_FILE="$1"

TOP_COUNT=-1
TOP_WORD=""

for WORD in $(cat "$INPUT_FILE"); do
    COUNT=$(grep -F "$WORD" "$INPUT_FILE" | wc -l)
    if [ $COUNT -gt $TOP_COUNT ]; then
        TOP_COUNT=$COUNT
        TOP_WORD=$WORD
    fi
done

TOP_COUNT=$((TOP_COUNT - 1))

echo "A leggyakoribb részszó: $TOP_WORD, előfordulások száma: $TOP_COUNT"