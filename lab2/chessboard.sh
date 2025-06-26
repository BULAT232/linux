#!/bin/bash

read -p "Введите размер доски (например, 8): " size
if ! [[ $size =~ ^[0-9]+$ ]] || [ "$size" -le 0 ]; then
    echo "Ошибка! Введите положительное целое число."
    exit 1
fi

WHITE_BG="\e[47m  \e[0m"
BLACK_BG="\e[40m  \e[0m"

for ((i=0; i < size; i++)); do
    for ((j=0; j < size; j++)); do
        if $(( (i+j)%2==0 )) &>/dev/null
        then
            echo -ne "$WHITE_BG"
        else
            echo -ne "$BLACK_BG"
        fi
    done
    echo
done
