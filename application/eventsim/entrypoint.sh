#! /bin/bash
echo "Using config file.. $@";
./eventsim.sh -c "$@" --from 60 --nusers 30 --growth-rate 0.01 -k 1 ./output