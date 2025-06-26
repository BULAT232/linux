#!/bin/bash


if [ "$#" -lt 3 ]; then
  echo "Использование: $0 /path/to/dir extension N [stopwords.txt]"
  exit 1
fi

DIR="$1"
EXT="$2"
TOP_N="$3"


if [ ! -d "$DIR" ]; then
  echo "Ошибка: директория '$DIR' не существует."
  exit 1
fi

declare -A WORD_FREQ


while IFS= read -r file; do
  
  if [ ! -s "$file" ]; then
    continue
  fi

  words=$(grep -ohE '\w+' "$file" | tr '[:upper:]' '[:lower:]')

  for word in $words; do    
    ((WORD_FREQ["$word"]++))
  done
done < <(find "$DIR" -type f -name "*.$EXT")

if [ "${#WORD_FREQ[@]}" -eq 0 ]; then
  echo "Нет подходящих данных для анализа."
  exit 0
fi


for word in "${!WORD_FREQ[@]}"; do
  echo "$word: ${WORD_FREQ[$word]}"
done | sort -t ':' -k2 -nr | head -n "$TOP_N"
