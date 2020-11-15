#!/bin/sh

for file in *.c
do
        name=${file%.c}
        gcc -o $name $file
        ./$name
done