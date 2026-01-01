#!/bin/sh
command=$1

case $command in
        "-w")
                who;;
        "-l")
                ls;;
        "-d")
                date;;
        *)
        echo -e "Parancsok:\n-w\twho\n-l\tls\n-d\tdate";;
esac