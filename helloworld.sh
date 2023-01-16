#!/bin/bash

while getopts ":a:b:c:" opt; do
  case $opt in
    a) a="$OPTARG"
    ;;
    b) b="$OPTARG"
    ;;
    c) c="$OPTARG"    
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done