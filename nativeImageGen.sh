#!/bin/bash

while getopts c: flag
do
    case "${flag}" in
        c) CLASS_NAME=${OPTARG};;
        *) ;;
    esac
done

#Compile all java classes and build a Jar file to be put into apps dir
javac src/$CLASS_NAME/*.java
cd /jdwp/src && jar -cfe $CLASS_NAME.jar $CLASS_NAME/$CLASS_NAME $CLASS_NAME/*.class && cp $CLASS_NAME.jar /jdwp/apps

IMAGE_NAME=$CLASS_NAME
SOURCES_DIR=/jdwp/apps/${CLASS_NAME}sources

# Usage: native-image [options] class [imagename] [options]
#    or  native-image [options] -jar jarfile [imagename] [options]
cd /jdwp/apps && $GRAALVM_HOME/bin/native-image -g -O0 -H:-OmitInlinedMethodDebugLineInfo -cp $CLASS_NAME.jar -H:Class=$CLASS_NAME.$CLASS_NAME -H:Name=$IMAGE_NAME -H:DebugInfoSourceCacheRoot=$SOURCES_DIR

#Exit with status of process
exit $?
