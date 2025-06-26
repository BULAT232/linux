#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Использование: $0 <что_архивировать> <куда_класть>"
    exit 1
fi

SRC="$1"
DEST="$2"

if [ ! -d "$SRC" ]; then
    echo "Ошибка: $SRC не директория"
    exit 1
fi
if [ ! -d "$DEST" ]; then
    echo "Ошибка: $DEST не директория"
    exit 1
fi

dt=$(date +%Y-%m-%d_%H-%M-%S)
archive="$DEST/backup_$(basename "$SRC")_$dt.tar.gz"

tar -czf "$archive" -C "$(dirname "$SRC")" "$(basename "$SRC")"
if [ $? -eq 0 ]; then
    echo "Резервная копия успешно создана: $archive"
    # Удалить архивы старше 7 дней
    find "$DEST" -name "backup_$(basename "$SRC")_*.tar.gz" -mtime +7 -delete
else
    echo "Ошибка при создании архива"
    exit 2
fi
