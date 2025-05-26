#!/bin/bash

HEIGHT=20
WIDTH=50
CHOICE_HEIGHT=10
TITLE="System Monitor"
MENU="Choose one of the following options:"

while true; do
    OPTIONS=(
        1 "Show CPU Usage"
        2 "Show Memory Usage"
        3 "Show Disk Usage"
        4 "Show Running Processes"
        5 "Show Network Stats"
        6 "Show System Uptime"
        7 "Show System Temperature"
        8 "Show All Stats (Summary View)"
        9 "Exit"
    )

    CHOICE=$(dialog --clear \
                    --backtitle "Linux Shell Project" \
                    --title "$TITLE" \
                    --menu "$MENU" \
                    $HEIGHT $WIDTH $CHOICE_HEIGHT \
                    "${OPTIONS[@]}" \
                    2>&1 >/dev/tty)

    clear
    case $CHOICE in
        1)
            echo "==== CPU USAGE ===="
            top -bn1 | grep "Cpu(s)"
            ;;
        2)
            echo "==== MEMORY USAGE ===="
            free -h
            ;;
        3)
            echo "==== DISK USAGE ===="
            df -h
            ;;
        4)
            echo "==== RUNNING PROCESSES (Top 5 by memory) ===="
            ps aux --sort=-%mem | head -n 6
            ;;
        5)
            echo "==== NETWORK STATS ===="
            ip -c a
            ;;
        6)
            echo "==== SYSTEM UPTIME ===="
            uptime -p
            echo "Started at: $(uptime -s)"
            ;;
        7)
            echo "==== SYSTEM TEMPERATURE ===="
            sensors
            ;;
        8)
            echo "==== SUMMARY VIEW ===="
            echo ">> CPU:"
            top -bn1 | grep "Cpu(s)"
            echo
            echo ">> MEMORY:"
            free -h
            echo
            echo ">> DISK:"
            df -h
            echo
            echo ">> UPTIME:"
            uptime
            echo
            echo ">> TOP PROCESSES:"
            ps aux --sort=-%mem | head -n 6
            echo
            echo ">> NETWORK:"
            ip -c a
            echo
            echo ">> TEMPERATURE:"
            sensors
            ;;
        9)
            echo "Goodbye!"
            break
            ;;
        *)
            echo "Invalid choice. Try again."
            ;;
    esac

    echo
    read -p "Press Enter to return to menu..." temp
done

