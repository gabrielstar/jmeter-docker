#!/bin/bash

# exit immediately on error
set -e
freeMem=`awk '/MemFree/ {print int($2/1024) }' /proc/meminfo`
echo "Machine has $freeMem MB memory"
s=$(($freeMem/10*8))
x=$(($freeMem/10*8))
n=$(($freeMem/10*2))

#used by jmeter in startup scripts
export JVM_ARGS="-Xmn${n}m -Xms${s}m -Xmx${x}m"
echo "Staring with JVM args: $JVM_ARGS on `date`" 
echo "jmeter args=$@"
#use none-gui mode by default
jmeter $@

