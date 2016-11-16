#!/bin/bash

ag --follow --nocolor --nogroup -g '' | sort -d
