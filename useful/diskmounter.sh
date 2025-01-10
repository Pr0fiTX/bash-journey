#!/bin/bash

# Инициализируем переменные
DISK_LOC="/dev/sda1"
DISK_AFTER_LOC="/run/media/"$USER""
USER="notforu"

if [ "$1" == "-h" ]; then
    echo "!> Вот все доступные параметры: "
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo "=> -m <- примонтироавть диск"
    echo "=> -u <- размонтировать диск"
    echo "=> -l <- вывести содержимое каталога "$DISK_AFTER_LOC""
    echo "=> -h <- вывести этот список"
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    exit 0
elif [ "$1" == "-m" ]; then
    if [ -e "$DISK_LOC" ]; then
        echo "=> Диск обнаружен."
        read -p "?> Введите название диска: " DISK_NAME
        # Создаём папку для монтирования
        sudo mkdir /run/media/"$USER"/"$DISK_NAME"
        # Монтируем
        sudo mount /dev/sda1 /run/media/"$USER"/"$DISK_NAME"
        # Вызов системного уведомления при успехе
        notify-send -i ~/Pictures/For\ Fastfetch/fb12280a81cb08364fd22ae999966be.png -u critical "Успех!" "SSD был примонтирован в /run/media/"$USER"/SSD_1TB."
        exit 0
    else 
        # Неудача
        notify-send -i ~/Pictures/For\ Fastfetch/fb12280a81cb08364fd22ae999966be.png -u critical "Диска нет." "Скрипт ничего не сделал, проверете диск."
        exit 1
    fi
elif [ "$1" == "-l" ]; then
    if [ -d "$DISK_AFTER_LOC" ]; then
        echo "=> Список дисков:"
        ls -la "$DISK_AFTER_LOC"
        exit 0
    else    
        echo "!> Ничего не примонтировано."
        exit 0
    fi
elif [ "$1" == "-u" ]; then
    read -p "?> Введите имя диска: " DISK_NAME
    echo "=> Размонтирую..."
    if [ -e "$DISK_AFTER_LOC"/"$DISK_NAME" ]; then
        sudo umount "$DISK_AFTER_LOC"/"$DISK_NAME"
        sudo rm -d "$DISK_AFTER_LOC"/"$DISK_NAME"
        notify-send -i ~/Pictures/For\ Fastfetch/fb12280a81cb08364fd22ae999966be.png -u critical "Успех!" "Диск был успешно размонтирован."
        exit 0
    else
        notify-send -i ~/Pictures/For\ Fastfetch/fb12280a81cb08364fd22ae999966be.png -u critical "Ошибка!" "Такой директории не существует."
        exit 2
    fi
else
    echo "!> Неверный параметр! Введите флаг -h чтобы увидеть возможности программы."
    exit 111
fi