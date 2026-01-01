#!/bin/bash
search_term="$1"
found=0

for song_file in lyrics/*/*/*; do
    if [[ -f "$song_file" ]]; then
        if grep -iq "$search_term" "$song_file"; then
            artist=$(basename "$(dirname "$(dirname "$song_file")")")
            album=$(basename "$(dirname "$song_file")")
            song=$(basename "$song_file")
            echo "Artist: $artist"
            echo "Album: $album"
            echo "Song: $song"
            echo ""
            found=1
        fi
    fi
done
if [[ $found -eq 0 ]]; then
    echo "Not found"
fi