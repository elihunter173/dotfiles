#!/usr/bin/env sh

# This is a modified version of https://askubuntu.com/a/279014

for x in $(seq 0 8); do
    for i in $(seq 30 37); do
        for a in $(seq 40 47); do 
            echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "
        done
        echo
    done
done
echo ""
