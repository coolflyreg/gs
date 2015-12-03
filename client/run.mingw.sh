#!/bin/bash

export basepath=$(cd `dirname $0`; pwd)
cd "$basepath"

"$basepath/../../skynet/3rd/lua/lua" "$basepath/client.lua" -p mingw -b "$basepath"
