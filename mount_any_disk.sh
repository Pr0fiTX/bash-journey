#!/bin/bash

# Инициализируем переменные
DISK_LOC="/dev/sda1"
DISK_AFTER_LOC="/run/media/"$USER""
USER="notforu"

read -p "?> Выберете действие (список дисков(l), размонтировать(u), смонтировать(m), выход(q)): " start_act
if [ "$start_act" == "m" ]; then
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
elif [ "$start_act" == "l" ]; then
    echo "=> Список дисков:"
    ls -la "$DISK_AFTER_LOC"
    exit 0
elif [ "$start_act" == "u" ]; then
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
elif [ "$start_act" == "q" ]; then
    echo "=> Скрипт завершён"
    exit 0
else 
    echo "!> Недопустимый ввод!"
fi