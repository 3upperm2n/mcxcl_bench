#!/bin/sh

grep '^benchmark' $@  | awk '{print $3}' | xargs -n 3 | column -t -s' ' | sed -e 's/  */\t/g'

