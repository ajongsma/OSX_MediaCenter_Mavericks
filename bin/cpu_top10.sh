#!/usr/bin/env bash

ps -eo pcpu,pmem,size,args | sort -k 1 -r | head -10
