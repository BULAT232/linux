#!/bin/bash
current_directory() {
    echo "Текущий рабочий каталог:"
    pwd
}

current_process() {
    echo "Текущий запущенный процесс:"
    ps -o pid,comm,user --pid $$
}

home_directory() {
    echo "Домашний каталог:"
    echo ~
}

os_info() {
    echo "Название и версия операционной системы:"
    uname -a
}

available_shells() {
    echo "Доступные оболочки:"
    cat /etc/shells
}

current_users() {
    echo "Текущие пользователи, вошедшие в систему:"
    who
}

user_count() {
    echo "Количество пользователей, вошедших в систему:"
    who | wc -l
}

disk_info() {
    echo "Информация о жестких дисках:"
    df -h
}

cpu_info() {
    echo "Информация о процессоре:"
    cat /proc/cpuinfo | grep "model name" | uniq
}

memory_info() {
    echo "Информация о памяти:"
    free -h
}

filesystem_info() {
    echo "Информация о файловой системе:"
    lsblk
}

packages_info() {
    echo "Информация об установленных пакетах ПО:"
    dpkg-query -l | grep '^ii'
}

all_info() {
    current_directory
    echo "========================================"
    current_process
    echo "========================================"
    home_directory
    echo "========================================"
    os_info
    echo "========================================"
    available_shells
    echo "========================================"
    current_users
    echo "========================================"
    user_count
    echo "========================================"
    disk_info
    echo "========================================"
    cpu_info
    echo "========================================"
    memory_info
    echo "========================================"
    filesystem_info
    echo "========================================"
    packages_info
}

# Функция для сохранения всей информации в файл
save_to_file() {
    local filename=$1
    all_info > "$filename"
    echo "Вся информация сохранена в файл: $filename"
}


if [[ "$1" == "--tofile" ]]; then
    save_to_file "$2"
    exit 0
fi

show_menu() {
    echo "Выберите пункт меню:"
    echo "1. Текущий рабочий каталог"
    echo "2. Текущий запущенный процесс"
    echo "3. Домашний каталог"
    echo "4. Название и версия операционной системы"
    echo "5. Доступные оболочки"
    echo "6. Текущие пользователи"
    echo "7. Количество пользователей"
    echo "8. Информация о жестких дисках"
    echo "9. Информация о процессоре"
    echo "10. Информация о памяти"
    echo "11. Информация о файловой системе"
    echo "12. Информация об установленных пакетах"
    echo "13. Вывести всю информацию"
    echo "14. Сохранить всю информацию в файл"
    echo "15. Выйти"
}

main() {
    while true; do
        show_menu
        read -p "Введите номер пункта: " choice
        case $choice in
            1) current_directory ;;
            2) current_process ;;
            3) home_directory ;;
            4) os_info ;;
            5) available_shells ;;
            6) current_users ;;
            7) user_count ;;
            8) disk_info ;;
            9) cpu_info ;;
            10) memory_info ;;
            11) filesystem_info ;;
            12) packages_info ;;
            13) all_info ;;
            14)
                read -p "Введите имя файла: " filename
                save_to_file "$filename"
                ;;
            15) break ;;
            *) echo "Неверный выбор. Попробуйте снова." ;;
        esac
        echo "Для продолжения нажмите Enter"
        read
    done
}

main
