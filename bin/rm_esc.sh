#!/bin/bash

# remove escape sequence from strings.
cat $@ | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"
