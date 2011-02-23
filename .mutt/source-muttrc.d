#!/bin/sh -e

for rc in ~/.mutt/muttrcs/*.rc; do
    test -r "$rc" && echo "source \"$rc\""
done

# vi: ft=sh
