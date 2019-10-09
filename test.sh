#!/bin/bash
files=$(ls -a)

echo $files

[[ $files =~ ".git" ]] && echo "1"
