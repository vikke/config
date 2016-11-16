#!/bin/bash
ag  --nopager --nocolor --nogroup  $@ | sort -d
