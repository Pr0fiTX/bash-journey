#!/bin/bash

APATH="/home/notforu/.zshrc"

#TODO: better output
echo "=> Нашёл следующие alias:"
grep '^alias' "$APATH" | cut  -d ' ' -f 2-
