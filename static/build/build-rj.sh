#!/bin/bash

# derived from chaplinjs build

# fresh start, removing js compiled from coffee, but keeping vendor
find js/* ! -iname vendor -print0 | xargs -0 rm -rf

command -v coffee > /dev/null 2>&1 || { echo "CoffeeScript needs to be installed using `npm install -g coffee`" >&2; exit 1; }
command -v r.js > /dev/null 2>&1 || { echo "RequireJS needs to be installed using `npm install -g requirejs`" >&2; exit 1; }

coffee --compile --bare --output ../js ../coffee/

r.js -o rjs-config.js out=../dist/wisk-rjs.js optimize=none
r.js -o rjs-config.js out=../dist/wisk-rjs.min.js optimize=uglify

gzip -9 -c ../dist/wisk-rjs.min.js > ../dist/wisk-rjs.min.js.gz


# cleaning leftovers, removing js compiled from coffee, but keeping vendor
find js/* ! -iname vendor -print0 | xargs -0 rm -rf
# from: http://stackoverflow.com/questions/1280429/delete-all-files-but-keep-all-directories-in-a-bash-script
# find lists all files that match certain expression in a given directory, recursively.
# -print0 is for printing out names using \0 as delimiter (as any other character, including \n, might be in a path name).
# xargs is for gathering the file names from standard input and putting them as a parameters.
# -0 is to make sure xargs will understand the \0 delimiter.