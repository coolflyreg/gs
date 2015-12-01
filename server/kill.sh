#!/bin/bash

#export basepath=$(cd `dirname $0`; pwd)

#kill `cat $basepath/*.pid`;

#rm -rf `$basepath/*.pid`


export basepath=$(cd `dirname $0`; pwd)

ps -ef | grep skynet | grep "$basepath/config" |  grep -v grep | awk '{print $2}' | xargs kill -9
