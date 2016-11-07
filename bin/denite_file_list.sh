#!/bin/bash

ag --follow --nocolor --nogroup -g '' | sed -e 's/^/.\//'
