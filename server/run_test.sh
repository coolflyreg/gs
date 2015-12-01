#!/bin/bash

export SERVER_NAME=newfengshen
export OS=$(uname -s)

export basepath=$(cd `dirname $0`; pwd)
"$basepath/../3rd/skynet/skynet" "$basepath/test/config"
