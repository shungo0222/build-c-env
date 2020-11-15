#!/bin/bash

Spinner() {
        chars="/-\|"

        while :; do
                for (( i=0; i<${#chars}; i++)); do
                        sleep 0.2
                        echo -en "\e[36mRunning...${chars:$i:1}" "\r\e[m"
                done
        done
}

BuildEnv() {
        docker build --tag $1 .
        status_code=$?

        echo -en "                            " "\r"
        kill $3

        if [ $status_code -gt 0 ]
        then
                echo -e "\e[31mGot Error!!\e[m"
        else
                echo -e "\e[32mCreated!!\e[m"
        fi

        docker run -it --name $2 -v $PWD:/work $1 bash
}

echo -n "Image Name:"
read imageName

echo -n "Container Name:"
read containerName

Spinner &
spi_pid=$!

BuildEnv $imageName $containerName $spi_pid