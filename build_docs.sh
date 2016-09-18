#!/bin/bash

# Docs by jazzy
# https://github.com/realm/jazzy
# ------------------------------

git submodule update --remote

jazzy -o docs/ \
      --source-directory . \
      --readme README.md \
      -a 'Jesse Squires' \
      -u 'https://twitter.com/jesse_squires' \
      -m 'JSQWebViewController' \
      -g 'https://github.com/jessesquires/JSQWebViewController'
