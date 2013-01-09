#!/bin/bash

# derived from chaplinjs build

# fresh start, removing js compiled from coffee, but keeping vendor
#find js/* ! -iname vendor -print0 | xargs -0 rm -rf

command -v coffee > /dev/null 2>&1 || { echo "CoffeeScript needs to be installed using `npm install -g coffee`" >&2; exit 1; }
command -v r.js > /dev/null 2>&1 || { echo "RequireJS needs to be installed using `npm install -g requirejs`" >&2; exit 1; }

coffee --compile --bare --output ../js ../coffee/

r.js -o rjs-config.js out=../dist/app-rjs.js optimize=none
r.js -o rjs-config.js out=../dist/app-rjs.min.js optimize=uglify

gzip -9 -c ../dist/app-rjs.min.js > ../dist/app-rjs.min.js.gz

# cleaning leftovers, removing js compiled from coffee, but keeping vendor
#find js/* ! -iname vendor -print0 | xargs -0 rm -rf
