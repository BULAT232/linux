#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Использование: $0 <директория>"
    exit 1
fi

DIR="$1"

if [ ! -d "$DIR" ]; then
    echo "Ошибка: $DIR не существует"
    exit 1
fi

cd "$DIR" || exit 1

for file in *; do
    [ -f "$file" ] || continue
    if [[ "$file" == *.* ]]; then
        ext="${file##*.}"
        [ "$ext" = "$file" ] && ext="no_extension"
    else
        ext="no_extension"
    fi
    mkdir -p "$ext"
    mv -- "$file" "$ext/"
done
