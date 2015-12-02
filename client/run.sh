#!/bin/bash

export basepath=$(cd `dirname $0`; pwd)
cd "$basepath"

"$basepath/../3rd/skynet/3rd/lua/lua" "$basepath/client.lua"
