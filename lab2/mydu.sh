#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Использование: $0 <директория>"
    exit 1
fi

DIR="$1"

if [ ! -d "$DIR" ]; then
    echo "Ошибка: $DIR не существует или не директория"
    exit 1
fi

human_readable() {
    local size=$1
    if [ "$size" -ge 1073741824 ]; then
        awk "BEGIN {printf \"%.2fG\", $size/1073741824}"
    elif [ "$size" -ge 1048576 ]; then
        awk "BEGIN {printf \"%.2fM\", $size/1048576}"
    elif [ "$size" -ge 1024 ]; then
        awk "BEGIN {printf \"%.2fK\", $size/1024}"
    else
        echo "${size}B"
    fi
}

find "$DIR" -mindepth 1 -maxdepth 1 -type d | while read subdir; do
    total_bytes=$(find "$subdir" -type f -exec stat -f%z {} + | awk '{s+=$1} END {print s+0}')
    echo "$subdir: $(human_readable $total_bytes)"
done

main_bytes=$(find "$DIR" -maxdepth 1 -type f -exec stat -f%z {} + | awk '{s+=$1} END {print s+0}')
echo "$DIR: $(human_readable $main_bytes)"
